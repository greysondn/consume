import flash.*;
import flash.utils.*;
import haxe.macro.Type.ClassField;

class MyItem {
    // public var name:String;
    // public var mass:Int;
    // public var value:Int;
    // public var desc:String;
    
    /**
     * How many the player has.
     * 
     * Must not be one of:
     * ARMOR
     * WEAPON
     * RING
     * 
     * ... in order to stack
     */
    public var count:Int = 1;
    public var specials:Array<String> = new Array();
    public var rarity:String;
    public var type:String;
    
    /**
     * Gives the playerCharacter an instance of this item. Not to be confused
     * with a character giving another character an item.
     * 
     * @param playerCharacter   the Player's character (really?)
     * @return String           the output string corrosponding to the item.
     */
    public function give(playerCharacter:MyPlayerObject):String
    {
        // I've decimated this down to just the string now.
        // yes, yes I did. ~greysondn, 8 August 2020
        return "<p>You tuck the " + this.name.toLowerCase() +
        " away in your pocket.</p><br><p>You have " + itemCount +
        " of them.</p><br>";
    }
    
    /**
     * Equivalent to the player throwing away this item.
     * 
     * @param playerCharacter the Player's character (really?)
     * @return String         the output string corrosponding to the item.
     */
    public function toss(playerCharacter:MyPlayerObject):String
    {
        // I've decimated this down to just the string now.
        // yes, yes I did. ~greysondn, 8 August 2020
        return "<p>You drop the " + this.name.toLowerCase() + ".</p><br>";
    }
    
    /**
     * Makes the player eat this, complete with a this.toss/this.count decrement
     * and everything.
     * 
     * @param playerCharacter   the Player's character (really?)
     * @return String           the output string corrosponding to the item.
     */
    public function eat(playerCharacter:MyPlayerObject):String
    {
        playerCharacter.stomachCurrent += this.mass;
        
        // decrement count/toss here
        
        return "<p>You pop the " + this.name.toLowerCase() + 
        " into your mouth and swallow it down.</p><br>";
    }
}