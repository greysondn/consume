package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.Entity;

/**
 * Simple expression to base every other expression on
 */
class BaseExpression
{
    /**
     * the base command for this expression
     */
    public var command:String = "";

    /**
     * Whether or not the player can use this expression
     */
    public var playerAllowed:Bool = true;

    /**
     * the aliases for this command's base command
     */
     public var aliases:Array<String> = [];

    /**
     * whether or not to show this command in help listing
     */
    public var helpShow:Bool = false;

    /**
     * the help example for this command
     */
    public var helpExample:String = "";

    /**
     * the help string for this command
     */
    public var helpString:String = "";
    
    /**
     * Just create an expression to parse shit, man
     */
    public function new(){}

    /**
     * Try to run in and push output
     * 
     * @param input         command to try to run
     * @param env           environment to run it in
     * @param actor         actor to perform any changes on
     */
    public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // pass
        env.outStream("Iguttae BaseExpression eval - try overriding?");
    }

    /**
     * Checks to see if this will answer to a given string - basically, whether
     * this can parse the command that string represents.
     * 
     * @param input string to check against
     * @return Bool whether or not this answers to input
     */
    public function answersTo(input:String):Bool
    {
        // eventual return
        var ret:Bool = false;

        // check name first
        if (this.command == input)
        {
            ret = true;
        }

        // then loop over the array
        for (alias in this.aliases)
        {
            if (alias == input)
            {
                ret = true;
            }
        }

        // end
        return ret;
    }

    public function removeFirstWord(input:String):String
    {
        var ret:String = "";

        var breakPoint:Int  = input.indexOf(" ");

        // if the breakpoint even exists - it very well may not
        if (-1 == breakPoint)
        {
            // just return the string
            ret = input;
        }
        else
        {
            // break it off!
            ret = input.substring(breakPoint + 1);
        }

        return ret;
    }

    /**
     * Makes sure the next thing is at least one of what is expected.
     * 
     * @param input     input to check next
     * @param expected  array of things that can go here
     * @return Bool     whether that's next
     */
    public function isNextOrFalse(input:String, expected:Array<String>):Bool
    {
        // break it up
        var swp:Array<String> = input.split(" ");
        
        // ret
        var ret:Bool = true;

        // now check if the first member matches
        if (-1 == expected.indexOf(swp[0]))
        {
                // not there
                ret = false;
        }

        // end
        return ret;
    }
}