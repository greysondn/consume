package net.darkglass.iguttae;

import net.darkglass.iguttae.expression.RootExpression;
import net.darkglass.iguttae.environment.Environment;

/**
 * IGUTTAE - I give up, this is a text adventure engine
 * 
 * The engine designed for the rework of Consume.
 */
class Iguttae 
{
    /**
     * This is meant to be an output stream to dump text into
     */
    public var outStream:String -> Void;

    public function new()
    {
        // do nothing
    }

    public function eval(input:String):Void
    {
        var interpreter:RootExpression = new RootExpression(new Environment());

        outStream(interpreter.eval(input));
    }
}