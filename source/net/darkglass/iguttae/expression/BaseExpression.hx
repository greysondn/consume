package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.environment.Environment;

/**
 * Simple expression to base every other expression on
 */
class BaseExpression
{
    /**
     * Working env for this expression
     */
    public var env:Environment;

    /**
     * Just create an expression to parse shit, man
     * 
     * @param environment context eval will happen in
     */
    public function new(environment:Environment)
    {
        this.env = environment;
    }

    /**
     * Try to run in and give back output
     * 
     * @param input        command to try to run
     * @return String   result of evaluation
     */
    public function eval(input:String):String
    {
        // pass
        return "Iguttae BaseExpression eval - try overriding?";
    }
}