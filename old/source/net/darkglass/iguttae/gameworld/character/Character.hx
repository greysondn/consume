package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.character.body.Measurement;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.character.CharacterPubsubhub;
import net.darkglass.iguttae.gameworld.character.Species;
import net.darkglass.iguttae.gameworld.character.Stat;
import net.darkglass.iguttae.gameworld.character.ThresString;
import net.darkglass.iguttae.gameworld.character.body.ContainerBodyPart;
import net.darkglass.iguttae.gameworld.character.body.BodyPartCollection;

/**
 * Characters should be derived from this class, or members of this class.
 * 
 * This just sets sane defaults for everything.
 */
class Character extends Actor
{
    /**
     * This character's pubsubhub, for things that happen to it which require
     * signalling, apparently, to do worth anything.
     */
    public var pubsub:CharacterPubsubhub = new CharacterPubsubhub();

    /**
     * Pointer to a basis species. Or should be, anyway.
     */
    public var speciesBase:Species = null;

    /**
     * Whether this character can cock vore
     * 
     * This is currently defined by a perk? Whatever.
     * 
     * TODO: Make this not defined by a perk. Lean in to flags.
     */
    public var canCV:Bool = false;

    /**
     * Whether this character can breast vore
     *
     * This is currently defined by a perk? Whatever.
     *
     * TODO: Make this not defined by a perk. Lean in to flags.
     */
    public var canBV:Bool = false;

    /**
     * Whether this character can anal vore
     *
     * This is currently defined by a perk? Whatever.
     *
     * TODO: Make this not defined by a perk. Lean in to flags.
     */
    public var canAV:Bool = false;

    /**
     * Whether this character can unbirth
     *
     * This is currently defined by a perk? Whatever.
     *
     * TODO: Make this not defined by a perk. Lean in to flags.
     */
    public var canUB:Bool = false;

    /**
     * String used to refer to this character's species in dialogue.
     */
    public var species:String = "NO SPECIES";

    /**
     * Body parts this actor has.
     */
    public var bodyParts:BodyPartCollection = new BodyPartCollection();

    // the part of measurements, kill me now please

    /**
     * height, in inches
     * 
     * In the original codebase, this was "tall"
     */
    public var height:Float = 0.0;

    /**
     * Fatness, in pounds.
     * 
     * This was an int in the original codebase.
     */
    public var fat:Float = 0.0;

    /**
     * Bra band size, in inches
     * 
     * This was an int in the original codebase.
     */
    public var chestSize:Float = 0.0;

    /**
     * Size around waist, in inches, not including stomach
     * 
     * Okay, one, wut
     * 
     * And two, this was an int in the original codebase.
     */
    public var waistSize:Float = 0.0;

    /**
     * Size around hips, in inches
     * 
     * Yes, this was actually a float in the original codebase.
     */
    public var hipSize:Float = 0.0;

    /**
     * Size of butt, in inches, beyond hipSize
     * 
     * This was an int in the original codebase.
     */
    public var buttSize:Float = 0.0;

    // all those containers
    public var testes:ContainerBodyPart  = new ContainerBodyPart();
    public var breasts:ContainerBodyPart = new ContainerBodyPart();
    public var stomach:ContainerBodyPart = new ContainerBodyPart();
    public var bowels:ContainerBodyPart  = new ContainerBodyPart();

    // more measures, ugh
    public var penisLength:Float = 0.0;
    public var penisWidth:Float = 0.0;
    public var penisErectionMultiplier:Float = 0.0;

    // Sins
    public var pride:Stat    = new Stat();
    public var lust:Stat     = new Stat();
    public var greed:Stat    = new Stat();
    public var wrath:Stat    = new Stat();
    public var gluttony:Stat = new Stat();
    public var sloth:Stat    = new Stat();
    public var envy:Stat     = new Stat();

    // stats
    public var health:Stat       = new Stat();
    public var strength:Stat     = new Stat();
    public var agility:Stat      = new Stat();
    public var endurance:Stat    = new Stat();
    public var intelligence:Stat = new Stat();

