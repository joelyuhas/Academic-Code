# Copyright 2017 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Example using census data from UCI repository."""

# pylint: disable=g-bad-import-order
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function


import argparse
import os
import pprint
import tempfile
import sys

from absl import app
from absl import flags

# GOOGLE-INITIALIZATION

import apache_beam as beam
#import tensorflow as tf
import tensorflow.compat.v1 as tf
import tensorflow_transform as tft
import tensorflow_transform.beam as tft_beam
from tensorflow_transform.tf_metadata import dataset_metadata
from tensorflow_transform.tf_metadata import schema_utils

import numpy as np
import tensorflow_privacy

from tensorflow_privacy.privacy.analysis import privacy_ledger
from tensorflow_privacy.privacy.analysis.rdp_accountant import compute_rdp_from_ledger
from tensorflow_privacy.privacy.analysis.rdp_accountant import get_privacy_spent
from tensorflow_privacy.privacy.optimizers import dp_optimizer
from tensorflow_privacy.privacy.dp_query import gaussian_query

graph = tf.get_default_graph()



#tf.reset_default_graph() 
#tf.compat.v1.enable_eager_execution()
tf.compat.v1.disable_eager_execution()

# Constants used for training.  Note that the number of instances will be
# computed by tf.Transform in future versions, in which case it can be read from
# the metadata.  Similarly BUCKET_SIZES will not be needed as this information
# will be stored in the metadata for each of the columns.  The bucket size
# includes all listed categories in the dataset description as well as one extra
# for "?" which represents unknown.
TRAIN_BATCH_SIZE = 128
TRAIN_MICROBATCH_SIZE = 1
TRAIN_NUM_EPOCHS = 200
NUM_TRAIN_INSTANCES = 32561
NUM_TEST_INSTANCES = 16281

# Names of temp files
TRANSFORMED_TRAIN_DATA_FILEBASE = 'train_transformed'
TRANSFORMED_TEST_DATA_FILEBASE = 'test_transformed'
EXPORTED_MODEL_DIR = 'exported_model_dir'

#AdagradOptimizer = tf.train.AdagradOptimizer
#YGradientDescentOptimizer = dp_optimizer.make_optimizer_class(AdagradOptimizer)

#GradientDescentOptimizer = tf.train.GradientDescentOptimizer 
#YGradientDescentOptimizer = dp_optimizer.make_optimizer_class(GradientDescentOptimizer)

#AdamOptimizer = tf.train.AdamOptimizer
#YGradientDescentOptimizer = dp_optimizer.make_optimizer_class(AdamOptimizer)


FLAGS = flags.FLAGS

FLAGS(sys.argv)

flags.DEFINE_boolean(
    'dpsgd', True, 'If True, train with DP-SGD. If False, '
    'train with vanilla SGD.')
flags.DEFINE_float('learning_rate', .15, 'Learning rate for training')
flags.DEFINE_float('noise_multiplier', 1.1,
                   'Ratio of the standard deviation to the clipping norm')
flags.DEFINE_float('l2_norm_clip', 1.0, 'Clipping norm')
flags.DEFINE_integer('batch_size', TRAIN_BATCH_SIZE, 'Batch size')
flags.DEFINE_integer('epochs', TRAIN_NUM_EPOCHS, 'Number of epochs')
flags.DEFINE_integer(
    'microbatches', TRAIN_MICROBATCH_SIZE, 'Number of microbatches '
    '(must evenly divide batch_size)')
flags.DEFINE_string('model_dir', None, 'Model directory')



CATEGORICAL_FEATURE_KEYS = [
    'workclass',
    'education',
    'marital-status',
    'occupation',
    'relationship',
    'race',
    'sex',
    'native-country',
]
NUMERIC_FEATURE_KEYS = [
    'age',
    'capital-gain',
    'capital-loss',
    'hours-per-week',
]
OPTIONAL_NUMERIC_FEATURE_KEYS = [
    'education-num',
]
LABEL_KEY = 'label'


