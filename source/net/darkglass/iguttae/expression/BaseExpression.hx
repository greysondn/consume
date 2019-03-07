package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.environment.Environment;

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
     * Try to run in and give back output
     * 
     * @param input         command to try to run
     * @param env           environment to run it in
     * @return String   result of evaluation
     */
    public function eval(input:String, env:Environment):String
    {
        // pass
        return "Iguttae BaseExpression eval - try overriding?";
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
}