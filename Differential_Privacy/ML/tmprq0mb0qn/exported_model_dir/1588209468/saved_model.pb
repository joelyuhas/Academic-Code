¬
Ļ/³/
W
AddN
inputs"T*N
sum"T"
Nint(0"!
Ttype:
2	
A
AddV2
x"T
y"T
z"T"
Ttype:
2	
h
All	
input

reduction_indices"Tidx

output
"
	keep_dimsbool( "
Tidxtype0:
2	

ArgMax

input"T
	dimension"Tidx
output"output_type" 
Ttype:
2	"
Tidxtype0:
2	"
output_typetype0	:
2	
ø
AsString

input"T

output"
Ttype:
2		
"
	precisionint’’’’’’’’’"

scientificbool( "
shortestbool( "
widthint’’’’’’’’’"
fillstring 
P
Assert
	condition
	
data2T"
T
list(type)(0"
	summarizeint
B
AssignVariableOp
resource
value"dtype"
dtypetype
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
h
Equal
x"T
y"T
z
"
Ttype:
2	
"$
incompatible_shape_errorbool(
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
p
GatherNd
params"Tparams
indices"Tindices
output"Tparams"
Tparamstype"
Tindicestype:
2	
”
HashTableV2
table_handle"
	containerstring "
shared_namestring "!
use_node_name_sharingbool( "
	key_dtypetype"
value_dtypetype
.
Identity

input"T
output"T"	
Ttype
ŗ
If
cond"Tcond
input2Tin
output2Tout"
Tcondtype"
Tin
list(type)("
Tout
list(type)("
then_branchfunc"
else_branchfunc" 
output_shapeslist(shape)
 
É
InitializeTableFromTextFileV2
table_handle
filename"
	key_indexint(0ž’’’’’’’’"
value_indexint(0ž’’’’’’’’"+

vocab_sizeint’’’’’’’’’(0’’’’’’’’’"
	delimiterstring	
+
IsInf
x"T
y
"
Ttype:
2
:
Less
x"T
y"T
z
"
Ttype:
2	
w
LookupTableFindV2
table_handle
keys"Tin
default_value"Tout
values"Tout"
Tintype"
Touttype
b
LookupTableImportV2
table_handle
keys"Tin
values"Tout"
Tintype"
Touttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	

Max

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
=
Mul
x"T
y"T
z"T"
Ttype:
2	

NoOp
k
NotEqual
x"T
y"T
z
"
Ttype:
2	
"$
incompatible_shape_errorbool(

OneHot
indices"TI	
depth
on_value"T
	off_value"T
output"T"
axisint’’’’’’’’’"	
Ttype"
TItype0	:
2	
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 

ParseExampleV2

serialized	
names
sparse_keys

dense_keys
ragged_keys
dense_defaults2Tdense
sparse_indices	*
num_sparse
sparse_values2sparse_types
sparse_shapes	*
num_sparse
dense_values2Tdense#
ragged_values2ragged_value_types'
ragged_row_splits2ragged_split_types"
Tdense
list(type)(:
2	"

num_sparseint("%
sparse_types
list(type)(:
2	"+
ragged_value_types
list(type)(:
2	"*
ragged_split_types
list(type)(:
2	"
dense_shapeslist(shape)(
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
b
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:

2	
@
ReadVariableOp
resource
value"dtype"
dtypetype
>
RealDiv
x"T
y"T
z"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
P
ScalarSummary
tags
values"T
summary"
Ttype:
2	
A
SelectV2
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
9
Softmax
logits"T
softmax"T"
Ttype:
2
¼
SparseToDense
sparse_indices"Tindices
output_shape"Tindices
sparse_values"T
default_value"T

dense"T"
validate_indicesbool("	
Ttype"
Tindicestype:
2	
N
Squeeze

input"T
output"T"	
Ttype"
squeeze_dims	list(int)
 (
ö
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	

Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape
9
VarIsInitializedOp
resource
is_initialized

E
Where

input"T	
index	"%
Ttype0
:
2	

&
	ZerosLike
x"T
y"T"	
Ttype"serve*2.1.02unknown8ć

global_step/Initializer/zerosConst*
_class
loc:@global_step*
_output_shapes
: *
dtype0	*
value	B	 R 

global_stepVarHandleOp*
_class
loc:@global_step*
_output_shapes
: *
dtype0	*
shape: *
shared_nameglobal_step
g
,global_step/IsInitialized/VarIsInitializedOpVarIsInitializedOpglobal_step*
_output_shapes
: 
_
global_step/AssignAssignVariableOpglobal_stepglobal_step/Initializer/zeros*
dtype0	
c
global_step/Read/ReadVariableOpReadVariableOpglobal_step*
_output_shapes
: *
dtype0	
o
input_example_tensorPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’
U
ParseExample/ConstConst*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_1Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_2Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_3Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_4Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_5Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_6Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_7Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_8Const*
_output_shapes
: *
dtype0*
valueB 
W
ParseExample/Const_9Const*
_output_shapes
: *
dtype0*
valueB 
X
ParseExample/Const_10Const*
_output_shapes
: *
dtype0*
valueB 
X
ParseExample/Const_11Const*
_output_shapes
: *
dtype0*
valueB 
d
!ParseExample/ParseExampleV2/namesConst*
_output_shapes
: *
dtype0*
valueB 
}
'ParseExample/ParseExampleV2/sparse_keysConst*
_output_shapes
:*
dtype0*"
valueBBeducation-num
ü
&ParseExample/ParseExampleV2/dense_keysConst*
_output_shapes
:*
dtype0*”
valueBBageBcapital-gainBcapital-lossB	educationBhours-per-weekBmarital-statusBnative-countryB
occupationBraceBrelationshipBsexB	workclass
j
'ParseExample/ParseExampleV2/ragged_keysConst*
_output_shapes
: *
dtype0*
valueB 

ParseExample/ParseExampleV2ParseExampleV2input_example_tensor!ParseExample/ParseExampleV2/names'ParseExample/ParseExampleV2/sparse_keys&ParseExample/ParseExampleV2/dense_keys'ParseExample/ParseExampleV2/ragged_keysParseExample/ConstParseExample/Const_1ParseExample/Const_2ParseExample/Const_3ParseExample/Const_4ParseExample/Const_5ParseExample/Const_6ParseExample/Const_7ParseExample/Const_8ParseExample/Const_9ParseExample/Const_10ParseExample/Const_11*
Tdense
2*ņ
_output_shapesß
Ü:’’’’’’’’’:’’’’’’’’’::’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’:’’’’’’’’’**
dense_shapes
: : : : : : : : : : : : *

num_sparse*
ragged_split_types
 *
ragged_value_types
 *
sparse_types
2
¢
ConstConst*
_output_shapes
: *
dtype0*m
valuedBb B\D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\workclass
¤
Const_1Const*
_output_shapes
: *
dtype0*m
valuedBb B\D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\education
©
Const_2Const*
_output_shapes
: *
dtype0*r
valueiBg BaD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\marital-status
„
Const_3Const*
_output_shapes
: *
dtype0*n
valueeBc B]D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\occupation
§
Const_4Const*
_output_shapes
: *
dtype0*p
valuegBe B_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\relationship

Const_5Const*
_output_shapes
: *
dtype0*h
value_B] BWD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\race

Const_6Const*
_output_shapes
: *
dtype0*g
value^B\ BVD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\sex
©
Const_7Const*
_output_shapes
: *
dtype0*r
valueiBg BaD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\native-country
T
transform/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  Į
V
transform/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *  “B
V
transform/Const_2Const*
_output_shapes
: *
dtype0*
valueB
 *    
V
transform/Const_3Const*
_output_shapes
: *
dtype0*
valueB
 *OĆG
V
transform/Const_4Const*
_output_shapes
: *
dtype0*
valueB
 *    
V
transform/Const_5Const*
_output_shapes
: *
dtype0*
valueB
 * ĄsE
V
transform/Const_6Const*
_output_shapes
: *
dtype0*
valueB
 *  æ
V
transform/Const_7Const*
_output_shapes
: *
dtype0*
valueB
 *  ĘB
V
transform/Const_8Const*
_output_shapes
: *
dtype0*
valueB
 *  æ
V
transform/Const_9Const*
_output_shapes
: *
dtype0*
valueB
 *  A
T
transform/Const_10Const*
_output_shapes
: *
dtype0	*
value	B	 R

transform/Const_11Const*
_output_shapes
: *
dtype0*Y
valuePBN BHC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\workclass
T
transform/Const_12Const*
_output_shapes
: *
dtype0	*
value	B	 R

transform/Const_13Const*
_output_shapes
: *
dtype0*Y
valuePBN BHC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\education
T
transform/Const_14Const*
_output_shapes
: *
dtype0	*
value	B	 R
 
transform/Const_15Const*
_output_shapes
: *
dtype0*^
valueUBS BMC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\marital-status
T
transform/Const_16Const*
_output_shapes
: *
dtype0	*
value	B	 R

transform/Const_17Const*
_output_shapes
: *
dtype0*Z
valueQBO BIC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\occupation
T
transform/Const_18Const*
_output_shapes
: *
dtype0	*
value	B	 R

transform/Const_19Const*
_output_shapes
: *
dtype0*\
valueSBQ BKC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\relationship
T
transform/Const_20Const*
_output_shapes
: *
dtype0	*
value	B	 R

transform/Const_21Const*
_output_shapes
: *
dtype0*T
valueKBI BCC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\race
T
transform/Const_22Const*
_output_shapes
: *
dtype0	*
value	B	 R

transform/Const_23Const*
_output_shapes
: *
dtype0*S
valueJBH BBC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\sex
T
transform/Const_24Const*
_output_shapes
: *
dtype0	*
value	B	 R$
 
transform/Const_25Const*
_output_shapes
: *
dtype0*^
valueUBS BMC:\Users\Spooky\AppData\Local\Temp\tmpy91nzdtn\tftransform_tmp\native-country
y
transform/transform/inputs/agePlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

)transform/transform/inputs/F_capital-gainPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

)transform/transform/inputs/F_capital-lossPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

$transform/transform/inputs/educationPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’
y
0transform/transform/inputs/F_education-num/shapePlaceholder*
_output_shapes
:*
dtype0	*
shape:

1transform/transform/inputs/F_education-num/valuesPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

2transform/transform/inputs/F_education-num/indicesPlaceholder*'
_output_shapes
:’’’’’’’’’*
dtype0	*
shape:’’’’’’’’’

+transform/transform/inputs/F_hours-per-weekPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’
{
 transform/transform/inputs/labelPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

+transform/transform/inputs/F_marital-statusPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

+transform/transform/inputs/F_native-countryPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

%transform/transform/inputs/occupationPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’
z
transform/transform/inputs/racePlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

'transform/transform/inputs/relationshipPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’
y
transform/transform/inputs/sexPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

$transform/transform/inputs/workclassPlaceholder*#
_output_shapes
:’’’’’’’’’*
dtype0*
shape:’’’’’’’’’

*transform/transform/inputs/inputs/age_copyIdentityParseExample/ParseExampleV2:3*
T0*#
_output_shapes
:’’’’’’’’’

5transform/transform/inputs/inputs/F_capital-gain_copyIdentityParseExample/ParseExampleV2:4*
T0*#
_output_shapes
:’’’’’’’’’

5transform/transform/inputs/inputs/F_capital-loss_copyIdentityParseExample/ParseExampleV2:5*
T0*#
_output_shapes
:’’’’’’’’’

0transform/transform/inputs/inputs/education_copyIdentityParseExample/ParseExampleV2:6*
T0*#
_output_shapes
:’’’’’’’’’

>transform/transform/inputs/inputs/F_education-num/indices_copyIdentityParseExample/ParseExampleV2*
T0	*'
_output_shapes
:’’’’’’’’’

=transform/transform/inputs/inputs/F_education-num/values_copyIdentityParseExample/ParseExampleV2:1*
T0*#
_output_shapes
:’’’’’’’’’

<transform/transform/inputs/inputs/F_education-num/shape_copyIdentityParseExample/ParseExampleV2:2*
T0	*
_output_shapes
:

7transform/transform/inputs/inputs/F_hours-per-week_copyIdentityParseExample/ParseExampleV2:7*
T0*#
_output_shapes
:’’’’’’’’’

,transform/transform/inputs/inputs/label_copyIdentity transform/transform/inputs/label*
T0*#
_output_shapes
:’’’’’’’’’

7transform/transform/inputs/inputs/F_marital-status_copyIdentityParseExample/ParseExampleV2:8*
T0*#
_output_shapes
:’’’’’’’’’

7transform/transform/inputs/inputs/F_native-country_copyIdentityParseExample/ParseExampleV2:9*
T0*#
_output_shapes
:’’’’’’’’’

1transform/transform/inputs/inputs/occupation_copyIdentityParseExample/ParseExampleV2:10*
T0*#
_output_shapes
:’’’’’’’’’

+transform/transform/inputs/inputs/race_copyIdentityParseExample/ParseExampleV2:11*
T0*#
_output_shapes
:’’’’’’’’’

3transform/transform/inputs/inputs/relationship_copyIdentityParseExample/ParseExampleV2:12*
T0*#
_output_shapes
:’’’’’’’’’

*transform/transform/inputs/inputs/sex_copyIdentityParseExample/ParseExampleV2:13*
T0*#
_output_shapes
:’’’’’’’’’

0transform/transform/inputs/inputs/workclass_copyIdentityParseExample/ParseExampleV2:14*
T0*#
_output_shapes
:’’’’’’’’’
|
2transform/transform/scale_to_0_1/min_and_max/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
ø
0transform/transform/scale_to_0_1/min_and_max/MaxMax*transform/transform/inputs/inputs/age_copy2transform/transform/scale_to_0_1/min_and_max/Const*
T0*
_output_shapes
: 

7transform/transform/scale_to_0_1/min_and_max/zeros_like	ZerosLike*transform/transform/inputs/inputs/age_copy*
T0*#
_output_shapes
:’’’’’’’’’
Ź
0transform/transform/scale_to_0_1/min_and_max/subSub7transform/transform/scale_to_0_1/min_and_max/zeros_like*transform/transform/inputs/inputs/age_copy*
T0*#
_output_shapes
:’’’’’’’’’
~
4transform/transform/scale_to_0_1/min_and_max/Const_1Const*
_output_shapes
:*
dtype0*
valueB: 
Ā
2transform/transform/scale_to_0_1/min_and_max/Max_1Max0transform/transform/scale_to_0_1/min_and_max/sub4transform/transform/scale_to_0_1/min_and_max/Const_1*
T0*
_output_shapes
: 
u
2transform/transform/scale_to_0_1/min_and_max/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
w
4transform/transform/scale_to_0_1/min_and_max/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
×
Atransform/transform/scale_to_0_1/min_and_max/assert_equal_1/EqualEqual2transform/transform/scale_to_0_1/min_and_max/Shape4transform/transform/scale_to_0_1/min_and_max/Shape_1*
T0*
_output_shapes
: 

Atransform/transform/scale_to_0_1/min_and_max/assert_equal_1/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
ä
?transform/transform/scale_to_0_1/min_and_max/assert_equal_1/AllAllAtransform/transform/scale_to_0_1/min_and_max/assert_equal_1/EqualAtransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Const*
_output_shapes
: 
“
Htransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/ConstConst*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
²
Jtransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Const_1Const*
_output_shapes
: *
dtype0*8
value/B- B'x (scale_to_0_1/min_and_max/Shape:0) = 
“
Jtransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Const_2Const*
_output_shapes
: *
dtype0*:
value1B/ B)y (scale_to_0_1/min_and_max/Shape_1:0) = 
¼
Ptransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_0Const*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
ø
Ptransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_1Const*
_output_shapes
: *
dtype0*8
value/B- B'x (scale_to_0_1/min_and_max/Shape:0) = 
ŗ
Ptransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_3Const*
_output_shapes
: *
dtype0*:
value1B/ B)y (scale_to_0_1/min_and_max/Shape_1:0) = 

Itransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/AssertAssert?transform/transform/scale_to_0_1/min_and_max/assert_equal_1/AllPtransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_0Ptransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_12transform/transform/scale_to_0_1/min_and_max/ShapePtransform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_34transform/transform/scale_to_0_1/min_and_max/Shape_1*
T	
2
ā
5transform/transform/scale_to_0_1/min_and_max/IdentityIdentity2transform/transform/scale_to_0_1/min_and_max/Max_1J^transform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
ā
7transform/transform/scale_to_0_1/min_and_max/Identity_1Identity0transform/transform/scale_to_0_1/min_and_max/MaxJ^transform/transform/scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
y
4transform/transform/scale_to_0_1/min_and_max/Const_2Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

2transform/transform/scale_to_0_1/min_and_max/IsInfIsInf5transform/transform/scale_to_0_1/min_and_max/Identity*
T0*
_output_shapes
: 
Ē
0transform/transform/scale_to_0_1/min_and_max/addAddV25transform/transform/scale_to_0_1/min_and_max/Identity4transform/transform/scale_to_0_1/min_and_max/Const_2*
T0*
_output_shapes
: 
’
5transform/transform/scale_to_0_1/min_and_max/SelectV2SelectV22transform/transform/scale_to_0_1/min_and_max/IsInf0transform/transform/scale_to_0_1/min_and_max/add5transform/transform/scale_to_0_1/min_and_max/Identity*
T0*
_output_shapes
: 
y
4transform/transform/scale_to_0_1/min_and_max/Const_3Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

4transform/transform/scale_to_0_1/min_and_max/IsInf_1IsInf7transform/transform/scale_to_0_1/min_and_max/Identity_1*
T0*
_output_shapes
: 
Ė
2transform/transform/scale_to_0_1/min_and_max/add_1AddV27transform/transform/scale_to_0_1/min_and_max/Identity_14transform/transform/scale_to_0_1/min_and_max/Const_3*
T0*
_output_shapes
: 

7transform/transform/scale_to_0_1/min_and_max/SelectV2_1SelectV24transform/transform/scale_to_0_1/min_and_max/IsInf_12transform/transform/scale_to_0_1/min_and_max/add_17transform/transform/scale_to_0_1/min_and_max/Identity_1*
T0*
_output_shapes
: 
y
8transform/transform/scale_to_0_1/min_and_max/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 
{
:transform/transform/scale_to_0_1/min_and_max/Placeholder_1Placeholder*
_output_shapes
: *
dtype0*
shape: 
y
4transform/transform/scale_to_0_1/min_and_max/sub_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *    
”
2transform/transform/scale_to_0_1/min_and_max/sub_1Sub4transform/transform/scale_to_0_1/min_and_max/sub_1/xtransform/Const*
T0*
_output_shapes
: 

&transform/transform/scale_to_0_1/ShapeShape*transform/transform/inputs/inputs/age_copy*
T0*
_output_shapes
:
¹
$transform/transform/scale_to_0_1/subSub*transform/transform/inputs/inputs/age_copy2transform/transform/scale_to_0_1/min_and_max/sub_1*
T0*#
_output_shapes
:’’’’’’’’’

%transform/transform/scale_to_0_1/LessLess2transform/transform/scale_to_0_1/min_and_max/sub_1transform/Const_1*
T0*
_output_shapes
: 

+transform/transform/scale_to_0_1/zeros_like	ZerosLike$transform/transform/scale_to_0_1/sub*
T0*#
_output_shapes
:’’’’’’’’’

%transform/transform/scale_to_0_1/CastCast%transform/transform/scale_to_0_1/Less*

DstT0*

SrcT0
*
_output_shapes
: 
Æ
$transform/transform/scale_to_0_1/addAddV2+transform/transform/scale_to_0_1/zeros_like%transform/transform/scale_to_0_1/Cast*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1/Cast_1Cast$transform/transform/scale_to_0_1/add*

DstT0
*

SrcT0*#
_output_shapes
:’’’’’’’’’

&transform/transform/scale_to_0_1/sub_1Subtransform/Const_12transform/transform/scale_to_0_1/min_and_max/sub_1*
T0*
_output_shapes
: 
Æ
(transform/transform/scale_to_0_1/truedivRealDiv$transform/transform/scale_to_0_1/sub&transform/transform/scale_to_0_1/sub_1*
T0*#
_output_shapes
:’’’’’’’’’
p
+transform/transform/scale_to_0_1/Fill/valueConst*
_output_shapes
: *
dtype0*
valueB
 *   ?
°
%transform/transform/scale_to_0_1/FillFill&transform/transform/scale_to_0_1/Shape+transform/transform/scale_to_0_1/Fill/value*
T0*#
_output_shapes
:’’’’’’’’’
Ż
)transform/transform/scale_to_0_1/SelectV2SelectV2'transform/transform/scale_to_0_1/Cast_1(transform/transform/scale_to_0_1/truediv%transform/transform/scale_to_0_1/Fill*
T0*#
_output_shapes
:’’’’’’’’’
k
&transform/transform/scale_to_0_1/mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
¬
$transform/transform/scale_to_0_1/mulMul)transform/transform/scale_to_0_1/SelectV2&transform/transform/scale_to_0_1/mul/y*
T0*#
_output_shapes
:’’’’’’’’’
m
(transform/transform/scale_to_0_1/add_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
­
&transform/transform/scale_to_0_1/add_1AddV2$transform/transform/scale_to_0_1/mul(transform/transform/scale_to_0_1/add_1/y*
T0*#
_output_shapes
:’’’’’’’’’
~
4transform/transform/scale_to_0_1_1/min_and_max/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
Ē
2transform/transform/scale_to_0_1_1/min_and_max/MaxMax5transform/transform/inputs/inputs/F_capital-gain_copy4transform/transform/scale_to_0_1_1/min_and_max/Const*
T0*
_output_shapes
: 
«
9transform/transform/scale_to_0_1_1/min_and_max/zeros_like	ZerosLike5transform/transform/inputs/inputs/F_capital-gain_copy*
T0*#
_output_shapes
:’’’’’’’’’
Ł
2transform/transform/scale_to_0_1_1/min_and_max/subSub9transform/transform/scale_to_0_1_1/min_and_max/zeros_like5transform/transform/inputs/inputs/F_capital-gain_copy*
T0*#
_output_shapes
:’’’’’’’’’

6transform/transform/scale_to_0_1_1/min_and_max/Const_1Const*
_output_shapes
:*
dtype0*
valueB: 
Č
4transform/transform/scale_to_0_1_1/min_and_max/Max_1Max2transform/transform/scale_to_0_1_1/min_and_max/sub6transform/transform/scale_to_0_1_1/min_and_max/Const_1*
T0*
_output_shapes
: 
w
4transform/transform/scale_to_0_1_1/min_and_max/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
y
6transform/transform/scale_to_0_1_1/min_and_max/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
Ż
Ctransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/EqualEqual4transform/transform/scale_to_0_1_1/min_and_max/Shape6transform/transform/scale_to_0_1_1/min_and_max/Shape_1*
T0*
_output_shapes
: 

Ctransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
ź
Atransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/AllAllCtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/EqualCtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Const*
_output_shapes
: 
¶
Jtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/ConstConst*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¶
Ltransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Const_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_1/min_and_max/Shape:0) = 
ø
Ltransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Const_2Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_1/min_and_max/Shape_1:0) = 
¾
Rtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert/data_0Const*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¼
Rtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert/data_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_1/min_and_max/Shape:0) = 
¾
Rtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert/data_3Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_1/min_and_max/Shape_1:0) = 

Ktransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/AssertAssertAtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/AllRtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert/data_0Rtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert/data_14transform/transform/scale_to_0_1_1/min_and_max/ShapeRtransform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert/data_36transform/transform/scale_to_0_1_1/min_and_max/Shape_1*
T	
2
č
7transform/transform/scale_to_0_1_1/min_and_max/IdentityIdentity4transform/transform/scale_to_0_1_1/min_and_max/Max_1L^transform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
č
9transform/transform/scale_to_0_1_1/min_and_max/Identity_1Identity2transform/transform/scale_to_0_1_1/min_and_max/MaxL^transform/transform/scale_to_0_1_1/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_1/min_and_max/Const_2Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

4transform/transform/scale_to_0_1_1/min_and_max/IsInfIsInf7transform/transform/scale_to_0_1_1/min_and_max/Identity*
T0*
_output_shapes
: 
Ķ
2transform/transform/scale_to_0_1_1/min_and_max/addAddV27transform/transform/scale_to_0_1_1/min_and_max/Identity6transform/transform/scale_to_0_1_1/min_and_max/Const_2*
T0*
_output_shapes
: 

7transform/transform/scale_to_0_1_1/min_and_max/SelectV2SelectV24transform/transform/scale_to_0_1_1/min_and_max/IsInf2transform/transform/scale_to_0_1_1/min_and_max/add7transform/transform/scale_to_0_1_1/min_and_max/Identity*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_1/min_and_max/Const_3Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

6transform/transform/scale_to_0_1_1/min_and_max/IsInf_1IsInf9transform/transform/scale_to_0_1_1/min_and_max/Identity_1*
T0*
_output_shapes
: 
Ń
4transform/transform/scale_to_0_1_1/min_and_max/add_1AddV29transform/transform/scale_to_0_1_1/min_and_max/Identity_16transform/transform/scale_to_0_1_1/min_and_max/Const_3*
T0*
_output_shapes
: 

9transform/transform/scale_to_0_1_1/min_and_max/SelectV2_1SelectV26transform/transform/scale_to_0_1_1/min_and_max/IsInf_14transform/transform/scale_to_0_1_1/min_and_max/add_19transform/transform/scale_to_0_1_1/min_and_max/Identity_1*
T0*
_output_shapes
: 
{
:transform/transform/scale_to_0_1_1/min_and_max/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 
}
<transform/transform/scale_to_0_1_1/min_and_max/Placeholder_1Placeholder*
_output_shapes
: *
dtype0*
shape: 
{
6transform/transform/scale_to_0_1_1/min_and_max/sub_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *    
§
4transform/transform/scale_to_0_1_1/min_and_max/sub_1Sub6transform/transform/scale_to_0_1_1/min_and_max/sub_1/xtransform/Const_2*
T0*
_output_shapes
: 

(transform/transform/scale_to_0_1_1/ShapeShape5transform/transform/inputs/inputs/F_capital-gain_copy*
T0*
_output_shapes
:
Č
&transform/transform/scale_to_0_1_1/subSub5transform/transform/inputs/inputs/F_capital-gain_copy4transform/transform/scale_to_0_1_1/min_and_max/sub_1*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_1/LessLess4transform/transform/scale_to_0_1_1/min_and_max/sub_1transform/Const_3*
T0*
_output_shapes
: 

-transform/transform/scale_to_0_1_1/zeros_like	ZerosLike&transform/transform/scale_to_0_1_1/sub*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_1/CastCast'transform/transform/scale_to_0_1_1/Less*

DstT0*

SrcT0
*
_output_shapes
: 
µ
&transform/transform/scale_to_0_1_1/addAddV2-transform/transform/scale_to_0_1_1/zeros_like'transform/transform/scale_to_0_1_1/Cast*
T0*#
_output_shapes
:’’’’’’’’’

)transform/transform/scale_to_0_1_1/Cast_1Cast&transform/transform/scale_to_0_1_1/add*

DstT0
*

SrcT0*#
_output_shapes
:’’’’’’’’’

(transform/transform/scale_to_0_1_1/sub_1Subtransform/Const_34transform/transform/scale_to_0_1_1/min_and_max/sub_1*
T0*
_output_shapes
: 
µ
*transform/transform/scale_to_0_1_1/truedivRealDiv&transform/transform/scale_to_0_1_1/sub(transform/transform/scale_to_0_1_1/sub_1*
T0*#
_output_shapes
:’’’’’’’’’
r
-transform/transform/scale_to_0_1_1/Fill/valueConst*
_output_shapes
: *
dtype0*
valueB
 *   ?
¶
'transform/transform/scale_to_0_1_1/FillFill(transform/transform/scale_to_0_1_1/Shape-transform/transform/scale_to_0_1_1/Fill/value*
T0*#
_output_shapes
:’’’’’’’’’
å
+transform/transform/scale_to_0_1_1/SelectV2SelectV2)transform/transform/scale_to_0_1_1/Cast_1*transform/transform/scale_to_0_1_1/truediv'transform/transform/scale_to_0_1_1/Fill*
T0*#
_output_shapes
:’’’’’’’’’
m
(transform/transform/scale_to_0_1_1/mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
²
&transform/transform/scale_to_0_1_1/mulMul+transform/transform/scale_to_0_1_1/SelectV2(transform/transform/scale_to_0_1_1/mul/y*
T0*#
_output_shapes
:’’’’’’’’’
o
*transform/transform/scale_to_0_1_1/add_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
³
(transform/transform/scale_to_0_1_1/add_1AddV2&transform/transform/scale_to_0_1_1/mul*transform/transform/scale_to_0_1_1/add_1/y*
T0*#
_output_shapes
:’’’’’’’’’
~
4transform/transform/scale_to_0_1_2/min_and_max/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
Ē
2transform/transform/scale_to_0_1_2/min_and_max/MaxMax5transform/transform/inputs/inputs/F_capital-loss_copy4transform/transform/scale_to_0_1_2/min_and_max/Const*
T0*
_output_shapes
: 
«
9transform/transform/scale_to_0_1_2/min_and_max/zeros_like	ZerosLike5transform/transform/inputs/inputs/F_capital-loss_copy*
T0*#
_output_shapes
:’’’’’’’’’
Ł
2transform/transform/scale_to_0_1_2/min_and_max/subSub9transform/transform/scale_to_0_1_2/min_and_max/zeros_like5transform/transform/inputs/inputs/F_capital-loss_copy*
T0*#
_output_shapes
:’’’’’’’’’

6transform/transform/scale_to_0_1_2/min_and_max/Const_1Const*
_output_shapes
:*
dtype0*
valueB: 
Č
4transform/transform/scale_to_0_1_2/min_and_max/Max_1Max2transform/transform/scale_to_0_1_2/min_and_max/sub6transform/transform/scale_to_0_1_2/min_and_max/Const_1*
T0*
_output_shapes
: 
w
4transform/transform/scale_to_0_1_2/min_and_max/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
y
6transform/transform/scale_to_0_1_2/min_and_max/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
Ż
Ctransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/EqualEqual4transform/transform/scale_to_0_1_2/min_and_max/Shape6transform/transform/scale_to_0_1_2/min_and_max/Shape_1*
T0*
_output_shapes
: 

Ctransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
ź
Atransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/AllAllCtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/EqualCtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Const*
_output_shapes
: 
¶
Jtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/ConstConst*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¶
Ltransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Const_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_2/min_and_max/Shape:0) = 
ø
Ltransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Const_2Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_2/min_and_max/Shape_1:0) = 
¾
Rtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert/data_0Const*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¼
Rtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert/data_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_2/min_and_max/Shape:0) = 
¾
Rtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert/data_3Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_2/min_and_max/Shape_1:0) = 

Ktransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/AssertAssertAtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/AllRtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert/data_0Rtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert/data_14transform/transform/scale_to_0_1_2/min_and_max/ShapeRtransform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert/data_36transform/transform/scale_to_0_1_2/min_and_max/Shape_1*
T	
2
č
7transform/transform/scale_to_0_1_2/min_and_max/IdentityIdentity4transform/transform/scale_to_0_1_2/min_and_max/Max_1L^transform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
č
9transform/transform/scale_to_0_1_2/min_and_max/Identity_1Identity2transform/transform/scale_to_0_1_2/min_and_max/MaxL^transform/transform/scale_to_0_1_2/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_2/min_and_max/Const_2Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

4transform/transform/scale_to_0_1_2/min_and_max/IsInfIsInf7transform/transform/scale_to_0_1_2/min_and_max/Identity*
T0*
_output_shapes
: 
Ķ
2transform/transform/scale_to_0_1_2/min_and_max/addAddV27transform/transform/scale_to_0_1_2/min_and_max/Identity6transform/transform/scale_to_0_1_2/min_and_max/Const_2*
T0*
_output_shapes
: 

7transform/transform/scale_to_0_1_2/min_and_max/SelectV2SelectV24transform/transform/scale_to_0_1_2/min_and_max/IsInf2transform/transform/scale_to_0_1_2/min_and_max/add7transform/transform/scale_to_0_1_2/min_and_max/Identity*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_2/min_and_max/Const_3Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

6transform/transform/scale_to_0_1_2/min_and_max/IsInf_1IsInf9transform/transform/scale_to_0_1_2/min_and_max/Identity_1*
T0*
_output_shapes
: 
Ń
4transform/transform/scale_to_0_1_2/min_and_max/add_1AddV29transform/transform/scale_to_0_1_2/min_and_max/Identity_16transform/transform/scale_to_0_1_2/min_and_max/Const_3*
T0*
_output_shapes
: 

9transform/transform/scale_to_0_1_2/min_and_max/SelectV2_1SelectV26transform/transform/scale_to_0_1_2/min_and_max/IsInf_14transform/transform/scale_to_0_1_2/min_and_max/add_19transform/transform/scale_to_0_1_2/min_and_max/Identity_1*
T0*
_output_shapes
: 
{
:transform/transform/scale_to_0_1_2/min_and_max/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 
}
<transform/transform/scale_to_0_1_2/min_and_max/Placeholder_1Placeholder*
_output_shapes
: *
dtype0*
shape: 
{
6transform/transform/scale_to_0_1_2/min_and_max/sub_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *    
§
4transform/transform/scale_to_0_1_2/min_and_max/sub_1Sub6transform/transform/scale_to_0_1_2/min_and_max/sub_1/xtransform/Const_4*
T0*
_output_shapes
: 

(transform/transform/scale_to_0_1_2/ShapeShape5transform/transform/inputs/inputs/F_capital-loss_copy*
T0*
_output_shapes
:
Č
&transform/transform/scale_to_0_1_2/subSub5transform/transform/inputs/inputs/F_capital-loss_copy4transform/transform/scale_to_0_1_2/min_and_max/sub_1*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_2/LessLess4transform/transform/scale_to_0_1_2/min_and_max/sub_1transform/Const_5*
T0*
_output_shapes
: 

-transform/transform/scale_to_0_1_2/zeros_like	ZerosLike&transform/transform/scale_to_0_1_2/sub*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_2/CastCast'transform/transform/scale_to_0_1_2/Less*

DstT0*

SrcT0
*
_output_shapes
: 
µ
&transform/transform/scale_to_0_1_2/addAddV2-transform/transform/scale_to_0_1_2/zeros_like'transform/transform/scale_to_0_1_2/Cast*
T0*#
_output_shapes
:’’’’’’’’’

)transform/transform/scale_to_0_1_2/Cast_1Cast&transform/transform/scale_to_0_1_2/add*

DstT0
*

SrcT0*#
_output_shapes
:’’’’’’’’’

(transform/transform/scale_to_0_1_2/sub_1Subtransform/Const_54transform/transform/scale_to_0_1_2/min_and_max/sub_1*
T0*
_output_shapes
: 
µ
*transform/transform/scale_to_0_1_2/truedivRealDiv&transform/transform/scale_to_0_1_2/sub(transform/transform/scale_to_0_1_2/sub_1*
T0*#
_output_shapes
:’’’’’’’’’
r
-transform/transform/scale_to_0_1_2/Fill/valueConst*
_output_shapes
: *
dtype0*
valueB
 *   ?
¶
'transform/transform/scale_to_0_1_2/FillFill(transform/transform/scale_to_0_1_2/Shape-transform/transform/scale_to_0_1_2/Fill/value*
T0*#
_output_shapes
:’’’’’’’’’
å
+transform/transform/scale_to_0_1_2/SelectV2SelectV2)transform/transform/scale_to_0_1_2/Cast_1*transform/transform/scale_to_0_1_2/truediv'transform/transform/scale_to_0_1_2/Fill*
T0*#
_output_shapes
:’’’’’’’’’
m
(transform/transform/scale_to_0_1_2/mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
²
&transform/transform/scale_to_0_1_2/mulMul+transform/transform/scale_to_0_1_2/SelectV2(transform/transform/scale_to_0_1_2/mul/y*
T0*#
_output_shapes
:’’’’’’’’’
o
*transform/transform/scale_to_0_1_2/add_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
³
(transform/transform/scale_to_0_1_2/add_1AddV2&transform/transform/scale_to_0_1_2/mul*transform/transform/scale_to_0_1_2/add_1/y*
T0*#
_output_shapes
:’’’’’’’’’
~
4transform/transform/scale_to_0_1_3/min_and_max/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
É
2transform/transform/scale_to_0_1_3/min_and_max/MaxMax7transform/transform/inputs/inputs/F_hours-per-week_copy4transform/transform/scale_to_0_1_3/min_and_max/Const*
T0*
_output_shapes
: 
­
9transform/transform/scale_to_0_1_3/min_and_max/zeros_like	ZerosLike7transform/transform/inputs/inputs/F_hours-per-week_copy*
T0*#
_output_shapes
:’’’’’’’’’
Ū
2transform/transform/scale_to_0_1_3/min_and_max/subSub9transform/transform/scale_to_0_1_3/min_and_max/zeros_like7transform/transform/inputs/inputs/F_hours-per-week_copy*
T0*#
_output_shapes
:’’’’’’’’’

6transform/transform/scale_to_0_1_3/min_and_max/Const_1Const*
_output_shapes
:*
dtype0*
valueB: 
Č
4transform/transform/scale_to_0_1_3/min_and_max/Max_1Max2transform/transform/scale_to_0_1_3/min_and_max/sub6transform/transform/scale_to_0_1_3/min_and_max/Const_1*
T0*
_output_shapes
: 
w
4transform/transform/scale_to_0_1_3/min_and_max/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
y
6transform/transform/scale_to_0_1_3/min_and_max/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
Ż
Ctransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/EqualEqual4transform/transform/scale_to_0_1_3/min_and_max/Shape6transform/transform/scale_to_0_1_3/min_and_max/Shape_1*
T0*
_output_shapes
: 

Ctransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
ź
Atransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/AllAllCtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/EqualCtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Const*
_output_shapes
: 
¶
Jtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/ConstConst*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¶
Ltransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Const_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_3/min_and_max/Shape:0) = 
ø
Ltransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Const_2Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_3/min_and_max/Shape_1:0) = 
¾
Rtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert/data_0Const*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¼
Rtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert/data_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_3/min_and_max/Shape:0) = 
¾
Rtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert/data_3Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_3/min_and_max/Shape_1:0) = 

Ktransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/AssertAssertAtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/AllRtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert/data_0Rtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert/data_14transform/transform/scale_to_0_1_3/min_and_max/ShapeRtransform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert/data_36transform/transform/scale_to_0_1_3/min_and_max/Shape_1*
T	
2
č
7transform/transform/scale_to_0_1_3/min_and_max/IdentityIdentity4transform/transform/scale_to_0_1_3/min_and_max/Max_1L^transform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
č
9transform/transform/scale_to_0_1_3/min_and_max/Identity_1Identity2transform/transform/scale_to_0_1_3/min_and_max/MaxL^transform/transform/scale_to_0_1_3/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_3/min_and_max/Const_2Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

4transform/transform/scale_to_0_1_3/min_and_max/IsInfIsInf7transform/transform/scale_to_0_1_3/min_and_max/Identity*
T0*
_output_shapes
: 
Ķ
2transform/transform/scale_to_0_1_3/min_and_max/addAddV27transform/transform/scale_to_0_1_3/min_and_max/Identity6transform/transform/scale_to_0_1_3/min_and_max/Const_2*
T0*
_output_shapes
: 

7transform/transform/scale_to_0_1_3/min_and_max/SelectV2SelectV24transform/transform/scale_to_0_1_3/min_and_max/IsInf2transform/transform/scale_to_0_1_3/min_and_max/add7transform/transform/scale_to_0_1_3/min_and_max/Identity*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_3/min_and_max/Const_3Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

6transform/transform/scale_to_0_1_3/min_and_max/IsInf_1IsInf9transform/transform/scale_to_0_1_3/min_and_max/Identity_1*
T0*
_output_shapes
: 
Ń
4transform/transform/scale_to_0_1_3/min_and_max/add_1AddV29transform/transform/scale_to_0_1_3/min_and_max/Identity_16transform/transform/scale_to_0_1_3/min_and_max/Const_3*
T0*
_output_shapes
: 

9transform/transform/scale_to_0_1_3/min_and_max/SelectV2_1SelectV26transform/transform/scale_to_0_1_3/min_and_max/IsInf_14transform/transform/scale_to_0_1_3/min_and_max/add_19transform/transform/scale_to_0_1_3/min_and_max/Identity_1*
T0*
_output_shapes
: 
{
:transform/transform/scale_to_0_1_3/min_and_max/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 
}
<transform/transform/scale_to_0_1_3/min_and_max/Placeholder_1Placeholder*
_output_shapes
: *
dtype0*
shape: 
{
6transform/transform/scale_to_0_1_3/min_and_max/sub_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *    
§
4transform/transform/scale_to_0_1_3/min_and_max/sub_1Sub6transform/transform/scale_to_0_1_3/min_and_max/sub_1/xtransform/Const_6*
T0*
_output_shapes
: 

(transform/transform/scale_to_0_1_3/ShapeShape7transform/transform/inputs/inputs/F_hours-per-week_copy*
T0*
_output_shapes
:
Ź
&transform/transform/scale_to_0_1_3/subSub7transform/transform/inputs/inputs/F_hours-per-week_copy4transform/transform/scale_to_0_1_3/min_and_max/sub_1*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_3/LessLess4transform/transform/scale_to_0_1_3/min_and_max/sub_1transform/Const_7*
T0*
_output_shapes
: 

-transform/transform/scale_to_0_1_3/zeros_like	ZerosLike&transform/transform/scale_to_0_1_3/sub*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_3/CastCast'transform/transform/scale_to_0_1_3/Less*

DstT0*

SrcT0
*
_output_shapes
: 
µ
&transform/transform/scale_to_0_1_3/addAddV2-transform/transform/scale_to_0_1_3/zeros_like'transform/transform/scale_to_0_1_3/Cast*
T0*#
_output_shapes
:’’’’’’’’’

)transform/transform/scale_to_0_1_3/Cast_1Cast&transform/transform/scale_to_0_1_3/add*

DstT0
*

SrcT0*#
_output_shapes
:’’’’’’’’’

(transform/transform/scale_to_0_1_3/sub_1Subtransform/Const_74transform/transform/scale_to_0_1_3/min_and_max/sub_1*
T0*
_output_shapes
: 
µ
*transform/transform/scale_to_0_1_3/truedivRealDiv&transform/transform/scale_to_0_1_3/sub(transform/transform/scale_to_0_1_3/sub_1*
T0*#
_output_shapes
:’’’’’’’’’
r
-transform/transform/scale_to_0_1_3/Fill/valueConst*
_output_shapes
: *
dtype0*
valueB
 *   ?
¶
'transform/transform/scale_to_0_1_3/FillFill(transform/transform/scale_to_0_1_3/Shape-transform/transform/scale_to_0_1_3/Fill/value*
T0*#
_output_shapes
:’’’’’’’’’
å
+transform/transform/scale_to_0_1_3/SelectV2SelectV2)transform/transform/scale_to_0_1_3/Cast_1*transform/transform/scale_to_0_1_3/truediv'transform/transform/scale_to_0_1_3/Fill*
T0*#
_output_shapes
:’’’’’’’’’
m
(transform/transform/scale_to_0_1_3/mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
²
&transform/transform/scale_to_0_1_3/mulMul+transform/transform/scale_to_0_1_3/SelectV2(transform/transform/scale_to_0_1_3/mul/y*
T0*#
_output_shapes
:’’’’’’’’’
o
*transform/transform/scale_to_0_1_3/add_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
³
(transform/transform/scale_to_0_1_3/add_1AddV2&transform/transform/scale_to_0_1_3/mul*transform/transform/scale_to_0_1_3/add_1/y*
T0*#
_output_shapes
:’’’’’’’’’
q
'transform/transform/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
s
)transform/transform/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
s
)transform/transform/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
“
!transform/transform/strided_sliceStridedSlice<transform/transform/inputs/inputs/F_education-num/shape_copy'transform/transform/strided_slice/stack)transform/transform/strided_slice/stack_1)transform/transform/strided_slice/stack_2*
Index0*
T0	*
_output_shapes
: *
shrink_axis_mask
p
.transform/transform/SparseTensor/dense_shape/1Const*
_output_shapes
: *
dtype0	*
value	B	 R
µ
,transform/transform/SparseTensor/dense_shapePack!transform/transform/strided_slice.transform/transform/SparseTensor/dense_shape/1*
N*
T0	*
_output_shapes
:
t
/transform/transform/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    
Ņ
!transform/transform/SparseToDenseSparseToDense>transform/transform/inputs/inputs/F_education-num/indices_copy,transform/transform/SparseTensor/dense_shape=transform/transform/inputs/inputs/F_education-num/values_copy/transform/transform/SparseToDense/default_value*
T0*
Tindices0	*'
_output_shapes
:’’’’’’’’’

transform/transform/SqueezeSqueeze!transform/transform/SparseToDense*
T0*#
_output_shapes
:’’’’’’’’’*
squeeze_dims

~
4transform/transform/scale_to_0_1_4/min_and_max/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
­
2transform/transform/scale_to_0_1_4/min_and_max/MaxMaxtransform/transform/Squeeze4transform/transform/scale_to_0_1_4/min_and_max/Const*
T0*
_output_shapes
: 

9transform/transform/scale_to_0_1_4/min_and_max/zeros_like	ZerosLiketransform/transform/Squeeze*
T0*#
_output_shapes
:’’’’’’’’’
æ
2transform/transform/scale_to_0_1_4/min_and_max/subSub9transform/transform/scale_to_0_1_4/min_and_max/zeros_liketransform/transform/Squeeze*
T0*#
_output_shapes
:’’’’’’’’’

6transform/transform/scale_to_0_1_4/min_and_max/Const_1Const*
_output_shapes
:*
dtype0*
valueB: 
Č
4transform/transform/scale_to_0_1_4/min_and_max/Max_1Max2transform/transform/scale_to_0_1_4/min_and_max/sub6transform/transform/scale_to_0_1_4/min_and_max/Const_1*
T0*
_output_shapes
: 
w
4transform/transform/scale_to_0_1_4/min_and_max/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
y
6transform/transform/scale_to_0_1_4/min_and_max/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
Ż
Ctransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/EqualEqual4transform/transform/scale_to_0_1_4/min_and_max/Shape6transform/transform/scale_to_0_1_4/min_and_max/Shape_1*
T0*
_output_shapes
: 

Ctransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
ź
Atransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/AllAllCtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/EqualCtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Const*
_output_shapes
: 
¶
Jtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/ConstConst*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¶
Ltransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Const_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_4/min_and_max/Shape:0) = 
ø
Ltransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Const_2Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_4/min_and_max/Shape_1:0) = 
¾
Rtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert/data_0Const*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:
¼
Rtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert/data_1Const*
_output_shapes
: *
dtype0*:
value1B/ B)x (scale_to_0_1_4/min_and_max/Shape:0) = 
¾
Rtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert/data_3Const*
_output_shapes
: *
dtype0*<
value3B1 B+y (scale_to_0_1_4/min_and_max/Shape_1:0) = 

Ktransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/AssertAssertAtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/AllRtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert/data_0Rtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert/data_14transform/transform/scale_to_0_1_4/min_and_max/ShapeRtransform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert/data_36transform/transform/scale_to_0_1_4/min_and_max/Shape_1*
T	
2
č
7transform/transform/scale_to_0_1_4/min_and_max/IdentityIdentity4transform/transform/scale_to_0_1_4/min_and_max/Max_1L^transform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
č
9transform/transform/scale_to_0_1_4/min_and_max/Identity_1Identity2transform/transform/scale_to_0_1_4/min_and_max/MaxL^transform/transform/scale_to_0_1_4/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_4/min_and_max/Const_2Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

4transform/transform/scale_to_0_1_4/min_and_max/IsInfIsInf7transform/transform/scale_to_0_1_4/min_and_max/Identity*
T0*
_output_shapes
: 
Ķ
2transform/transform/scale_to_0_1_4/min_and_max/addAddV27transform/transform/scale_to_0_1_4/min_and_max/Identity6transform/transform/scale_to_0_1_4/min_and_max/Const_2*
T0*
_output_shapes
: 

7transform/transform/scale_to_0_1_4/min_and_max/SelectV2SelectV24transform/transform/scale_to_0_1_4/min_and_max/IsInf2transform/transform/scale_to_0_1_4/min_and_max/add7transform/transform/scale_to_0_1_4/min_and_max/Identity*
T0*
_output_shapes
: 
{
6transform/transform/scale_to_0_1_4/min_and_max/Const_3Const*
_output_shapes
: *
dtype0*
valueB
 *  Ą’

6transform/transform/scale_to_0_1_4/min_and_max/IsInf_1IsInf9transform/transform/scale_to_0_1_4/min_and_max/Identity_1*
T0*
_output_shapes
: 
Ń
4transform/transform/scale_to_0_1_4/min_and_max/add_1AddV29transform/transform/scale_to_0_1_4/min_and_max/Identity_16transform/transform/scale_to_0_1_4/min_and_max/Const_3*
T0*
_output_shapes
: 

9transform/transform/scale_to_0_1_4/min_and_max/SelectV2_1SelectV26transform/transform/scale_to_0_1_4/min_and_max/IsInf_14transform/transform/scale_to_0_1_4/min_and_max/add_19transform/transform/scale_to_0_1_4/min_and_max/Identity_1*
T0*
_output_shapes
: 
{
:transform/transform/scale_to_0_1_4/min_and_max/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 
}
<transform/transform/scale_to_0_1_4/min_and_max/Placeholder_1Placeholder*
_output_shapes
: *
dtype0*
shape: 
{
6transform/transform/scale_to_0_1_4/min_and_max/sub_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *    
§
4transform/transform/scale_to_0_1_4/min_and_max/sub_1Sub6transform/transform/scale_to_0_1_4/min_and_max/sub_1/xtransform/Const_8*
T0*
_output_shapes
: 
s
(transform/transform/scale_to_0_1_4/ShapeShapetransform/transform/Squeeze*
T0*
_output_shapes
:
®
&transform/transform/scale_to_0_1_4/subSubtransform/transform/Squeeze4transform/transform/scale_to_0_1_4/min_and_max/sub_1*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_4/LessLess4transform/transform/scale_to_0_1_4/min_and_max/sub_1transform/Const_9*
T0*
_output_shapes
: 

-transform/transform/scale_to_0_1_4/zeros_like	ZerosLike&transform/transform/scale_to_0_1_4/sub*
T0*#
_output_shapes
:’’’’’’’’’

'transform/transform/scale_to_0_1_4/CastCast'transform/transform/scale_to_0_1_4/Less*

DstT0*

SrcT0
*
_output_shapes
: 
µ
&transform/transform/scale_to_0_1_4/addAddV2-transform/transform/scale_to_0_1_4/zeros_like'transform/transform/scale_to_0_1_4/Cast*
T0*#
_output_shapes
:’’’’’’’’’

)transform/transform/scale_to_0_1_4/Cast_1Cast&transform/transform/scale_to_0_1_4/add*

DstT0
*

SrcT0*#
_output_shapes
:’’’’’’’’’

(transform/transform/scale_to_0_1_4/sub_1Subtransform/Const_94transform/transform/scale_to_0_1_4/min_and_max/sub_1*
T0*
_output_shapes
: 
µ
*transform/transform/scale_to_0_1_4/truedivRealDiv&transform/transform/scale_to_0_1_4/sub(transform/transform/scale_to_0_1_4/sub_1*
T0*#
_output_shapes
:’’’’’’’’’
r
-transform/transform/scale_to_0_1_4/Fill/valueConst*
_output_shapes
: *
dtype0*
valueB
 *   ?
¶
'transform/transform/scale_to_0_1_4/FillFill(transform/transform/scale_to_0_1_4/Shape-transform/transform/scale_to_0_1_4/Fill/value*
T0*#
_output_shapes
:’’’’’’’’’
å
+transform/transform/scale_to_0_1_4/SelectV2SelectV2)transform/transform/scale_to_0_1_4/Cast_1*transform/transform/scale_to_0_1_4/truediv'transform/transform/scale_to_0_1_4/Fill*
T0*#
_output_shapes
:’’’’’’’’’
m
(transform/transform/scale_to_0_1_4/mul/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
²
&transform/transform/scale_to_0_1_4/mulMul+transform/transform/scale_to_0_1_4/SelectV2(transform/transform/scale_to_0_1_4/mul/y*
T0*#
_output_shapes
:’’’’’’’’’
o
*transform/transform/scale_to_0_1_4/add_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
³
(transform/transform/scale_to_0_1_4/add_1AddV2&transform/transform/scale_to_0_1_4/mul*transform/transform/scale_to_0_1_4/add_1/y*
T0*#
_output_shapes
:’’’’’’’’’

,transform/transform/vocabulary/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
æ
&transform/transform/vocabulary/ReshapeReshape0transform/transform/inputs/inputs/workclass_copy,transform/transform/vocabulary/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’
}
<transform/transform/vocabulary/workclass_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
k
*transform/transform/vocabulary/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_1/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
Ć
(transform/transform/vocabulary_1/ReshapeReshape0transform/transform/inputs/inputs/education_copy.transform/transform/vocabulary_1/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’

>transform/transform/vocabulary_1/education_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_1/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_2/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
Ź
(transform/transform/vocabulary_2/ReshapeReshape7transform/transform/inputs/inputs/F_marital-status_copy.transform/transform/vocabulary_2/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’

Ctransform/transform/vocabulary_2/marital-status_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_2/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_3/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
Ä
(transform/transform/vocabulary_3/ReshapeReshape1transform/transform/inputs/inputs/occupation_copy.transform/transform/vocabulary_3/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’

?transform/transform/vocabulary_3/occupation_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_3/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_4/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
Ę
(transform/transform/vocabulary_4/ReshapeReshape3transform/transform/inputs/inputs/relationship_copy.transform/transform/vocabulary_4/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’

Atransform/transform/vocabulary_4/relationship_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_4/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_5/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
¾
(transform/transform/vocabulary_5/ReshapeReshape+transform/transform/inputs/inputs/race_copy.transform/transform/vocabulary_5/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’
z
9transform/transform/vocabulary_5/race_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_5/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_6/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
½
(transform/transform/vocabulary_6/ReshapeReshape*transform/transform/inputs/inputs/sex_copy.transform/transform/vocabulary_6/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’
y
8transform/transform/vocabulary_6/sex_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_6/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 

.transform/transform/vocabulary_7/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
’’’’’’’’’
Ź
(transform/transform/vocabulary_7/ReshapeReshape7transform/transform/inputs/inputs/F_native-country_copy.transform/transform/vocabulary_7/Reshape/shape*
T0*#
_output_shapes
:’’’’’’’’’

Ctransform/transform/vocabulary_7/native-country_unpruned_vocab_sizePlaceholder*
_output_shapes
: *
dtype0	*
shape: 
m
,transform/transform/vocabulary_7/PlaceholderPlaceholder*
_output_shapes
: *
dtype0*
shape: 
a
transform/transform/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
a
transform/transform/range/limitConst*
_output_shapes
: *
dtype0*
value	B :
a
transform/transform/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
”
transform/transform/rangeRangetransform/transform/range/starttransform/transform/range/limittransform/transform/range/delta*
_output_shapes
:
o
transform/transform/CastCasttransform/transform/range*

DstT0	*

SrcT0*
_output_shapes
:
l
transform/transform/keysConst*
_output_shapes
:*
dtype0* 
valueBB>50KB<=50K
d
transform/transform/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
«
transform/transform/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*@
shared_name1/hash_table_6d2afb1f-e259-4c38-bd66-1db53af0cadb*
value_dtype0	
ø
6transform/transform/key_value_init/LookupTableImportV2LookupTableImportV2transform/transform/hash_tabletransform/transform/keystransform/transform/Cast*	
Tin0*

Tout0	
ń
7transform/transform/hash_table_Lookup/LookupTableFindV2LookupTableFindV2transform/transform/hash_table,transform/transform/inputs/inputs/label_copytransform/transform/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
 
transform/transform/initNoOp
"
transform/transform/init_1NoOp

transform/initNoOp
ŗ
1linear/linear_model/age/weights/Initializer/zerosConst*2
_class(
&$loc:@linear/linear_model/age/weights*
_output_shapes

:*
dtype0*
valueB*    
Ī
linear/linear_model/age/weightsVarHandleOp*2
_class(
&$loc:@linear/linear_model/age/weights*
_output_shapes
: *
dtype0*
shape
:*0
shared_name!linear/linear_model/age/weights

@linear/linear_model/age/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOplinear/linear_model/age/weights*
_output_shapes
: 

&linear/linear_model/age/weights/AssignAssignVariableOplinear/linear_model/age/weights1linear/linear_model/age/weights/Initializer/zeros*
dtype0

3linear/linear_model/age/weights/Read/ReadVariableOpReadVariableOplinear/linear_model/age/weights*
_output_shapes

:*
dtype0
Ģ
:linear/linear_model/capital-gain/weights/Initializer/zerosConst*;
_class1
/-loc:@linear/linear_model/capital-gain/weights*
_output_shapes

:*
dtype0*
valueB*    
é
(linear/linear_model/capital-gain/weightsVarHandleOp*;
_class1
/-loc:@linear/linear_model/capital-gain/weights*
_output_shapes
: *
dtype0*
shape
:*9
shared_name*(linear/linear_model/capital-gain/weights
”
Ilinear/linear_model/capital-gain/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp(linear/linear_model/capital-gain/weights*
_output_shapes
: 
¶
/linear/linear_model/capital-gain/weights/AssignAssignVariableOp(linear/linear_model/capital-gain/weights:linear/linear_model/capital-gain/weights/Initializer/zeros*
dtype0
„
<linear/linear_model/capital-gain/weights/Read/ReadVariableOpReadVariableOp(linear/linear_model/capital-gain/weights*
_output_shapes

:*
dtype0
Ģ
:linear/linear_model/capital-loss/weights/Initializer/zerosConst*;
_class1
/-loc:@linear/linear_model/capital-loss/weights*
_output_shapes

:*
dtype0*
valueB*    
é
(linear/linear_model/capital-loss/weightsVarHandleOp*;
_class1
/-loc:@linear/linear_model/capital-loss/weights*
_output_shapes
: *
dtype0*
shape
:*9
shared_name*(linear/linear_model/capital-loss/weights
”
Ilinear/linear_model/capital-loss/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp(linear/linear_model/capital-loss/weights*
_output_shapes
: 
¶
/linear/linear_model/capital-loss/weights/AssignAssignVariableOp(linear/linear_model/capital-loss/weights:linear/linear_model/capital-loss/weights/Initializer/zeros*
dtype0
„
<linear/linear_model/capital-loss/weights/Read/ReadVariableOpReadVariableOp(linear/linear_model/capital-loss/weights*
_output_shapes

:*
dtype0
Ś
Alinear/linear_model/education_indicator/weights/Initializer/zerosConst*B
_class8
64loc:@linear/linear_model/education_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    
ž
/linear/linear_model/education_indicator/weightsVarHandleOp*B
_class8
64loc:@linear/linear_model/education_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*@
shared_name1/linear/linear_model/education_indicator/weights
Æ
Plinear/linear_model/education_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp/linear/linear_model/education_indicator/weights*
_output_shapes
: 
Ė
6linear/linear_model/education_indicator/weights/AssignAssignVariableOp/linear/linear_model/education_indicator/weightsAlinear/linear_model/education_indicator/weights/Initializer/zeros*
dtype0
³
Clinear/linear_model/education_indicator/weights/Read/ReadVariableOpReadVariableOp/linear/linear_model/education_indicator/weights*
_output_shapes

:*
dtype0
Š
<linear/linear_model/hours-per-week/weights/Initializer/zerosConst*=
_class3
1/loc:@linear/linear_model/hours-per-week/weights*
_output_shapes

:*
dtype0*
valueB*    
ļ
*linear/linear_model/hours-per-week/weightsVarHandleOp*=
_class3
1/loc:@linear/linear_model/hours-per-week/weights*
_output_shapes
: *
dtype0*
shape
:*;
shared_name,*linear/linear_model/hours-per-week/weights
„
Klinear/linear_model/hours-per-week/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp*linear/linear_model/hours-per-week/weights*
_output_shapes
: 
¼
1linear/linear_model/hours-per-week/weights/AssignAssignVariableOp*linear/linear_model/hours-per-week/weights<linear/linear_model/hours-per-week/weights/Initializer/zeros*
dtype0
©
>linear/linear_model/hours-per-week/weights/Read/ReadVariableOpReadVariableOp*linear/linear_model/hours-per-week/weights*
_output_shapes

:*
dtype0
ä
Flinear/linear_model/marital-status_indicator/weights/Initializer/zerosConst*G
_class=
;9loc:@linear/linear_model/marital-status_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    

4linear/linear_model/marital-status_indicator/weightsVarHandleOp*G
_class=
;9loc:@linear/linear_model/marital-status_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*E
shared_name64linear/linear_model/marital-status_indicator/weights
¹
Ulinear/linear_model/marital-status_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp4linear/linear_model/marital-status_indicator/weights*
_output_shapes
: 
Ś
;linear/linear_model/marital-status_indicator/weights/AssignAssignVariableOp4linear/linear_model/marital-status_indicator/weightsFlinear/linear_model/marital-status_indicator/weights/Initializer/zeros*
dtype0
½
Hlinear/linear_model/marital-status_indicator/weights/Read/ReadVariableOpReadVariableOp4linear/linear_model/marital-status_indicator/weights*
_output_shapes

:*
dtype0
ä
Flinear/linear_model/native-country_indicator/weights/Initializer/zerosConst*G
_class=
;9loc:@linear/linear_model/native-country_indicator/weights*
_output_shapes

:$*
dtype0*
valueB$*    

4linear/linear_model/native-country_indicator/weightsVarHandleOp*G
_class=
;9loc:@linear/linear_model/native-country_indicator/weights*
_output_shapes
: *
dtype0*
shape
:$*E
shared_name64linear/linear_model/native-country_indicator/weights
¹
Ulinear/linear_model/native-country_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp4linear/linear_model/native-country_indicator/weights*
_output_shapes
: 
Ś
;linear/linear_model/native-country_indicator/weights/AssignAssignVariableOp4linear/linear_model/native-country_indicator/weightsFlinear/linear_model/native-country_indicator/weights/Initializer/zeros*
dtype0
½
Hlinear/linear_model/native-country_indicator/weights/Read/ReadVariableOpReadVariableOp4linear/linear_model/native-country_indicator/weights*
_output_shapes

:$*
dtype0
Ü
Blinear/linear_model/occupation_indicator/weights/Initializer/zerosConst*C
_class9
75loc:@linear/linear_model/occupation_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    

0linear/linear_model/occupation_indicator/weightsVarHandleOp*C
_class9
75loc:@linear/linear_model/occupation_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*A
shared_name20linear/linear_model/occupation_indicator/weights
±
Qlinear/linear_model/occupation_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp0linear/linear_model/occupation_indicator/weights*
_output_shapes
: 
Ī
7linear/linear_model/occupation_indicator/weights/AssignAssignVariableOp0linear/linear_model/occupation_indicator/weightsBlinear/linear_model/occupation_indicator/weights/Initializer/zeros*
dtype0
µ
Dlinear/linear_model/occupation_indicator/weights/Read/ReadVariableOpReadVariableOp0linear/linear_model/occupation_indicator/weights*
_output_shapes

:*
dtype0
Š
<linear/linear_model/race_indicator/weights/Initializer/zerosConst*=
_class3
1/loc:@linear/linear_model/race_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    
ļ
*linear/linear_model/race_indicator/weightsVarHandleOp*=
_class3
1/loc:@linear/linear_model/race_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*;
shared_name,*linear/linear_model/race_indicator/weights
„
Klinear/linear_model/race_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp*linear/linear_model/race_indicator/weights*
_output_shapes
: 
¼
1linear/linear_model/race_indicator/weights/AssignAssignVariableOp*linear/linear_model/race_indicator/weights<linear/linear_model/race_indicator/weights/Initializer/zeros*
dtype0
©
>linear/linear_model/race_indicator/weights/Read/ReadVariableOpReadVariableOp*linear/linear_model/race_indicator/weights*
_output_shapes

:*
dtype0
ą
Dlinear/linear_model/relationship_indicator/weights/Initializer/zerosConst*E
_class;
97loc:@linear/linear_model/relationship_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    

2linear/linear_model/relationship_indicator/weightsVarHandleOp*E
_class;
97loc:@linear/linear_model/relationship_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*C
shared_name42linear/linear_model/relationship_indicator/weights
µ
Slinear/linear_model/relationship_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp2linear/linear_model/relationship_indicator/weights*
_output_shapes
: 
Ō
9linear/linear_model/relationship_indicator/weights/AssignAssignVariableOp2linear/linear_model/relationship_indicator/weightsDlinear/linear_model/relationship_indicator/weights/Initializer/zeros*
dtype0
¹
Flinear/linear_model/relationship_indicator/weights/Read/ReadVariableOpReadVariableOp2linear/linear_model/relationship_indicator/weights*
_output_shapes

:*
dtype0
Ī
;linear/linear_model/sex_indicator/weights/Initializer/zerosConst*<
_class2
0.loc:@linear/linear_model/sex_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    
ģ
)linear/linear_model/sex_indicator/weightsVarHandleOp*<
_class2
0.loc:@linear/linear_model/sex_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*:
shared_name+)linear/linear_model/sex_indicator/weights
£
Jlinear/linear_model/sex_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp)linear/linear_model/sex_indicator/weights*
_output_shapes
: 
¹
0linear/linear_model/sex_indicator/weights/AssignAssignVariableOp)linear/linear_model/sex_indicator/weights;linear/linear_model/sex_indicator/weights/Initializer/zeros*
dtype0
§
=linear/linear_model/sex_indicator/weights/Read/ReadVariableOpReadVariableOp)linear/linear_model/sex_indicator/weights*
_output_shapes

:*
dtype0
Ś
Alinear/linear_model/workclass_indicator/weights/Initializer/zerosConst*B
_class8
64loc:@linear/linear_model/workclass_indicator/weights*
_output_shapes

:*
dtype0*
valueB*    
ž
/linear/linear_model/workclass_indicator/weightsVarHandleOp*B
_class8
64loc:@linear/linear_model/workclass_indicator/weights*
_output_shapes
: *
dtype0*
shape
:*@
shared_name1/linear/linear_model/workclass_indicator/weights
Æ
Plinear/linear_model/workclass_indicator/weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp/linear/linear_model/workclass_indicator/weights*
_output_shapes
: 
Ė
6linear/linear_model/workclass_indicator/weights/AssignAssignVariableOp/linear/linear_model/workclass_indicator/weightsAlinear/linear_model/workclass_indicator/weights/Initializer/zeros*
dtype0
³
Clinear/linear_model/workclass_indicator/weights/Read/ReadVariableOpReadVariableOp/linear/linear_model/workclass_indicator/weights*
_output_shapes

:*
dtype0
“
2linear/linear_model/bias_weights/Initializer/zerosConst*3
_class)
'%loc:@linear/linear_model/bias_weights*
_output_shapes
:*
dtype0*
valueB*    
Ķ
 linear/linear_model/bias_weightsVarHandleOp*3
_class)
'%loc:@linear/linear_model/bias_weights*
_output_shapes
: *
dtype0*
shape:*1
shared_name" linear/linear_model/bias_weights

Alinear/linear_model/bias_weights/IsInitialized/VarIsInitializedOpVarIsInitializedOp linear/linear_model/bias_weights*
_output_shapes
: 

'linear/linear_model/bias_weights/AssignAssignVariableOp linear/linear_model/bias_weights2linear/linear_model/bias_weights/Initializer/zeros*
dtype0

4linear/linear_model/bias_weights/Read/ReadVariableOpReadVariableOp linear/linear_model/bias_weights*
_output_shapes
:*
dtype0

Nlinear/linear_model/linear/linear_model/linear/linear_model/age/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

Jlinear/linear_model/linear/linear_model/linear/linear_model/age/ExpandDims
ExpandDims&transform/transform/scale_to_0_1/add_1Nlinear/linear_model/linear/linear_model/linear/linear_model/age/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
æ
Elinear/linear_model/linear/linear_model/linear/linear_model/age/ShapeShapeJlinear/linear_model/linear/linear_model/linear/linear_model/age/ExpandDims*
T0*
_output_shapes
:

Slinear/linear_model/linear/linear_model/linear/linear_model/age/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 

Ulinear/linear_model/linear/linear_model/linear/linear_model/age/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:

Ulinear/linear_model/linear/linear_model/linear/linear_model/age/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
ķ
Mlinear/linear_model/linear/linear_model/linear/linear_model/age/strided_sliceStridedSliceElinear/linear_model/linear/linear_model/linear/linear_model/age/ShapeSlinear/linear_model/linear/linear_model/linear/linear_model/age/strided_slice/stackUlinear/linear_model/linear/linear_model/linear/linear_model/age/strided_slice/stack_1Ulinear/linear_model/linear/linear_model/linear/linear_model/age/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask

Olinear/linear_model/linear/linear_model/linear/linear_model/age/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
£
Mlinear/linear_model/linear/linear_model/linear/linear_model/age/Reshape/shapePackMlinear/linear_model/linear/linear_model/linear/linear_model/age/strided_sliceOlinear/linear_model/linear/linear_model/linear/linear_model/age/Reshape/shape/1*
N*
T0*
_output_shapes
:

Glinear/linear_model/linear/linear_model/linear/linear_model/age/ReshapeReshapeJlinear/linear_model/linear/linear_model/linear/linear_model/age/ExpandDimsMlinear/linear_model/linear/linear_model/linear/linear_model/age/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
»
[linear/linear_model/linear/linear_model/linear/linear_model/age/weighted_sum/ReadVariableOpReadVariableOplinear/linear_model/age/weights*
_output_shapes

:*
dtype0
®
Llinear/linear_model/linear/linear_model/linear/linear_model/age/weighted_sumMatMulGlinear/linear_model/linear/linear_model/linear/linear_model/age/Reshape[linear/linear_model/linear/linear_model/linear/linear_model/age/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
¢
Wlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

Slinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ExpandDims
ExpandDims(transform/transform/scale_to_0_1_1/add_1Wlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
Ń
Nlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ShapeShapeSlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ExpandDims*
T0*
_output_shapes
:
¦
\linear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
Ø
^linear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
Ø
^linear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:

Vlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_sliceStridedSliceNlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/Shape\linear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_slice/stack^linear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_slice/stack_1^linear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask

Xlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
¾
Vlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/Reshape/shapePackVlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/strided_sliceXlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/Reshape/shape/1*
N*
T0*
_output_shapes
:
ŗ
Plinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ReshapeReshapeSlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/ExpandDimsVlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ķ
dlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/weighted_sum/ReadVariableOpReadVariableOp(linear/linear_model/capital-gain/weights*
_output_shapes

:*
dtype0
É
Ulinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/weighted_sumMatMulPlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/Reshapedlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
¢
Wlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

Slinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ExpandDims
ExpandDims(transform/transform/scale_to_0_1_2/add_1Wlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
Ń
Nlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ShapeShapeSlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ExpandDims*
T0*
_output_shapes
:
¦
\linear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
Ø
^linear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
Ø
^linear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:

Vlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_sliceStridedSliceNlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/Shape\linear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_slice/stack^linear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_slice/stack_1^linear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask

Xlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
¾
Vlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/Reshape/shapePackVlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/strided_sliceXlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/Reshape/shape/1*
N*
T0*
_output_shapes
:
ŗ
Plinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ReshapeReshapeSlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/ExpandDimsVlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ķ
dlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/weighted_sum/ReadVariableOpReadVariableOp(linear/linear_model/capital-loss/weights*
_output_shapes

:*
dtype0
É
Ulinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/weighted_sumMatMulPlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/Reshapedlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
©
^linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
¬
Zlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ExpandDims
ExpandDims0transform/transform/inputs/inputs/education_copy^linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
Æ
nlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 
ņ
hlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/NotEqualNotEqualZlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ExpandDimsnlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’

glinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/indicesWherehlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’
ū
flinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/valuesGatherNdZlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ExpandDimsglinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’

klinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/dense_shapeShapeZlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	
¢
vlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*m
valuedBb B\D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\education
¼
qlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Å
vlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_namerphash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\education_16_-2_-1*
value_dtype0	
ī
linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2vlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/hash_tablevlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size

slinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2vlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/hash_tableflinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/valuesqlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
¶
klinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
č
]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/SparseToDenseSparseToDenseglinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/indicesklinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/to_sparse_input/dense_shapeslinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/hash_table_Lookup/LookupTableFindV2klinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’
¢
]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
¤
_linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    

]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :
„
`linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
¦
alinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    

Wlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hotOneHot]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/SparseToDense]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/depth`linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/on_valuealinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
ø
elinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
Ģ
Slinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/SumSumWlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/one_hotelinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
Ų
Ulinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ShapeShapeSlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Sum*
T0*
_output_shapes
:
­
clinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
Æ
elinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
Æ
elinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
½
]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_sliceStridedSliceUlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Shapeclinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice/stackelinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice/stack_1elinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
”
_linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Ó
]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Reshape/shapePack]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/strided_slice_linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
Č
Wlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/ReshapeReshapeSlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Sum]linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ū
klinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/weighted_sum/ReadVariableOpReadVariableOp/linear/linear_model/education_indicator/weights*
_output_shapes

:*
dtype0
Ž
\linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/weighted_sumMatMulWlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/Reshapeklinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
¤
Ylinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

Ulinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ExpandDims
ExpandDims(transform/transform/scale_to_0_1_3/add_1Ylinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
Õ
Plinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ShapeShapeUlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ExpandDims*
T0*
_output_shapes
:
Ø
^linear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
Ŗ
`linear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
Ŗ
`linear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
¤
Xlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_sliceStridedSlicePlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/Shape^linear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_slice/stack`linear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_slice/stack_1`linear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask

Zlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Ä
Xlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/Reshape/shapePackXlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/strided_sliceZlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/Reshape/shape/1*
N*
T0*
_output_shapes
:
Ą
Rlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ReshapeReshapeUlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/ExpandDimsXlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ń
flinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/weighted_sum/ReadVariableOpReadVariableOp*linear/linear_model/hours-per-week/weights*
_output_shapes

:*
dtype0
Ļ
Wlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/weighted_sumMatMulRlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/Reshapeflinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
®
clinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
½
_linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ExpandDims
ExpandDims7transform/transform/inputs/inputs/F_marital-status_copyclinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
“
slinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 

mlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/NotEqualNotEqual_linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ExpandDimsslinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’

llinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/indicesWheremlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’

klinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/valuesGatherNd_linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ExpandDimsllinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’

plinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/dense_shapeShape_linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	
²
linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*r
valueiBg BaD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\marital-status
Ę
{linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Ō
linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_namevthash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\marital-status_7_-2_-1*
value_dtype0	

linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/hash_tablelinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size
¶
xlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/hash_tableklinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/values{linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
»
plinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’

blinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/SparseToDenseSparseToDensellinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/indicesplinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/to_sparse_input/dense_shapexlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/hash_table_Lookup/LookupTableFindV2plinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’
§
blinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
©
dlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    
¤
blinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :
Ŗ
elinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
«
flinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    
³
\linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hotOneHotblinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/SparseToDenseblinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/depthelinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/on_valueflinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
½
jlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
Ū
Xlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/SumSum\linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/one_hotjlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
ā
Zlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ShapeShapeXlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Sum*
T0*
_output_shapes
:
²
hlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
“
jlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
“
jlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ö
blinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_sliceStridedSliceZlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Shapehlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slice/stackjlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slice/stack_1jlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
¦
dlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
ā
blinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Reshape/shapePackblinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/strided_slicedlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
×
\linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/ReshapeReshapeXlinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Sumblinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
å
plinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/weighted_sum/ReadVariableOpReadVariableOp4linear/linear_model/marital-status_indicator/weights*
_output_shapes

:*
dtype0
ķ
alinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/weighted_sumMatMul\linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/Reshapeplinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
®
clinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
½
_linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ExpandDims
ExpandDims7transform/transform/inputs/inputs/F_native-country_copyclinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
“
slinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 

mlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/NotEqualNotEqual_linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ExpandDimsslinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’

llinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/indicesWheremlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’

klinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/valuesGatherNd_linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ExpandDimsllinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’

plinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/dense_shapeShape_linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	
²
linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*r
valueiBg BaD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\native-country
Ę
{linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Õ
linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_namewuhash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\native-country_36_-2_-1*
value_dtype0	

linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/hash_tablelinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size$
¶
xlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/hash_tableklinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/values{linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
»
plinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’

blinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/SparseToDenseSparseToDensellinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/indicesplinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/to_sparse_input/dense_shapexlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/hash_table_Lookup/LookupTableFindV2plinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’
§
blinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
©
dlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    
¤
blinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :$
Ŗ
elinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
«
flinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    
³
\linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hotOneHotblinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/SparseToDenseblinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/depthelinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/on_valueflinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’$
½
jlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
Ū
Xlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/SumSum\linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/one_hotjlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’$
ā
Zlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ShapeShapeXlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Sum*
T0*
_output_shapes
:
²
hlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
“
jlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
“
jlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ö
blinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_sliceStridedSliceZlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Shapehlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slice/stackjlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slice/stack_1jlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
¦
dlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :$
ā
blinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Reshape/shapePackblinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/strided_slicedlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
×
\linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/ReshapeReshapeXlinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Sumblinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’$
å
plinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/weighted_sum/ReadVariableOpReadVariableOp4linear/linear_model/native-country_indicator/weights*
_output_shapes

:$*
dtype0
ķ
alinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/weighted_sumMatMul\linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/Reshapeplinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
Ŗ
_linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
Æ
[linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ExpandDims
ExpandDims1transform/transform/inputs/inputs/occupation_copy_linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
°
olinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 
õ
ilinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/NotEqualNotEqual[linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ExpandDimsolinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’

hlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/indicesWhereilinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’
ž
glinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/valuesGatherNd[linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ExpandDimshlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’

llinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/dense_shapeShape[linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	
„
xlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*n
valueeBc B]D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\occupation
¾
slinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Č
xlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_namesqhash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\occupation_15_-2_-1*
value_dtype0	
ō
linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2xlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/hash_tablexlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size

tlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2xlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/hash_tableglinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/valuesslinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
·
llinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
ķ
^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/SparseToDenseSparseToDensehlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/indicesllinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/to_sparse_input/dense_shapetlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/hash_table_Lookup/LookupTableFindV2llinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’
£
^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
„
`linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    
 
^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :
¦
alinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
§
blinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    

Xlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hotOneHot^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/SparseToDense^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/depthalinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/on_valueblinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
¹
flinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
Ļ
Tlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/SumSumXlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/one_hotflinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
Ś
Vlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ShapeShapeTlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Sum*
T0*
_output_shapes
:
®
dlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
°
flinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
°
flinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ā
^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_sliceStridedSliceVlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Shapedlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice/stackflinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice/stack_1flinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
¢
`linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Ö
^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Reshape/shapePack^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/strided_slice`linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
Ė
Xlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/ReshapeReshapeTlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Sum^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ż
llinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/weighted_sum/ReadVariableOpReadVariableOp0linear/linear_model/occupation_indicator/weights*
_output_shapes

:*
dtype0
į
]linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/weighted_sumMatMulXlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/Reshapellinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
¤
Ylinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

Ulinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ExpandDims
ExpandDims+transform/transform/inputs/inputs/race_copyYlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
Ŗ
ilinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 
ć
clinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/NotEqualNotEqualUlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ExpandDimsilinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’
ł
blinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/indicesWhereclinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’
ģ
alinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/valuesGatherNdUlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ExpandDimsblinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’
ū
flinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/dense_shapeShapeUlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	

llinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*h
value_B] BWD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\race
²
glinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
“
llinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*{
shared_nameljhash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\race_5_-2_-1*
value_dtype0	
Š
linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2llinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/hash_tablellinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size
ł
nlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2llinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/hash_tablealinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/valuesglinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
±
flinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Ļ
Xlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/SparseToDenseSparseToDenseblinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/indicesflinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/to_sparse_input/dense_shapenlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/hash_table_Lookup/LookupTableFindV2flinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’

Xlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?

Zlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    

Xlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :
 
[linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
”
\linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    

Rlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hotOneHotXlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/SparseToDenseXlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/depth[linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/on_value\linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
³
`linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
½
Nlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/SumSumRlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/one_hot`linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
Ī
Plinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ShapeShapeNlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Sum*
T0*
_output_shapes
:
Ø
^linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
Ŗ
`linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
Ŗ
`linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
¤
Xlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_sliceStridedSlicePlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Shape^linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_slice/stack`linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_slice/stack_1`linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask

Zlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Ä
Xlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Reshape/shapePackXlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/strided_sliceZlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
¹
Rlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/ReshapeReshapeNlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/SumXlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ń
flinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/weighted_sum/ReadVariableOpReadVariableOp*linear/linear_model/race_indicator/weights*
_output_shapes

:*
dtype0
Ļ
Wlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/weighted_sumMatMulRlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/Reshapeflinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
¬
alinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
µ
]linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ExpandDims
ExpandDims3transform/transform/inputs/inputs/relationship_copyalinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
²
qlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 
ū
klinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/NotEqualNotEqual]linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ExpandDimsqlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’

jlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/indicesWhereklinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’

ilinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/valuesGatherNd]linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ExpandDimsjlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’

nlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/dense_shapeShape]linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	
«
|linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*p
valuegBe B_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\relationship
Ā
wlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Ķ
|linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_nametrhash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\relationship_6_-2_-1*
value_dtype0	

linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2|linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/hash_table|linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size
©
vlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2|linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/hash_tableilinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/valueswlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
¹
nlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
÷
`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/SparseToDenseSparseToDensejlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/indicesnlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/to_sparse_input/dense_shapevlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/hash_table_Lookup/LookupTableFindV2nlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’
„
`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
§
blinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    
¢
`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :
Ø
clinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
©
dlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    
©
Zlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hotOneHot`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/SparseToDense`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/depthclinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/on_valuedlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
»
hlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
Õ
Vlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/SumSumZlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/one_hothlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
Ž
Xlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ShapeShapeVlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Sum*
T0*
_output_shapes
:
°
flinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
²
hlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
²
hlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ģ
`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_sliceStridedSliceXlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Shapeflinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_slice/stackhlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_slice/stack_1hlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
¤
blinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Ü
`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Reshape/shapePack`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/strided_sliceblinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
Ń
Zlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/ReshapeReshapeVlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Sum`linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
į
nlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/weighted_sum/ReadVariableOpReadVariableOp2linear/linear_model/relationship_indicator/weights*
_output_shapes

:*
dtype0
ē
_linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/weighted_sumMatMulZlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/Reshapenlinear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
£
Xlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

Tlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ExpandDims
ExpandDims*transform/transform/inputs/inputs/sex_copyXlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
©
hlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 
ą
blinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/NotEqualNotEqualTlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ExpandDimshlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’
÷
alinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/indicesWhereblinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’
é
`linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/valuesGatherNdTlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ExpandDimsalinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’
ł
elinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/dense_shapeShapeTlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	

jlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*g
value^B\ BVD:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\sex
°
elinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
±
jlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*z
shared_namekihash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\sex_2_-2_-1*
value_dtype0	
Ź
linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2jlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/hash_tablejlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size
ó
mlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2jlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/hash_table`linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/valueselinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
°
elinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Ź
Wlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/SparseToDenseSparseToDensealinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/indiceselinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/to_sparse_input/dense_shapemlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/hash_table_Lookup/LookupTableFindV2elinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’

Wlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?

Ylinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    

Wlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :

Zlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
 
[linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    
ü
Qlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hotOneHotWlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/SparseToDenseWlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/depthZlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/on_value[linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
²
_linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
ŗ
Mlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/SumSumQlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/one_hot_linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
Ģ
Olinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ShapeShapeMlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Sum*
T0*
_output_shapes
:
§
]linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
©
_linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
©
_linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:

Wlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_sliceStridedSliceOlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Shape]linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_slice/stack_linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_slice/stack_1_linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask

Ylinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Į
Wlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Reshape/shapePackWlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/strided_sliceYlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
¶
Qlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/ReshapeReshapeMlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/SumWlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ļ
elinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/weighted_sum/ReadVariableOpReadVariableOp)linear/linear_model/sex_indicator/weights*
_output_shapes

:*
dtype0
Ģ
Vlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/weighted_sumMatMulQlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/Reshapeelinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
©
^linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
¬
Zlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ExpandDims
ExpandDims0transform/transform/inputs/inputs/workclass_copy^linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ExpandDims/dim*
T0*'
_output_shapes
:’’’’’’’’’
Æ
nlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/ignore_value/xConst*
_output_shapes
: *
dtype0*
valueB B 
ņ
hlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/NotEqualNotEqualZlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ExpandDimsnlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/ignore_value/x*
T0*'
_output_shapes
:’’’’’’’’’

glinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/indicesWherehlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/NotEqual*'
_output_shapes
:’’’’’’’’’
ū
flinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/valuesGatherNdZlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ExpandDimsglinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/indices*
Tindices0	*
Tparams0*#
_output_shapes
:’’’’’’’’’

klinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/dense_shapeShapeZlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ExpandDims*
T0*
_output_shapes
:*
out_type0	
¢
vlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/asset_pathConst"/device:CPU:**
_output_shapes
: *
dtype0*m
valuedBb B\D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\workclass
¼
qlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/ConstConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
Ä
vlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_nameqohash_table_D:\Spooky\A-Documents\Code\Differential Privacy\ML\tmprq0mb0qn\transform_fn\assets\workclass_8_-2_-1*
value_dtype0	
ī
linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/table_init/InitializeTableFromTextFileV2InitializeTableFromTextFileV2vlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/hash_tablevlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/asset_path*
	key_indexž’’’’’’’’*
value_index’’’’’’’’’*

vocab_size

slinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/hash_table_Lookup/LookupTableFindV2LookupTableFindV2vlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/hash_tableflinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/valuesqlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/Const*	
Tin0*

Tout0	*#
_output_shapes
:’’’’’’’’’
¶
klinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/SparseToDense/default_valueConst*
_output_shapes
: *
dtype0	*
valueB	 R
’’’’’’’’’
č
]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/SparseToDenseSparseToDenseglinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/indicesklinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/to_sparse_input/dense_shapeslinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/hash_table_Lookup/LookupTableFindV2klinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/SparseToDense/default_value*
T0	*
Tindices0	*'
_output_shapes
:’’’’’’’’’
¢
]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
¤
_linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/Const_1Const*
_output_shapes
: *
dtype0*
valueB
 *    

]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/depthConst*
_output_shapes
: *
dtype0*
value	B :
„
`linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/on_valueConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
¦
alinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/off_valueConst*
_output_shapes
: *
dtype0*
valueB
 *    

Wlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hotOneHot]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/SparseToDense]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/depth`linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/on_valuealinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hot/off_value*
T0*+
_output_shapes
:’’’’’’’’’
ø
elinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Sum/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB:
ž’’’’’’’’
Ģ
Slinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/SumSumWlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/one_hotelinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Sum/reduction_indices*
T0*'
_output_shapes
:’’’’’’’’’
Ų
Ulinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ShapeShapeSlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Sum*
T0*
_output_shapes
:
­
clinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
Æ
elinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
Æ
elinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
½
]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_sliceStridedSliceUlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Shapeclinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice/stackelinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice/stack_1elinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
”
_linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Reshape/shape/1Const*
_output_shapes
: *
dtype0*
value	B :
Ó
]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Reshape/shapePack]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/strided_slice_linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Reshape/shape/1*
N*
T0*
_output_shapes
:
Č
Wlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/ReshapeReshapeSlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Sum]linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Reshape/shape*
T0*'
_output_shapes
:’’’’’’’’’
Ū
klinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/weighted_sum/ReadVariableOpReadVariableOp/linear/linear_model/workclass_indicator/weights*
_output_shapes

:*
dtype0
Ž
\linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/weighted_sumMatMulWlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/Reshapeklinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
Ū	
Plinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum_no_biasAddNLlinear/linear_model/linear/linear_model/linear/linear_model/age/weighted_sumUlinear/linear_model/linear/linear_model/linear/linear_model/capital-gain/weighted_sumUlinear/linear_model/linear/linear_model/linear/linear_model/capital-loss/weighted_sum\linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/weighted_sumWlinear/linear_model/linear/linear_model/linear/linear_model/hours-per-week/weighted_sumalinear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/weighted_sumalinear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/weighted_sum]linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/weighted_sumWlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/weighted_sum_linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/weighted_sumVlinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/weighted_sum\linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/weighted_sum*
N*
T0*'
_output_shapes
:’’’’’’’’’
“
Wlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum/ReadVariableOpReadVariableOp linear/linear_model/bias_weights*
_output_shapes
:*
dtype0
°
Hlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sumBiasAddPlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum_no_biasWlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum/ReadVariableOp*
T0*'
_output_shapes
:’’’’’’’’’
k
ReadVariableOpReadVariableOp linear/linear_model/bias_weights*
_output_shapes
:*
dtype0
]
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
_
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
_
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
¶
strided_sliceStridedSliceReadVariableOpstrided_slice/stackstrided_slice/stack_1strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
N
	bias/tagsConst*
_output_shapes
: *
dtype0*
valueB
 Bbias
P
biasScalarSummary	bias/tagsstrided_slice*
T0*
_output_shapes
: 

,zero_fraction/total_size/Size/ReadVariableOpReadVariableOplinear/linear_model/age/weights*
_output_shapes

:*
dtype0
_
zero_fraction/total_size/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R

.zero_fraction/total_size/Size_1/ReadVariableOpReadVariableOp(linear/linear_model/capital-gain/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_1Const*
_output_shapes
: *
dtype0	*
value	B	 R

.zero_fraction/total_size/Size_2/ReadVariableOpReadVariableOp(linear/linear_model/capital-loss/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_2Const*
_output_shapes
: *
dtype0	*
value	B	 R

.zero_fraction/total_size/Size_3/ReadVariableOpReadVariableOp/linear/linear_model/education_indicator/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_3Const*
_output_shapes
: *
dtype0	*
value	B	 R

.zero_fraction/total_size/Size_4/ReadVariableOpReadVariableOp*linear/linear_model/hours-per-week/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_4Const*
_output_shapes
: *
dtype0	*
value	B	 R
£
.zero_fraction/total_size/Size_5/ReadVariableOpReadVariableOp4linear/linear_model/marital-status_indicator/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_5Const*
_output_shapes
: *
dtype0	*
value	B	 R
£
.zero_fraction/total_size/Size_6/ReadVariableOpReadVariableOp4linear/linear_model/native-country_indicator/weights*
_output_shapes

:$*
dtype0
a
zero_fraction/total_size/Size_6Const*
_output_shapes
: *
dtype0	*
value	B	 R$

.zero_fraction/total_size/Size_7/ReadVariableOpReadVariableOp0linear/linear_model/occupation_indicator/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_7Const*
_output_shapes
: *
dtype0	*
value	B	 R

.zero_fraction/total_size/Size_8/ReadVariableOpReadVariableOp*linear/linear_model/race_indicator/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_8Const*
_output_shapes
: *
dtype0	*
value	B	 R
”
.zero_fraction/total_size/Size_9/ReadVariableOpReadVariableOp2linear/linear_model/relationship_indicator/weights*
_output_shapes

:*
dtype0
a
zero_fraction/total_size/Size_9Const*
_output_shapes
: *
dtype0	*
value	B	 R

/zero_fraction/total_size/Size_10/ReadVariableOpReadVariableOp)linear/linear_model/sex_indicator/weights*
_output_shapes

:*
dtype0
b
 zero_fraction/total_size/Size_10Const*
_output_shapes
: *
dtype0	*
value	B	 R

/zero_fraction/total_size/Size_11/ReadVariableOpReadVariableOp/linear/linear_model/workclass_indicator/weights*
_output_shapes

:*
dtype0
b
 zero_fraction/total_size/Size_11Const*
_output_shapes
: *
dtype0	*
value	B	 R
Ū
zero_fraction/total_size/AddNAddNzero_fraction/total_size/Sizezero_fraction/total_size/Size_1zero_fraction/total_size/Size_2zero_fraction/total_size/Size_3zero_fraction/total_size/Size_4zero_fraction/total_size/Size_5zero_fraction/total_size/Size_6zero_fraction/total_size/Size_7zero_fraction/total_size/Size_8zero_fraction/total_size/Size_9 zero_fraction/total_size/Size_10 zero_fraction/total_size/Size_11*
N*
T0	*
_output_shapes
: 
`
zero_fraction/total_zero/ConstConst*
_output_shapes
: *
dtype0	*
value	B	 R 

zero_fraction/total_zero/EqualEqualzero_fraction/total_size/Sizezero_fraction/total_zero/Const*
T0	*
_output_shapes
: 

#zero_fraction/total_zero/zero_countIfzero_fraction/total_zero/Equallinear/linear_model/age/weightszero_fraction/total_size/Size*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *A
else_branch2R0
.zero_fraction_total_zero_zero_count_false_4465*
output_shapes
: *@
then_branch1R/
-zero_fraction_total_zero_zero_count_true_4464
~
,zero_fraction/total_zero/zero_count/IdentityIdentity#zero_fraction/total_zero/zero_count*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_1Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_1Equalzero_fraction/total_size/Size_1 zero_fraction/total_zero/Const_1*
T0	*
_output_shapes
: 

%zero_fraction/total_zero/zero_count_1If zero_fraction/total_zero/Equal_1(linear/linear_model/capital-gain/weightszero_fraction/total_size/Size_1*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_1_false_4508*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_1_true_4507

.zero_fraction/total_zero/zero_count_1/IdentityIdentity%zero_fraction/total_zero/zero_count_1*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_2Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_2Equalzero_fraction/total_size/Size_2 zero_fraction/total_zero/Const_2*
T0	*
_output_shapes
: 

%zero_fraction/total_zero/zero_count_2If zero_fraction/total_zero/Equal_2(linear/linear_model/capital-loss/weightszero_fraction/total_size/Size_2*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_2_false_4551*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_2_true_4550

.zero_fraction/total_zero/zero_count_2/IdentityIdentity%zero_fraction/total_zero/zero_count_2*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_3Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_3Equalzero_fraction/total_size/Size_3 zero_fraction/total_zero/Const_3*
T0	*
_output_shapes
: 
£
%zero_fraction/total_zero/zero_count_3If zero_fraction/total_zero/Equal_3/linear/linear_model/education_indicator/weightszero_fraction/total_size/Size_3*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_3_false_4594*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_3_true_4593

.zero_fraction/total_zero/zero_count_3/IdentityIdentity%zero_fraction/total_zero/zero_count_3*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_4Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_4Equalzero_fraction/total_size/Size_4 zero_fraction/total_zero/Const_4*
T0	*
_output_shapes
: 

%zero_fraction/total_zero/zero_count_4If zero_fraction/total_zero/Equal_4*linear/linear_model/hours-per-week/weightszero_fraction/total_size/Size_4*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_4_false_4637*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_4_true_4636

.zero_fraction/total_zero/zero_count_4/IdentityIdentity%zero_fraction/total_zero/zero_count_4*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_5Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_5Equalzero_fraction/total_size/Size_5 zero_fraction/total_zero/Const_5*
T0	*
_output_shapes
: 
Ø
%zero_fraction/total_zero/zero_count_5If zero_fraction/total_zero/Equal_54linear/linear_model/marital-status_indicator/weightszero_fraction/total_size/Size_5*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_5_false_4680*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_5_true_4679

.zero_fraction/total_zero/zero_count_5/IdentityIdentity%zero_fraction/total_zero/zero_count_5*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_6Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_6Equalzero_fraction/total_size/Size_6 zero_fraction/total_zero/Const_6*
T0	*
_output_shapes
: 
Ø
%zero_fraction/total_zero/zero_count_6If zero_fraction/total_zero/Equal_64linear/linear_model/native-country_indicator/weightszero_fraction/total_size/Size_6*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_6_false_4723*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_6_true_4722

.zero_fraction/total_zero/zero_count_6/IdentityIdentity%zero_fraction/total_zero/zero_count_6*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_7Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_7Equalzero_fraction/total_size/Size_7 zero_fraction/total_zero/Const_7*
T0	*
_output_shapes
: 
¤
%zero_fraction/total_zero/zero_count_7If zero_fraction/total_zero/Equal_70linear/linear_model/occupation_indicator/weightszero_fraction/total_size/Size_7*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_7_false_4766*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_7_true_4765

.zero_fraction/total_zero/zero_count_7/IdentityIdentity%zero_fraction/total_zero/zero_count_7*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_8Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_8Equalzero_fraction/total_size/Size_8 zero_fraction/total_zero/Const_8*
T0	*
_output_shapes
: 

%zero_fraction/total_zero/zero_count_8If zero_fraction/total_zero/Equal_8*linear/linear_model/race_indicator/weightszero_fraction/total_size/Size_8*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_8_false_4809*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_8_true_4808

.zero_fraction/total_zero/zero_count_8/IdentityIdentity%zero_fraction/total_zero/zero_count_8*
T0*
_output_shapes
: 
b
 zero_fraction/total_zero/Const_9Const*
_output_shapes
: *
dtype0	*
value	B	 R 

 zero_fraction/total_zero/Equal_9Equalzero_fraction/total_size/Size_9 zero_fraction/total_zero/Const_9*
T0	*
_output_shapes
: 
¦
%zero_fraction/total_zero/zero_count_9If zero_fraction/total_zero/Equal_92linear/linear_model/relationship_indicator/weightszero_fraction/total_size/Size_9*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *C
else_branch4R2
0zero_fraction_total_zero_zero_count_9_false_4852*
output_shapes
: *B
then_branch3R1
/zero_fraction_total_zero_zero_count_9_true_4851

.zero_fraction/total_zero/zero_count_9/IdentityIdentity%zero_fraction/total_zero/zero_count_9*
T0*
_output_shapes
: 
c
!zero_fraction/total_zero/Const_10Const*
_output_shapes
: *
dtype0	*
value	B	 R 

!zero_fraction/total_zero/Equal_10Equal zero_fraction/total_size/Size_10!zero_fraction/total_zero/Const_10*
T0	*
_output_shapes
: 
¢
&zero_fraction/total_zero/zero_count_10If!zero_fraction/total_zero/Equal_10)linear/linear_model/sex_indicator/weights zero_fraction/total_size/Size_10*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *D
else_branch5R3
1zero_fraction_total_zero_zero_count_10_false_4895*
output_shapes
: *C
then_branch4R2
0zero_fraction_total_zero_zero_count_10_true_4894

/zero_fraction/total_zero/zero_count_10/IdentityIdentity&zero_fraction/total_zero/zero_count_10*
T0*
_output_shapes
: 
c
!zero_fraction/total_zero/Const_11Const*
_output_shapes
: *
dtype0	*
value	B	 R 

!zero_fraction/total_zero/Equal_11Equal zero_fraction/total_size/Size_11!zero_fraction/total_zero/Const_11*
T0	*
_output_shapes
: 
Ø
&zero_fraction/total_zero/zero_count_11If!zero_fraction/total_zero/Equal_11/linear/linear_model/workclass_indicator/weights zero_fraction/total_size/Size_11*
Tcond0
*
Tin
2	*
Tout
2*
_lower_using_switch_merge(*
_output_shapes
: *D
else_branch5R3
1zero_fraction_total_zero_zero_count_11_false_4938*
output_shapes
: *C
then_branch4R2
0zero_fraction_total_zero_zero_count_11_true_4937

/zero_fraction/total_zero/zero_count_11/IdentityIdentity&zero_fraction/total_zero/zero_count_11*
T0*
_output_shapes
: 

zero_fraction/total_zero/AddNAddN,zero_fraction/total_zero/zero_count/Identity.zero_fraction/total_zero/zero_count_1/Identity.zero_fraction/total_zero/zero_count_2/Identity.zero_fraction/total_zero/zero_count_3/Identity.zero_fraction/total_zero/zero_count_4/Identity.zero_fraction/total_zero/zero_count_5/Identity.zero_fraction/total_zero/zero_count_6/Identity.zero_fraction/total_zero/zero_count_7/Identity.zero_fraction/total_zero/zero_count_8/Identity.zero_fraction/total_zero/zero_count_9/Identity/zero_fraction/total_zero/zero_count_10/Identity/zero_fraction/total_zero/zero_count_11/Identity*
N*
T0*
_output_shapes
: 
y
"zero_fraction/compute/float32_sizeCastzero_fraction/total_size/AddN*

DstT0*

SrcT0	*
_output_shapes
: 

zero_fraction/compute/truedivRealDivzero_fraction/total_zero/AddN"zero_fraction/compute/float32_size*
T0*
_output_shapes
: 
n
"zero_fraction/zero_fraction_or_nanIdentityzero_fraction/compute/truediv*
T0*
_output_shapes
: 
v
fraction_of_zero_weights/tagsConst*
_output_shapes
: *
dtype0*)
value B Bfraction_of_zero_weights

fraction_of_zero_weightsScalarSummaryfraction_of_zero_weights/tags"zero_fraction/zero_fraction_or_nan*
T0*
_output_shapes
: 

head/logits/ShapeShapeHlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum*
T0*
_output_shapes
:
g
%head/logits/assert_rank_at_least/rankConst*
_output_shapes
: *
dtype0*
value	B :
W
Ohead/logits/assert_rank_at_least/assert_type/statically_determined_correct_typeNoOp
H
@head/logits/assert_rank_at_least/static_checks_determined_all_okNoOp
 
head/predictions/logisticSigmoidHlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum*
T0*'
_output_shapes
:’’’’’’’’’
¤
head/predictions/zeros_like	ZerosLikeHlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum*
T0*'
_output_shapes
:’’’’’’’’’
q
&head/predictions/two_class_logits/axisConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’
÷
!head/predictions/two_class_logitsConcatV2head/predictions/zeros_likeHlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum&head/predictions/two_class_logits/axis*
N*
T0*'
_output_shapes
:’’’’’’’’’
~
head/predictions/probabilitiesSoftmax!head/predictions/two_class_logits*
T0*'
_output_shapes
:’’’’’’’’’
o
$head/predictions/class_ids/dimensionConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

head/predictions/class_idsArgMax!head/predictions/two_class_logits$head/predictions/class_ids/dimension*
T0*#
_output_shapes
:’’’’’’’’’
j
head/predictions/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
valueB :
’’’’’’’’’

head/predictions/ExpandDims
ExpandDimshead/predictions/class_idshead/predictions/ExpandDims/dim*
T0	*'
_output_shapes
:’’’’’’’’’
w
head/predictions/str_classesAsStringhead/predictions/ExpandDims*
T0	*'
_output_shapes
:’’’’’’’’’

head/predictions/ShapeShapeHlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum*
T0*
_output_shapes
:
n
$head/predictions/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
p
&head/predictions/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
p
&head/predictions/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:

head/predictions/strided_sliceStridedSlicehead/predictions/Shape$head/predictions/strided_slice/stack&head/predictions/strided_slice/stack_1&head/predictions/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
^
head/predictions/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
^
head/predictions/range/limitConst*
_output_shapes
: *
dtype0*
value	B :
^
head/predictions/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :

head/predictions/rangeRangehead/predictions/range/starthead/predictions/range/limithead/predictions/range/delta*
_output_shapes
:
c
!head/predictions/ExpandDims_1/dimConst*
_output_shapes
: *
dtype0*
value	B : 

head/predictions/ExpandDims_1
ExpandDimshead/predictions/range!head/predictions/ExpandDims_1/dim*
T0*
_output_shapes

:
c
!head/predictions/Tile/multiples/1Const*
_output_shapes
: *
dtype0*
value	B :

head/predictions/Tile/multiplesPackhead/predictions/strided_slice!head/predictions/Tile/multiples/1*
N*
T0*
_output_shapes
:

head/predictions/TileTilehead/predictions/ExpandDims_1head/predictions/Tile/multiples*
T0*'
_output_shapes
:’’’’’’’’’

head/predictions/Shape_1ShapeHlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum*
T0*
_output_shapes
:
p
&head/predictions/strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB: 
r
(head/predictions/strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
r
(head/predictions/strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB:

 head/predictions/strided_slice_1StridedSlicehead/predictions/Shape_1&head/predictions/strided_slice_1/stack(head/predictions/strided_slice_1/stack_1(head/predictions/strided_slice_1/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
`
head/predictions/range_1/startConst*
_output_shapes
: *
dtype0*
value	B : 
`
head/predictions/range_1/limitConst*
_output_shapes
: *
dtype0*
value	B :
`
head/predictions/range_1/deltaConst*
_output_shapes
: *
dtype0*
value	B :

head/predictions/range_1Rangehead/predictions/range_1/starthead/predictions/range_1/limithead/predictions/range_1/delta*
_output_shapes
:
d
head/predictions/AsStringAsStringhead/predictions/range_1*
T0*
_output_shapes
:
c
!head/predictions/ExpandDims_2/dimConst*
_output_shapes
: *
dtype0*
value	B : 

head/predictions/ExpandDims_2
ExpandDimshead/predictions/AsString!head/predictions/ExpandDims_2/dim*
T0*
_output_shapes

:
e
#head/predictions/Tile_1/multiples/1Const*
_output_shapes
: *
dtype0*
value	B :

!head/predictions/Tile_1/multiplesPack head/predictions/strided_slice_1#head/predictions/Tile_1/multiples/1*
N*
T0*
_output_shapes
:

head/predictions/Tile_1Tilehead/predictions/ExpandDims_2!head/predictions/Tile_1/multiples*
T0*'
_output_shapes
:’’’’’’’’’
X

head/ShapeShapehead/predictions/probabilities*
T0*
_output_shapes
:
b
head/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB: 
d
head/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB:
d
head/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ę
head/strided_sliceStridedSlice
head/Shapehead/strided_slice/stackhead/strided_slice/stack_1head/strided_slice/stack_2*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask
R
head/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
R
head/range/limitConst*
_output_shapes
: *
dtype0*
value	B :
R
head/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
e

head/rangeRangehead/range/starthead/range/limithead/range/delta*
_output_shapes
:
J
head/AsStringAsString
head/range*
T0*
_output_shapes
:
U
head/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
j
head/ExpandDims
ExpandDimshead/AsStringhead/ExpandDims/dim*
T0*
_output_shapes

:
W
head/Tile/multiples/1Const*
_output_shapes
: *
dtype0*
value	B :
t
head/Tile/multiplesPackhead/strided_slicehead/Tile/multiples/1*
N*
T0*
_output_shapes
:
i
	head/TileTilehead/ExpandDimshead/Tile/multiples*
T0*'
_output_shapes
:’’’’’’’’’

initNoOp


init_all_tablesNoOp^linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/table_init/InitializeTableFromTextFileV2^linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/table_init/InitializeTableFromTextFileV27^transform/transform/key_value_init/LookupTableImportV2

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
Y
save/filename/inputConst*
_output_shapes
: *
dtype0*
valueB Bmodel
n
save/filenamePlaceholderWithDefaultsave/filename/input*
_output_shapes
: *
dtype0*
shape: 
e

save/ConstPlaceholderWithDefaultsave/filename*
_output_shapes
: *
dtype0*
shape: 

save/StringJoin/inputs_1Const*
_output_shapes
: *
dtype0*<
value3B1 B+_temp_3a138387817747ba825680e7d4e27c3b/part
d
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: 
Q
save/num_shardsConst*
_output_shapes
: *
dtype0*
value	B :
k
save/ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 

save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
Ģ
save/SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*š
valueęBćBglobal_stepBlinear/linear_model/age/weightsB linear/linear_model/bias_weightsB(linear/linear_model/capital-gain/weightsB(linear/linear_model/capital-loss/weightsB/linear/linear_model/education_indicator/weightsB*linear/linear_model/hours-per-week/weightsB4linear/linear_model/marital-status_indicator/weightsB4linear/linear_model/native-country_indicator/weightsB0linear/linear_model/occupation_indicator/weightsB*linear/linear_model/race_indicator/weightsB2linear/linear_model/relationship_indicator/weightsB)linear/linear_model/sex_indicator/weightsB/linear/linear_model/workclass_indicator/weights

save/SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*/
value&B$B B B B B B B B B B B B B B 

save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesglobal_step/Read/ReadVariableOp3linear/linear_model/age/weights/Read/ReadVariableOp4linear/linear_model/bias_weights/Read/ReadVariableOp<linear/linear_model/capital-gain/weights/Read/ReadVariableOp<linear/linear_model/capital-loss/weights/Read/ReadVariableOpClinear/linear_model/education_indicator/weights/Read/ReadVariableOp>linear/linear_model/hours-per-week/weights/Read/ReadVariableOpHlinear/linear_model/marital-status_indicator/weights/Read/ReadVariableOpHlinear/linear_model/native-country_indicator/weights/Read/ReadVariableOpDlinear/linear_model/occupation_indicator/weights/Read/ReadVariableOp>linear/linear_model/race_indicator/weights/Read/ReadVariableOpFlinear/linear_model/relationship_indicator/weights/Read/ReadVariableOp=linear/linear_model/sex_indicator/weights/Read/ReadVariableOpClinear/linear_model/workclass_indicator/weights/Read/ReadVariableOp"/device:CPU:0*
dtypes
2	
 
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
 
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
N*
T0*
_output_shapes
:
u
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0

save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
T0*
_output_shapes
: 
Ļ
save/RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*š
valueęBćBglobal_stepBlinear/linear_model/age/weightsB linear/linear_model/bias_weightsB(linear/linear_model/capital-gain/weightsB(linear/linear_model/capital-loss/weightsB/linear/linear_model/education_indicator/weightsB*linear/linear_model/hours-per-week/weightsB4linear/linear_model/marital-status_indicator/weightsB4linear/linear_model/native-country_indicator/weightsB0linear/linear_model/occupation_indicator/weightsB*linear/linear_model/race_indicator/weightsB2linear/linear_model/relationship_indicator/weightsB)linear/linear_model/sex_indicator/weightsB/linear/linear_model/workclass_indicator/weights

save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*/
value&B$B B B B B B B B B B B B B B 
ą
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*L
_output_shapes:
8::::::::::::::*
dtypes
2	
N
save/Identity_1Identitysave/RestoreV2*
T0	*
_output_shapes
:
T
save/AssignVariableOpAssignVariableOpglobal_stepsave/Identity_1*
dtype0	
P
save/Identity_2Identitysave/RestoreV2:1*
T0*
_output_shapes
:
j
save/AssignVariableOp_1AssignVariableOplinear/linear_model/age/weightssave/Identity_2*
dtype0
P
save/Identity_3Identitysave/RestoreV2:2*
T0*
_output_shapes
:
k
save/AssignVariableOp_2AssignVariableOp linear/linear_model/bias_weightssave/Identity_3*
dtype0
P
save/Identity_4Identitysave/RestoreV2:3*
T0*
_output_shapes
:
s
save/AssignVariableOp_3AssignVariableOp(linear/linear_model/capital-gain/weightssave/Identity_4*
dtype0
P
save/Identity_5Identitysave/RestoreV2:4*
T0*
_output_shapes
:
s
save/AssignVariableOp_4AssignVariableOp(linear/linear_model/capital-loss/weightssave/Identity_5*
dtype0
P
save/Identity_6Identitysave/RestoreV2:5*
T0*
_output_shapes
:
z
save/AssignVariableOp_5AssignVariableOp/linear/linear_model/education_indicator/weightssave/Identity_6*
dtype0
P
save/Identity_7Identitysave/RestoreV2:6*
T0*
_output_shapes
:
u
save/AssignVariableOp_6AssignVariableOp*linear/linear_model/hours-per-week/weightssave/Identity_7*
dtype0
P
save/Identity_8Identitysave/RestoreV2:7*
T0*
_output_shapes
:

save/AssignVariableOp_7AssignVariableOp4linear/linear_model/marital-status_indicator/weightssave/Identity_8*
dtype0
P
save/Identity_9Identitysave/RestoreV2:8*
T0*
_output_shapes
:

save/AssignVariableOp_8AssignVariableOp4linear/linear_model/native-country_indicator/weightssave/Identity_9*
dtype0
Q
save/Identity_10Identitysave/RestoreV2:9*
T0*
_output_shapes
:
|
save/AssignVariableOp_9AssignVariableOp0linear/linear_model/occupation_indicator/weightssave/Identity_10*
dtype0
R
save/Identity_11Identitysave/RestoreV2:10*
T0*
_output_shapes
:
w
save/AssignVariableOp_10AssignVariableOp*linear/linear_model/race_indicator/weightssave/Identity_11*
dtype0
R
save/Identity_12Identitysave/RestoreV2:11*
T0*
_output_shapes
:

save/AssignVariableOp_11AssignVariableOp2linear/linear_model/relationship_indicator/weightssave/Identity_12*
dtype0
R
save/Identity_13Identitysave/RestoreV2:12*
T0*
_output_shapes
:
v
save/AssignVariableOp_12AssignVariableOp)linear/linear_model/sex_indicator/weightssave/Identity_13*
dtype0
R
save/Identity_14Identitysave/RestoreV2:13*
T0*
_output_shapes
:
|
save/AssignVariableOp_13AssignVariableOp/linear/linear_model/workclass_indicator/weightssave/Identity_14*
dtype0

save/restore_shardNoOp^save/AssignVariableOp^save/AssignVariableOp_1^save/AssignVariableOp_10^save/AssignVariableOp_11^save/AssignVariableOp_12^save/AssignVariableOp_13^save/AssignVariableOp_2^save/AssignVariableOp_3^save/AssignVariableOp_4^save/AssignVariableOp_5^save/AssignVariableOp_6^save/AssignVariableOp_7^save/AssignVariableOp_8^save/AssignVariableOp_9
-
save/restore_allNoOp^save/restore_shardŖ
ė
`
/zero_fraction_total_zero_zero_count_9_true_4851
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ŗ
y
zero_fraction_cond_false_48627
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
ä
æ
0zero_fraction_total_zero_zero_count_6_false_4723U
Qzero_fraction_readvariableop_linear_linear_model_native_country_indicator_weights(
$cast_zero_fraction_total_size_size_6	
mulĪ
zero_fraction/ReadVariableOpReadVariableOpQzero_fraction_readvariableop_linear_linear_model_native_country_indicator_weights*
_output_shapes

:$*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R$2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4733*
output_shapes
: */
then_branch R
zero_fraction_cond_true_47322
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_6*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_46467
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
é
^
-zero_fraction_total_zero_zero_count_true_4464
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
ė
`
/zero_fraction_total_zero_zero_count_8_true_4808
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ŗ
y
zero_fraction_cond_false_46477
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
ė
`
/zero_fraction_total_zero_zero_count_6_true_4722
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_48187
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
ė
`
/zero_fraction_total_zero_zero_count_5_true_4679
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ŗ
y
zero_fraction_cond_false_48197
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
ģ
a
0zero_fraction_total_zero_zero_count_11_true_4937
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_46897
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
ä
æ
0zero_fraction_total_zero_zero_count_5_false_4680U
Qzero_fraction_readvariableop_linear_linear_model_marital_status_indicator_weights(
$cast_zero_fraction_total_size_size_5	
mulĪ
zero_fraction/ReadVariableOpReadVariableOpQzero_fraction_readvariableop_linear_linear_model_marital_status_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4690*
output_shapes
: */
then_branch R
zero_fraction_cond_true_46892
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_5*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_44747
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_44757
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_46047
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_46907
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_45617
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
Ė
a
zero_fraction_cond_true_45177
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
Ė
a
zero_fraction_cond_true_48617
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
Ė
a
zero_fraction_cond_true_47757
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_47767
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_45187
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
ģ
a
0zero_fraction_total_zero_zero_count_10_true_4894
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ŗ
y
zero_fraction_cond_false_49487
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
ą
½
0zero_fraction_total_zero_zero_count_9_false_4852S
Ozero_fraction_readvariableop_linear_linear_model_relationship_indicator_weights(
$cast_zero_fraction_total_size_size_9	
mulĢ
zero_fraction/ReadVariableOpReadVariableOpOzero_fraction_readvariableop_linear_linear_model_relationship_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4862*
output_shapes
: */
then_branch R
zero_fraction_cond_true_48612
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_9*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ż
¼
1zero_fraction_total_zero_zero_count_11_false_4938P
Lzero_fraction_readvariableop_linear_linear_model_workclass_indicator_weights)
%cast_zero_fraction_total_size_size_11	
mulÉ
zero_fraction/ReadVariableOpReadVariableOpLzero_fraction_readvariableop_linear_linear_model_workclass_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4948*
output_shapes
: */
then_branch R
zero_fraction_cond_true_49472
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionk
CastCast%cast_zero_fraction_total_size_size_11*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
ė
`
/zero_fraction_total_zero_zero_count_4_true_4636
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
ė
`
/zero_fraction_total_zero_zero_count_1_true_4507
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
ė
`
/zero_fraction_total_zero_zero_count_3_true_4593
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ģ
³
0zero_fraction_total_zero_zero_count_2_false_4551I
Ezero_fraction_readvariableop_linear_linear_model_capital_loss_weights(
$cast_zero_fraction_total_size_size_2	
mulĀ
zero_fraction/ReadVariableOpReadVariableOpEzero_fraction_readvariableop_linear_linear_model_capital_loss_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4561*
output_shapes
: */
then_branch R
zero_fraction_cond_true_45602
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_2*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
ė
`
/zero_fraction_total_zero_zero_count_2_true_4550
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ń
¶
1zero_fraction_total_zero_zero_count_10_false_4895J
Fzero_fraction_readvariableop_linear_linear_model_sex_indicator_weights)
%cast_zero_fraction_total_size_size_10	
mulĆ
zero_fraction/ReadVariableOpReadVariableOpFzero_fraction_readvariableop_linear_linear_model_sex_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4905*
output_shapes
: */
then_branch R
zero_fraction_cond_true_49042
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionk
CastCast%cast_zero_fraction_total_size_size_10*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_47327
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:$2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:$2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:$
Š
µ
0zero_fraction_total_zero_zero_count_4_false_4637K
Gzero_fraction_readvariableop_linear_linear_model_hours_per_week_weights(
$cast_zero_fraction_total_size_size_4	
mulÄ
zero_fraction/ReadVariableOpReadVariableOpGzero_fraction_readvariableop_linear_linear_model_hours_per_week_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4647*
output_shapes
: */
then_branch R
zero_fraction_cond_true_46462
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_4*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ü
»
0zero_fraction_total_zero_zero_count_7_false_4766Q
Mzero_fraction_readvariableop_linear_linear_model_occupation_indicator_weights(
$cast_zero_fraction_total_size_size_7	
mulŹ
zero_fraction/ReadVariableOpReadVariableOpMzero_fraction_readvariableop_linear_linear_model_occupation_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4776*
output_shapes
: */
then_branch R
zero_fraction_cond_true_47752
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_7*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ś
ŗ
0zero_fraction_total_zero_zero_count_3_false_4594P
Lzero_fraction_readvariableop_linear_linear_model_education_indicator_weights(
$cast_zero_fraction_total_size_size_3	
mulÉ
zero_fraction/ReadVariableOpReadVariableOpLzero_fraction_readvariableop_linear_linear_model_education_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4604*
output_shapes
: */
then_branch R
zero_fraction_cond_true_46032
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_3*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ŗ
y
zero_fraction_cond_false_47337
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:$2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:$2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:$
“
¦
.zero_fraction_total_zero_zero_count_false_4465@
<zero_fraction_readvariableop_linear_linear_model_age_weights&
"cast_zero_fraction_total_size_size	
mul¹
zero_fraction/ReadVariableOpReadVariableOp<zero_fraction_readvariableop_linear_linear_model_age_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4475*
output_shapes
: */
then_branch R
zero_fraction_cond_true_44742
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionh
CastCast"cast_zero_fraction_total_size_size*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Š
µ
0zero_fraction_total_zero_zero_count_8_false_4809K
Gzero_fraction_readvariableop_linear_linear_model_race_indicator_weights(
$cast_zero_fraction_total_size_size_8	
mulÄ
zero_fraction/ReadVariableOpReadVariableOpGzero_fraction_readvariableop_linear_linear_model_race_indicator_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4819*
output_shapes
: */
then_branch R
zero_fraction_cond_true_48182
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_8*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_49477
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
Ŗ
y
zero_fraction_cond_false_49057
3count_nonzero_notequal_zero_fraction_readvariableop
count_nonzero_nonzero_count	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0	*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0	*
_output_shapes
: 2
count_nonzero/nonzero_count"C
count_nonzero_nonzero_count$count_nonzero/nonzero_count:output:0*
_input_shapes

:
Ė
a
zero_fraction_cond_true_46037
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
ė
`
/zero_fraction_total_zero_zero_count_7_true_4765
placeholder
placeholder_1		
constS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *    2
Const"
constConst:output:0*
_input_shapes
:: 
Ģ
³
0zero_fraction_total_zero_zero_count_1_false_4508I
Ezero_fraction_readvariableop_linear_linear_model_capital_gain_weights(
$cast_zero_fraction_total_size_size_1	
mulĀ
zero_fraction/ReadVariableOpReadVariableOpEzero_fraction_readvariableop_linear_linear_model_capital_gain_weights*
_output_shapes

:*
dtype02
zero_fraction/ReadVariableOpj
zero_fraction/SizeConst*
_output_shapes
: *
dtype0	*
value	B	 R2
zero_fraction/Size|
zero_fraction/LessEqual/yConst*
_output_shapes
: *
dtype0	*
valueB	 R’’’’2
zero_fraction/LessEqual/y”
zero_fraction/LessEqual	LessEqualzero_fraction/Size:output:0"zero_fraction/LessEqual/y:output:0*
T0	*
_output_shapes
: 2
zero_fraction/LessEqual×
zero_fraction/condStatelessIfzero_fraction/LessEqual:z:0$zero_fraction/ReadVariableOp:value:0*
Tcond0
*
Tin
2*
Tout
2	*
_lower_using_switch_merge(*
_output_shapes
: *0
else_branch!R
zero_fraction_cond_false_4518*
output_shapes
: */
then_branch R
zero_fraction_cond_true_45172
zero_fraction/cond
zero_fraction/cond/IdentityIdentityzero_fraction/cond:output:0*
T0	*
_output_shapes
: 2
zero_fraction/cond/Identity·
$zero_fraction/counts_to_fraction/subSubzero_fraction/Size:output:0$zero_fraction/cond/Identity:output:0*
T0	*
_output_shapes
: 2&
$zero_fraction/counts_to_fraction/sub°
%zero_fraction/counts_to_fraction/CastCast(zero_fraction/counts_to_fraction/sub:z:0*

DstT0*

SrcT0	*
_output_shapes
: 2'
%zero_fraction/counts_to_fraction/Cast§
'zero_fraction/counts_to_fraction/Cast_1Castzero_fraction/Size:output:0*

DstT0*

SrcT0	*
_output_shapes
: 2)
'zero_fraction/counts_to_fraction/Cast_1Ų
(zero_fraction/counts_to_fraction/truedivRealDiv)zero_fraction/counts_to_fraction/Cast:y:0+zero_fraction/counts_to_fraction/Cast_1:y:0*
T0*
_output_shapes
: 2*
(zero_fraction/counts_to_fraction/truediv
zero_fraction/fractionIdentity,zero_fraction/counts_to_fraction/truediv:z:0*
T0*
_output_shapes
: 2
zero_fraction/fractionj
CastCast$cast_zero_fraction_total_size_size_1*

DstT0*

SrcT0	*
_output_shapes
: 2
CastG
mul_0Mulzero_fraction/fraction:output:0Cast:y:0*
T02
mul"
mul	mul_0:z:0*
_input_shapes
:: 
Ė
a
zero_fraction_cond_true_49047
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:
Ė
a
zero_fraction_cond_true_45607
3count_nonzero_notequal_zero_fraction_readvariableop
cast	o
count_nonzero/zerosConst*
_output_shapes
: *
dtype0*
valueB
 *    2
count_nonzero/zerosø
count_nonzero/NotEqualNotEqual3count_nonzero_notequal_zero_fraction_readvariableopcount_nonzero/zeros:output:0*
T0*
_output_shapes

:2
count_nonzero/NotEqual
count_nonzero/CastCastcount_nonzero/NotEqual:z:0*

DstT0*

SrcT0
*
_output_shapes

:2
count_nonzero/Cast{
count_nonzero/ConstConst*
_output_shapes
:*
dtype0*
valueB"       2
count_nonzero/Const
count_nonzero/nonzero_countSumcount_nonzero/Cast:y:0count_nonzero/Const:output:0*
T0*
_output_shapes
: 2
count_nonzero/nonzero_countj
CastCast$count_nonzero/nonzero_count:output:0*

DstT0	*

SrcT0*
_output_shapes
: 2
Cast"
castCast:y:0*
_input_shapes

:"Æ<
save/Const:0save/Identity:0save/restore_all (5 @F8"Å
asset_filepaths±
®
Const:0
	Const_1:0
	Const_2:0
	Const_3:0
	Const_4:0
	Const_5:0
	Const_6:0
	Const_7:0
xlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/asset_path:0
linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/asset_path:0
linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/asset_path:0
zlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/asset_path:0
nlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/asset_path:0
~linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/asset_path:0
llinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/asset_path:0
xlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/asset_path:0"~
global_stepom
k
global_step:0global_step/Assign!global_step/Read/ReadVariableOp:0(2global_step/Initializer/zeros:0H"æ
saved_model_assetsØ*„
E
+type.googleapis.com/tensorflow.AssetFileDef
	
Const:0	workclass
G
+type.googleapis.com/tensorflow.AssetFileDef

	Const_1:0	education
L
+type.googleapis.com/tensorflow.AssetFileDef

	Const_2:0marital-status
H
+type.googleapis.com/tensorflow.AssetFileDef

	Const_3:0
occupation
J
+type.googleapis.com/tensorflow.AssetFileDef

	Const_4:0relationship
B
+type.googleapis.com/tensorflow.AssetFileDef

	Const_5:0race
A
+type.googleapis.com/tensorflow.AssetFileDef

	Const_6:0sex
L
+type.googleapis.com/tensorflow.AssetFileDef

	Const_7:0native-country
·
+type.googleapis.com/tensorflow.AssetFileDef
z
xlinear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/asset_path:0	education
Č
+type.googleapis.com/tensorflow.AssetFileDef

linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/asset_path:0marital-status
Č
+type.googleapis.com/tensorflow.AssetFileDef

linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/asset_path:0native-country
ŗ
+type.googleapis.com/tensorflow.AssetFileDef
|
zlinear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/asset_path:0
occupation
§
+type.googleapis.com/tensorflow.AssetFileDefx
p
nlinear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/asset_path:0race
Į
+type.googleapis.com/tensorflow.AssetFileDef

~linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/asset_path:0relationship
¤
+type.googleapis.com/tensorflow.AssetFileDefu
n
llinear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/asset_path:0sex
·
+type.googleapis.com/tensorflow.AssetFileDef
z
xlinear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/asset_path:0	workclass"%
saved_model_main_op


group_deps"3
	summaries&
$
bias:0
fraction_of_zero_weights:0"

table_initializerł	
ö	
6transform/transform/key_value_init/LookupTableImportV2
linear/linear_model/linear/linear_model/linear/linear_model/education_indicator/education_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/marital-status_indicator/marital-status_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/native-country_indicator/native-country_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/occupation_indicator/occupation_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/race_indicator/race_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/relationship_indicator/relationship_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/sex_indicator/sex_lookup/hash_table/table_init/InitializeTableFromTextFileV2
linear/linear_model/linear/linear_model/linear/linear_model/workclass_indicator/workclass_lookup/hash_table/table_init/InitializeTableFromTextFileV2"Å
trainable_variables­Ŗ
»
!linear/linear_model/age/weights:0&linear/linear_model/age/weights/Assign5linear/linear_model/age/weights/Read/ReadVariableOp:0(23linear/linear_model/age/weights/Initializer/zeros:08
ß
*linear/linear_model/capital-gain/weights:0/linear/linear_model/capital-gain/weights/Assign>linear/linear_model/capital-gain/weights/Read/ReadVariableOp:0(2<linear/linear_model/capital-gain/weights/Initializer/zeros:08
ß
*linear/linear_model/capital-loss/weights:0/linear/linear_model/capital-loss/weights/Assign>linear/linear_model/capital-loss/weights/Read/ReadVariableOp:0(2<linear/linear_model/capital-loss/weights/Initializer/zeros:08
ū
1linear/linear_model/education_indicator/weights:06linear/linear_model/education_indicator/weights/AssignElinear/linear_model/education_indicator/weights/Read/ReadVariableOp:0(2Clinear/linear_model/education_indicator/weights/Initializer/zeros:08
ē
,linear/linear_model/hours-per-week/weights:01linear/linear_model/hours-per-week/weights/Assign@linear/linear_model/hours-per-week/weights/Read/ReadVariableOp:0(2>linear/linear_model/hours-per-week/weights/Initializer/zeros:08

6linear/linear_model/marital-status_indicator/weights:0;linear/linear_model/marital-status_indicator/weights/AssignJlinear/linear_model/marital-status_indicator/weights/Read/ReadVariableOp:0(2Hlinear/linear_model/marital-status_indicator/weights/Initializer/zeros:08

6linear/linear_model/native-country_indicator/weights:0;linear/linear_model/native-country_indicator/weights/AssignJlinear/linear_model/native-country_indicator/weights/Read/ReadVariableOp:0(2Hlinear/linear_model/native-country_indicator/weights/Initializer/zeros:08
’
2linear/linear_model/occupation_indicator/weights:07linear/linear_model/occupation_indicator/weights/AssignFlinear/linear_model/occupation_indicator/weights/Read/ReadVariableOp:0(2Dlinear/linear_model/occupation_indicator/weights/Initializer/zeros:08
ē
,linear/linear_model/race_indicator/weights:01linear/linear_model/race_indicator/weights/Assign@linear/linear_model/race_indicator/weights/Read/ReadVariableOp:0(2>linear/linear_model/race_indicator/weights/Initializer/zeros:08

4linear/linear_model/relationship_indicator/weights:09linear/linear_model/relationship_indicator/weights/AssignHlinear/linear_model/relationship_indicator/weights/Read/ReadVariableOp:0(2Flinear/linear_model/relationship_indicator/weights/Initializer/zeros:08
ć
+linear/linear_model/sex_indicator/weights:00linear/linear_model/sex_indicator/weights/Assign?linear/linear_model/sex_indicator/weights/Read/ReadVariableOp:0(2=linear/linear_model/sex_indicator/weights/Initializer/zeros:08
ū
1linear/linear_model/workclass_indicator/weights:06linear/linear_model/workclass_indicator/weights/AssignElinear/linear_model/workclass_indicator/weights/Read/ReadVariableOp:0(2Clinear/linear_model/workclass_indicator/weights/Initializer/zeros:08
æ
"linear/linear_model/bias_weights:0'linear/linear_model/bias_weights/Assign6linear/linear_model/bias_weights/Read/ReadVariableOp:0(24linear/linear_model/bias_weights/Initializer/zeros:08"Ø
	variables
k
global_step:0global_step/Assign!global_step/Read/ReadVariableOp:0(2global_step/Initializer/zeros:0H
»
!linear/linear_model/age/weights:0&linear/linear_model/age/weights/Assign5linear/linear_model/age/weights/Read/ReadVariableOp:0(23linear/linear_model/age/weights/Initializer/zeros:08
ß
*linear/linear_model/capital-gain/weights:0/linear/linear_model/capital-gain/weights/Assign>linear/linear_model/capital-gain/weights/Read/ReadVariableOp:0(2<linear/linear_model/capital-gain/weights/Initializer/zeros:08
ß
*linear/linear_model/capital-loss/weights:0/linear/linear_model/capital-loss/weights/Assign>linear/linear_model/capital-loss/weights/Read/ReadVariableOp:0(2<linear/linear_model/capital-loss/weights/Initializer/zeros:08
ū
1linear/linear_model/education_indicator/weights:06linear/linear_model/education_indicator/weights/AssignElinear/linear_model/education_indicator/weights/Read/ReadVariableOp:0(2Clinear/linear_model/education_indicator/weights/Initializer/zeros:08
ē
,linear/linear_model/hours-per-week/weights:01linear/linear_model/hours-per-week/weights/Assign@linear/linear_model/hours-per-week/weights/Read/ReadVariableOp:0(2>linear/linear_model/hours-per-week/weights/Initializer/zeros:08

6linear/linear_model/marital-status_indicator/weights:0;linear/linear_model/marital-status_indicator/weights/AssignJlinear/linear_model/marital-status_indicator/weights/Read/ReadVariableOp:0(2Hlinear/linear_model/marital-status_indicator/weights/Initializer/zeros:08

6linear/linear_model/native-country_indicator/weights:0;linear/linear_model/native-country_indicator/weights/AssignJlinear/linear_model/native-country_indicator/weights/Read/ReadVariableOp:0(2Hlinear/linear_model/native-country_indicator/weights/Initializer/zeros:08
’
2linear/linear_model/occupation_indicator/weights:07linear/linear_model/occupation_indicator/weights/AssignFlinear/linear_model/occupation_indicator/weights/Read/ReadVariableOp:0(2Dlinear/linear_model/occupation_indicator/weights/Initializer/zeros:08
ē
,linear/linear_model/race_indicator/weights:01linear/linear_model/race_indicator/weights/Assign@linear/linear_model/race_indicator/weights/Read/ReadVariableOp:0(2>linear/linear_model/race_indicator/weights/Initializer/zeros:08

4linear/linear_model/relationship_indicator/weights:09linear/linear_model/relationship_indicator/weights/AssignHlinear/linear_model/relationship_indicator/weights/Read/ReadVariableOp:0(2Flinear/linear_model/relationship_indicator/weights/Initializer/zeros:08
ć
+linear/linear_model/sex_indicator/weights:00linear/linear_model/sex_indicator/weights/Assign?linear/linear_model/sex_indicator/weights/Read/ReadVariableOp:0(2=linear/linear_model/sex_indicator/weights/Initializer/zeros:08
ū
1linear/linear_model/workclass_indicator/weights:06linear/linear_model/workclass_indicator/weights/AssignElinear/linear_model/workclass_indicator/weights/Read/ReadVariableOp:0(2Clinear/linear_model/workclass_indicator/weights/Initializer/zeros:08
æ
"linear/linear_model/bias_weights:0'linear/linear_model/bias_weights/Assign6linear/linear_model/bias_weights/Read/ReadVariableOp:0(24linear/linear_model/bias_weights/Initializer/zeros:08*×
classificationÄ
3
inputs)
input_example_tensor:0’’’’’’’’’-
classes"
head/Tile:0’’’’’’’’’A
scores7
 head/predictions/probabilities:0’’’’’’’’’tensorflow/serving/classify*Ż
predictŃ
5
examples)
input_example_tensor:0’’’’’’’’’?
all_class_ids.
head/predictions/Tile:0’’’’’’’’’?
all_classes0
head/predictions/Tile_1:0’’’’’’’’’A
	class_ids4
head/predictions/ExpandDims:0	’’’’’’’’’@
classes5
head/predictions/str_classes:0’’’’’’’’’>
logistic2
head/predictions/logistic:0’’’’’’’’’k
logitsa
Jlinear/linear_model/linear/linear_model/linear/linear_model/weighted_sum:0’’’’’’’’’H
probabilities7
 head/predictions/probabilities:0’’’’’’’’’tensorflow/serving/predict*

regression
3
inputs)
input_example_tensor:0’’’’’’’’’=
outputs2
head/predictions/logistic:0’’’’’’’’’tensorflow/serving/regress*Ų
serving_defaultÄ
3
inputs)
input_example_tensor:0’’’’’’’’’-
classes"
head/Tile:0’’’’’’’’’A
scores7
 head/predictions/probabilities:0’’’’’’’’’tensorflow/serving/classify