class EpsilonPrintingTrainingHook(tf.estimator.SessionRunHook):
  """Training hook to print current value of epsilon after an epoch."""

  def __init__(self, ledger):
    """Initalizes the EpsilonPrintingTrainingHook.

    Args:
      ledger: The privacy ledger.
    """
    self._samples, self._queries = ledger.get_unformatted_ledger()

  def end(self, session):

    # Any RDP order (for order > 1) corresponds to one epsilon value. We
    # enumerate through a few orders and pick the one that gives lowest epsilon.
    # The variable orders may be extended for different use cases. Usually, the
    # search is set to be finer-grained for small orders and coarser-grained for
    # larger orders.
    orders = [1 + x / 10.0 for x in range(1, 100)] + list(range(12, 64))
    samples = session.run(self._samples)
    queries = session.run(self._queries)
    formatted_ledger = privacy_ledger.format_ledger(samples, queries)
    rdp = compute_rdp_from_ledger(formatted_ledger, orders)

    # It is recommended that delta is o(1/dataset_size). In the case of MNIST,
    # dataset_size is 60000, so we set delta to be 1e-5. For larger datasets,
    # delta should be set smaller.
    eps = get_privacy_spent(orders, rdp, target_delta=1e-5)[0]
    print('For delta=1e-5, the current epsilon is: %.2f' % eps)


class MapAndFilterErrors(beam.PTransform):
  """Like beam.Map but filters out erros in the map_fn."""

  class _MapAndFilterErrorsDoFn(beam.DoFn):
    """Count the bad examples using a beam metric."""

    def __init__(self, fn):
      self._fn = fn
      # Create a counter to measure number of bad elements.
      self._bad_elements_counter = beam.metrics.Metrics.counter(
          'census_example', 'bad_elements')

    def process(self, element):
      try:
        yield self._fn(element)
      except Exception:  # pylint: disable=broad-except
        # Catch any exception the above call.
        self._bad_elements_counter.inc(1)

  def __init__(self, fn):
    self._fn = fn

  def expand(self, pcoll):
    return pcoll | beam.ParDo(self._MapAndFilterErrorsDoFn(self._fn))


#RAW_DATA_FEATURE_SPEC = dict([(name, tf.io.FixedLenFeature([], tf.string))
#                              for name in CATEGORICAL_FEATURE_KEYS] +
#                             [(name, tf.io.FixedLenFeature([], tf.float32))
#                              for name in NUMERIC_FEATURE_KEYS] +
#                             [(name, tf.io.VarLenFeature(tf.float32))
#                              for name in OPTIONAL_NUMERIC_FEATURE_KEYS] +
#                             [(LABEL_KEY,
#                               tf.io.FixedLenFeature([], tf.string))])

RAW_DATA_FEATURE_SPEC = dict([(name, tf.io.FixedLenFeature([], tf.string))
                              for name in CATEGORICAL_FEATURE_KEYS] +
                             [(name, tf.io.FixedLenFeature([], tf.float32))
                              for name in NUMERIC_FEATURE_KEYS] +
                             [(name, tf.io.VarLenFeature(tf.float32))
                              for name in OPTIONAL_NUMERIC_FEATURE_KEYS] +
                             [(LABEL_KEY,
                               tf.io.FixedLenFeature([], tf.string))])

RAW_DATA_METADATA = dataset_metadata.DatasetMetadata(
    schema_utils.schema_from_feature_spec(RAW_DATA_FEATURE_SPEC))


# Functions for preprocessing


