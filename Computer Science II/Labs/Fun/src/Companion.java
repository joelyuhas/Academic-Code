import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * Created by Joel on 11/5/2015.
 */
public class Companion {
    private int fightingEfficency;
    private int insanity;
    private int moral;
    private int effect;

    private ArrayList<Integer> chakaras;
    private ArrayList<Integer> natachaLatouf;

    /**
     * the booleans are characteristic types that will make it so a character cannot or can only
     * be affected by a certain paramater to a specific extent:
     *
     * for example, hardCore means that they cannot fully go into ptsd, and rely on their experience
     *
     * Essentially, these are the building blocks of a person, that when entered, will determine thier:
     *  -insanity               -how the toll of war has effected them
     *  -moral                  -how determined they are to keep going
     *  -effect                 -the effect they have on their teamates (boost moral etc)
     *  -fightingEfficeny       -their overall ability to fight enemies and make good decisions
     */

    /**
     * ---------CHANGES---------
     * Chakaras help determine a persons personality:
     * [[-- 7 values in this order-- ]]
     *
     * violet           -spiritual, undersantidng, knowing, bliss, oneness                                      -understanding/knowedge
     * indigo           -psychic abilities, imagination                                                         -imagination
     * blue             -speech, self expression                                                                -speech
     * green            -love, balance, compasion                                                               -compasion
     * yello            -mental functioning. power, control, freedom to be oneself                              -thinking ability
     * orange           -emotion, creativiy, sexual energy                                                      -feelings
     * red              -instinct, survival, security                                                           -survival instinct
     */

    /**
     * ---------CHANGES---------
     *natachaLatouf wheel used to also help express persons personality
     * [[-- 4 values in this order-- ]]
     *
     * phlegmatic       -thoughtful, introverted thinker, calm, controlled, peacful, reliable                   -calm thinker
     * melancholic      -heavyhearted, eye for detail, quiet, unsociable, pessimistic, sober, anxious, moody    -depressed
     * chloeric         -strong willed, driven, productive, agresuve, impulsive, optimistic                     -zealouse determination
     * sanguine         -leadership, carefree, easygoing, responsive, outgoing, sociable                        -leader
     *
     * phlegmatic + melancholic = Introverted
     * sanguine + choleric = Extraverted
     * phlegmatic + sanguine = Stable
     * melancholic + choleric = Unstable
     */

    /**
     * ---------STATIC---------
     * Static personality traits that are deeply rooted but can be effected by what has happened to them
     * in some cases, making them act the opposite of what they are
     *
     * -honest              -dishonist
     * -loyal               -disloyal
     * -kind                -mean
     * -respectful          -disrespectful
     * -ambitous            -unenthusiastic
     *
     * -patient             -impatient
     * -polite              -rude
     * -determined          -undetermined
     * -persistent          -ceasing
     * -adventurouse        -timid
     *
     * -cooperative         -solo
     * -optimistic          -pessimistic
     * -funny               -bland
     * -merciful            -unforgiving
     * -educated            -ignorant
     *
     * -informed            -obliviouse
     * -selfless            -selfish/greedy
     * -gentel              -cruel
     * -good intentions     -malicious
     * -humble              -obnoxious
     *
     * -effective           -ineffective
     * -calm                -spazy
     * -instinctive         -non instinctive
     * -sociable            -introverted
     * -creative            -unimaginative
     */

    /**
     * How the system will works:
     *
     * there will be some static describing features that a character will have that do not change in terms of personality
     *
     * then there will be fluxuating personality traits that do change over the course of combat, training, and through missions
     *
     *  there are physical traits, such as strength and endurance that effect the persons ability to fight that can change.
     */


    public Companion( int training, int experience, int strength, int endurance, int knowledge, int loyalty,
                      int IQ,
                      ArrayList chakaras, ArrayList natachaLatouf,
                      boolean hardCore, boolean daisy, boolean fervor, boolean ptsd){



    }

    public Companion( ){

    }


}