    // skills
    public var dodge:Stat = new Stat();
    public var run:Stat   = new Stat();
    public var melee:Stat = new Stat();
    public var sneak:Stat = new Stat();
    public var spot:Stat  = new Stat();

    // threshold sets.
    public var stomachSizeDesc:ThresString  = new ThresString("impossible");
    public var breastSizeDesc:ThresString   = new ThresString("off the charts");
    public var strDesc:ThresString          = new ThresString("off the chart");
    public var ballSizeDesc:ThresString     = new ThresString("off the charts");

    /**
     * How aroused this character is.
     */
    public var arousal:Float = 0.0;

    public function new()
    {
        // let parent do its thing
        super();

        // characters are containable in rooms
        this.containableIn.add(this.consts.get("container", "room"));

        // characters are containable in stomachs
        this.containableIn.add(this.consts.get("container", "stomach"));

        // characters can hold things in inventories, whee!
        this.inventory.containerFor.add(this.consts.get("container", "inventory"));

        // build threshold sets
        // TODO: Externalize these as data
        // TODO: These actually seem to be universal - extract to static?
        this.stomachSizeDesc.insert( 3, "flat");
        this.stomachSizeDesc.insert( 6, "small");
        this.stomachSizeDesc.insert( 8, "round");
        this.stomachSizeDesc.insert(10, "bulging");
        this.stomachSizeDesc.insert(20, "big");
        this.stomachSizeDesc.insert(30, "huge");
        this.stomachSizeDesc.insert(40, "massive");
        this.stomachSizeDesc.insert(50, "doorway-filling");
        this.stomachSizeDesc.insert(60, "person-sized");
        this.stomachSizeDesc.insert(80, "immobilizing");

        this.breastSizeDesc.insert( 3, "tiny");
        this.breastSizeDesc.insert( 6, "small");
        this.breastSizeDesc.insert( 8, "average");
        this.breastSizeDesc.insert( 10, "big");
        this.breastSizeDesc.insert( 14, "large");
        this.breastSizeDesc.insert( 20, "huge");
        this.breastSizeDesc.insert( 30, "massive");
        this.breastSizeDesc.insert( 50, "door-filling");
        this.breastSizeDesc.insert( 90, "person-sized");
        this.breastSizeDesc.insert(200, "room-filling");

        this.strDesc.insert( 3, "non-existent");
        this.strDesc.insert( 5, "small");
        this.strDesc.insert( 7, "average");
        this.strDesc.insert(11, "big");
        this.strDesc.insert(20, "huge");
        this.strDesc.insert(30, "massive");
        this.strDesc.insert(50, "bulging");

        this.ballSizeDesc.insert(3, "tiny");
        this.ballSizeDesc.insert(6, "small");
        this.ballSizeDesc.insert(8, "average");
        this.ballSizeDesc.insert(10, "big");
        this.ballSizeDesc.insert(14, "large");
        this.ballSizeDesc.insert(20, "huge");
        this.ballSizeDesc.insert(30, "massive");
        this.ballSizeDesc.insert(50, "door-filling");
        this.ballSizeDesc.insert(90, "person-sized");
        this.ballSizeDesc.insert(200, "room-filling");
    }

    /**
     * Get total weight of player, including stomach contents
     * 
     * In the original, this doesn't include inventory items
     * 
     * @return Float weight total.
     */
    public function totalWeight():Float
    {
        return 0.0;
    }

    /**
     * Converts a measure in inches to a measure in feet and inches.
     * 
     * See original code, "MyCharacter.hx":"toFeet()"
     * 
     * @param inches     the original measure, in inches
     * @return String    a string that's just the measure in feet and inches
     */
    public function inchesToFeetAndInches(inches:Float):String
    {
        var ret:String = "";

        var feet:Int = 0;

        while (inches >= 12)
        {
            feet   = feet   +  1;
            inches = inches - 12;
        }

        ret = ret + feet + "'";
        ret = ret + inches + "\"";
        
        return ret;
    }
}