def transform_data(train_data_file, test_data_file, working_dir):
  """Transform the data and write out as a TFRecord of Example protos.
  Read in the data using the CSV reader, and transform it using a
  preprocessing pipeline that scales numeric data and converts categorical data
  from strings to int64 values indices, by creating a vocabulary for each
  category.
  Args:
    train_data_file: File containing training data
    test_data_file: File containing test data
    working_dir: Directory to write transformed data and metadata to
  """

  def preprocessing_fn(inputs):
    """Preprocess input columns into transformed columns."""
    # Since we are modifying some features and leaving others unchanged, we
    # start by setting `outputs` to a copy of `inputs.
    outputs = inputs.copy()

    # Scale numeric columns to have range [0, 1].
    for key in NUMERIC_FEATURE_KEYS:
      outputs[key] = tft.scale_to_0_1(outputs[key])

    for key in OPTIONAL_NUMERIC_FEATURE_KEYS:
      # This is a SparseTensor because it is optional. Here we fill in a default
      # value when it is missing.
      sparse = tf.sparse.SparseTensor(outputs[key].indices, outputs[key].values,
                                      [outputs[key].dense_shape[0], 1])
      dense = tf.sparse.to_dense(sp_input=sparse, default_value=0.)
      # Reshaping from a batch of vectors of size 1 to a batch to scalars.
      dense = tf.squeeze(dense, axis=1)
      outputs[key] = tft.scale_to_0_1(dense)

    # For all categorical columns except the label column, we generate a
    # vocabulary but do not modify the feature.  This vocabulary is instead
    # used in the trainer, by means of a feature column, to convert the feature
    # from a string to an integer id.
    for key in CATEGORICAL_FEATURE_KEYS:
      tft.vocabulary(inputs[key], vocab_filename=key)

    # For the label column we provide the mapping from string to index.
    table_keys = ['>50K', '<=50K']
    initializer = tf.lookup.KeyValueTensorInitializer(
        keys=table_keys,
        values=tf.cast(tf.range(len(table_keys)), tf.int64),
        key_dtype=tf.string,
        value_dtype=tf.int64)
    table = tf.lookup.StaticHashTable(initializer, default_value=-1)
    outputs[LABEL_KEY] = table.lookup(outputs[LABEL_KEY])

    return outputs

  # The "with" block will create a pipeline, and run that pipeline at the exit
  # of the block.
  with beam.Pipeline() as pipeline:
    with tft_beam.Context(temp_dir=tempfile.mkdtemp()):
      # Create a coder to read the census data with the schema.  To do this we
      # need to list all columns in order since the schema doesn't specify the
      # order of columns in the csv.
      ordered_columns = [
          'age', 'workclass', 'fnlwgt', 'education', 'education-num',
          'marital-status', 'occupation', 'relationship', 'race', 'sex',
          'capital-gain', 'capital-loss', 'hours-per-week', 'native-country',
          'label'
      ]
      converter = tft.coders.CsvCoder(ordered_columns, RAW_DATA_METADATA.schema)

      # Read in raw data and convert using CSV converter.  Note that we apply
      # some Beam transformations here, which will not be encoded in the TF
      # graph since we don't do the from within tf.Transform's methods
      # (AnalyzeDataset, TransformDataset etc.).  These transformations are just
      # to get data into a format that the CSV converter can read, in particular
      # removing spaces after commas.
      #
      # We use MapAndFilterErrors instead of Map to filter out decode errors in
      # convert.decode which should only occur for the trailing blank line.
      raw_data = (
          pipeline
          | 'ReadTrainData' >> beam.io.ReadFromText(train_data_file)
          | 'FixCommasTrainData' >> beam.Map(
              lambda line: line.replace(', ', ','))
          | 'DecodeTrainData' >> MapAndFilterErrors(converter.decode))

      # Combine data and schema into a dataset tuple.  Note that we already used
      # the schema to read the CSV data, but we also need it to interpret
      # raw_data.
      raw_dataset = (raw_data, RAW_DATA_METADATA)
      transformed_dataset, transform_fn = (
          raw_dataset | tft_beam.AnalyzeAndTransformDataset(preprocessing_fn))
      transformed_data, transformed_metadata = transformed_dataset
      transformed_data_coder = tft.coders.ExampleProtoCoder(
          transformed_metadata.schema)

      _ = (
          transformed_data
          | 'EncodeTrainData' >> beam.Map(transformed_data_coder.encode)
          | 'WriteTrainData' >> beam.io.WriteToTFRecord(
              os.path.join(working_dir, TRANSFORMED_TRAIN_DATA_FILEBASE)))

      # Now apply transform function to test data.  In this case we remove the
      # trailing period at the end of each line, and also ignore the header line
      # that is present in the test data file.
      raw_test_data = (
          pipeline
          | 'ReadTestData' >> beam.io.ReadFromText(test_data_file,
                                                   skip_header_lines=1)
          | 'FixCommasTestData' >> beam.Map(
              lambda line: line.replace(', ', ','))
          | 'RemoveTrailingPeriodsTestData' >> beam.Map(lambda line: line[:-1])
          | 'DecodeTestData' >> MapAndFilterErrors(converter.decode))

      raw_test_dataset = (raw_test_data, RAW_DATA_METADATA)

      transformed_test_dataset = (
          (raw_test_dataset, transform_fn) | tft_beam.TransformDataset())
      # Don't need transformed data schema, it's the same as before.
      transformed_test_data, _ = transformed_test_dataset

      _ = (
          transformed_test_data
          | 'EncodeTestData' >> beam.Map(transformed_data_coder.encode)
          | 'WriteTestData' >> beam.io.WriteToTFRecord(
              os.path.join(working_dir, TRANSFORMED_TEST_DATA_FILEBASE)))

      # Will write a SavedModel and metadata to working_dir, which can then
      # be read by the tft.TFTransformOutput class.
      _ = (
          transform_fn
          | 'WriteTransformFn' >> tft_beam.WriteTransformFn(working_dir))

