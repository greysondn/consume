package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.character.body.Measurement;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.character.Species;
import net.darkglass.iguttae.gameworld.character.Stat;
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
     * Pointer to a basis species. Or should be, anyway.
     */
    public var speciesBase:Species = null;

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