# Functions for training


def _make_training_input_fn(tf_transform_output, transformed_examples,
                            batch_size):
  """Creates an input function reading from transformed data.
  Args:
    tf_transform_output: Wrapper around output of tf.Transform.
    transformed_examples: Base filename of examples.
    batch_size: Batch size.
  Returns:
    The input function for training or eval.
  """
  def input_fn():
    """Input function for training and eval."""


    
    #ledger = privacy_ledger.PrivacyLedger(
    #    population_size=NUM_TRAIN_INSTANCES,
    #    selection_probability=(FLAGS.batch_size / NUM_TRAIN_INSTANCES))  
#
    #optimizer = dp_optimizer.DPGradientDescentGaussianOptimizer(
    #   l2_norm_clip=FLAGS.l2_norm_clip,
    #   noise_multiplier=FLAGS.noise_multiplier,
    #   num_microbatches=FLAGS.microbatches,
    #   ledger=ledger,
    #   learning_rate=FLAGS.learning_rate)
  
    #optimizer = dp_optimizer.DPGradientDescentGaussianOptimizer(
    #   l2_norm_clip=FLAGS.l2_norm_clip,
    #   noise_multiplier=FLAGS.noise_multiplier,
    #   num_microbatches=FLAGS.microbatches,
    #   ledger=ledger,
    #   #population_size=NUM_TRAIN_INSTANCES,
    #   learning_rate=FLAGS.learning_rate)
  
  
    #dp_sum_query = gaussian_query.GaussianSumQuery(
    #        l2_norm_clip=FLAGS.l2_norm_clip,
    #        stddev= FLAGS.l2_norm_clip * FLAGS.noise_multiplier)
  #
    #optimizer = YGradientDescentOptimizer(learning_rate=FLAGS.learning_rate,
    #                                     #l2_norm_clip=FLAGS.l2_norm_clip,
    #                                     num_microbatches=FLAGS.microbatches,
    #                                     #noise_multiplier=FLAGS.noise_multiplier,
    #                                     dp_sum_query=dp_sum_query)
  
    dataset = tf.data.experimental.make_batched_features_dataset(
        file_pattern=transformed_examples,
        batch_size=batch_size,
        features=tf_transform_output.transformed_feature_spec(),
        reader=tf.data.TFRecordDataset,
        shuffle=True)

    transformed_features = tf.compat.v1.data.make_one_shot_iterator(
        dataset).get_next()

    # Extract features and label from the transformed tensors.
    # TODO(b/30367437): make transformed_labels a dict.
    transformed_labels = transformed_features.pop(LABEL_KEY)

    return transformed_features, transformed_labels

  return input_fn


def _make_serving_input_fn(tf_transform_output):
  """Creates an input function reading from raw data.
  Args:
    tf_transform_output: Wrapper around output of tf.Transform.
  Returns:
    The serving input function.
  """

  # Use DP version of GradientDescentOptimizer. Other optimizers are
  # available in dp_o imizer. Most optimizers inheriting from
  # tf.train.Optimizer should be wrappable in differentially private
  # counterparts by calling dp_optimizer.optimizer_from_args().



  raw_feature_spec = RAW_DATA_FEATURE_SPEC.copy()
  # Remove label since it is not available during serving.
  raw_feature_spec.pop(LABEL_KEY)

  def serving_input_fn():
    """Input function for serving."""
    # Get raw features by generating the basic serving input_fn and calling it.
    # Here we generate an input_fn that expects a parsed Example proto to be fed
    # to the model at serving time.  See also
    # tf.estimator.export.build_raw_serving_input_receiver_fn.




    raw_input_fn = tf.estimator.export.build_parsing_serving_input_receiver_fn(
        raw_feature_spec, default_batch_size=None)
    serving_input_receiver = raw_input_fn()

    # Apply the transform function that was used to generate the materialized
    # data.
    raw_features = serving_input_receiver.features
    transformed_features = tf_transform_output.transform_raw_features(
        raw_features)

    return tf.estimator.export.ServingInputReceiver(
        transformed_features, serving_input_receiver.receiver_tensors)

  return serving_input_fn


def get_feature_columns(tf_transform_output):
  """Returns the FeatureColumns for the model.
  Args:
    tf_transform_output: A `TFTransformOutput` object.
  Returns:
    A list of FeatureColumns.
  """
  # Wrap scalars as real valued columns.
  real_valued_columns = [tf.feature_column.numeric_column(key, shape=())
                         for key in NUMERIC_FEATURE_KEYS]

  # Wrap categorical columns.
  one_hot_columns = [
      tf.feature_column.indicator_column(  # pylint: disable=g-complex-comprehension
          tf.feature_column.categorical_column_with_vocabulary_file(
              key=key,
              vocabulary_file=tf_transform_output.vocabulary_file_by_name(
                  vocab_filename=key)))
      for key in CATEGORICAL_FEATURE_KEYS]

  return real_valued_columns + one_hot_columns


def train_and_evaluate(working_dir, num_train_instances=NUM_TRAIN_INSTANCES,
                       num_test_instances=NUM_TEST_INSTANCES):
  """Train the model on training data and evaluate on test data.
  Args:
    working_dir: Directory to read transformed data and metadata from and to
        write exported model to.
    num_train_instances: Number of instances in train set
    num_test_instances: Number of instances in test set
  Returns:
    The results from the estimator's 'evaluate' method
  """
  with tf.Graph().as_default():
  
  
  
     ##optimizer = dp_optimizer.DPGradientDescentGaussianOptimizer(
     ##   l2_norm_clip=FLAGS.l2_norm_clip,
     ##   noise_multiplier=FLAGS.noise_multiplier,
     ##   num_microbatches=FLAGS.microbatches,
     ##   ledger=ledger,
     ##   #population_size=NUM_TRAIN_INSTANCES,
     ##   learning_rate=FLAGS.learning_rate)

  
                                          #dp_sum_query=gaussian_query.GaussianSumQuery(
             #FLAGS.l2_norm_clip, FLAGS.l2_norm_clip * FLAGS.noise_multiplier))
  
     #optimizer = dp_optimizer.make_gaussian_optimizer_class(GradientDescentOptimizer)
     
     #loss = tf.keras.losses.CategoricalCrossentropy(from_logits=True)
     #training_hooks = [
     #    EpsilonPrintingTrainingHook(ledger)
     #]
     #opt_loss = vector_loss  
     #global_step = tf.train.get_global_step()
     #train_op = optimizer.minimize(loss=opt_loss, global_step=global_step)
  
  
     tf_transform_output = tft.TFTransformOutput(working_dir)
  
     run_config = tf.estimator.RunConfig()
  
     ledger = privacy_ledger.PrivacyLedger(
         population_size=NUM_TRAIN_INSTANCES,
         selection_probability=(FLAGS.batch_size / NUM_TRAIN_INSTANCES))  
  
     dp_sum_query = gaussian_query.GaussianSumQuery(
             l2_norm_clip=FLAGS.l2_norm_clip,
             stddev= FLAGS.l2_norm_clip * FLAGS.noise_multiplier)
  
     #optimizer = lambda: dp_optimizer.DPGradientDescentGaussianOptimizer(
     #   l2_norm_clip=FLAGS.l2_norm_clip,
     #   noise_multiplier=FLAGS.noise_multiplier,
     #   num_microbatches=FLAGS.microbatches,
     #   ledger=ledger,
     #   #population_size=NUM_TRAIN_INSTANCES,
     #   learning_rate=FLAGS.learning_rate)
     #   #global_step=tf.train.get_global_ste())
  
     #optimizer = lambda: dp_optimizer.DPAdagradGaussianOptimizer(
     #   l2_norm_clip=FLAGS.l2_norm_clip,
     #   noise_multiplier=FLAGS.noise_multiplier,
     #   num_microbatches=FLAGS.microbatches,
     #   ledger=ledger,
     #   #population_size=NUM_TRAIN_INSTANCES,
     #   learning_rate=FLAGS.learning_rate)
  
     #tf.reset_default_graph() 

     GradientDescentOptimizer = tf.train.GradientDescentOptimizer 
     YGradientDescentOptimizer = dp_optimizer.make_optimizer_class(GradientDescentOptimizer)
  
     optimizer = lambda: YGradientDescentOptimizer(learning_rate=FLAGS.learning_rate,
                                                   num_microbatches=FLAGS.microbatches,
                                                   dp_sum_query=dp_sum_query)
     #training_hooks = [
     #    EpsilonPrintingTrainingHook(ledger)
     #]
  
     #optimizer = dp_optimizer.DPAdagradGaussianOptimizer(
     #  l2_norm_clip=FLAGS.l2_norm_clip,
     #  noise_multiplier=FLAGS.noise_multiplier,
     #  num_microbatches=FLAGS.microbatches,
     #  ledger=ledger,
     #  learning_rate=FLAGS.learning_rate)
  
     #optimizer = GradientDescentOptimizer(learning_rate=FLAGS.learning_rate)
  
     estimator = tf.estimator.LinearClassifier(
         feature_columns=get_feature_columns(tf_transform_output),
         config=run_config,
         loss_reduction=tf.losses.Reduction.SUM,
         optimizer=optimizer
       )
  
  
     # Fit the model using the default optimizer.
     train_input_fn = _make_training_input_fn(
         tf_transform_output,
         os.path.join(working_dir, TRANSFORMED_TRAIN_DATA_FILEBASE + '*'),
         batch_size=TRAIN_BATCH_SIZE)
  
     estimator.train(
         input_fn=train_input_fn,
         #hooks=training_hooks,
         max_steps=TRAIN_NUM_EPOCHS * num_train_instances / TRAIN_BATCH_SIZE)
  
     # Evaluate model on test dataset.
     eval_input_fn = _make_training_input_fn(
         tf_transform_output,
         os.path.join(working_dir, TRANSFORMED_TEST_DATA_FILEBASE + '*'),
         batch_size=1)
  
     # Export the model.
     serving_input_fn = _make_serving_input_fn(tf_transform_output)
     exported_model_dir = os.path.join(working_dir, EXPORTED_MODEL_DIR)
     estimator.export_saved_model(exported_model_dir, serving_input_fn)
  
     return estimator.evaluate(input_fn=eval_input_fn, steps=num_test_instances)


def main():
  
  parser = argparse.ArgumentParser()
  parser.add_argument(
      'input_data_dir',
      help='path to directory containing input data')
  parser.add_argument(
      '--working_dir',
      help='optional, path to directory to hold transformed data')
  args = parser.parse_args()

  if args.working_dir:
    working_dir = args.working_dir
  else:
    working_dir = tempfile.mkdtemp(dir=args.input_data_dir)

  train_data_file = os.path.join(args.input_data_dir, 'adult.data')
  test_data_file = os.path.join(args.input_data_dir, 'adult.test')

  transform_data(train_data_file, test_data_file, working_dir)

  results = train_and_evaluate(working_dir)

  pprint.pprint(results)

if __name__ == '__main__':
  main()