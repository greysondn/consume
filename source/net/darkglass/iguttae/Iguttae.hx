package net.darkglass.iguttae;

import net.darkglass.iguttae.expression.RootExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;

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

    /**
     * Sometimes, you just need the hand of god. Well, actually, this is so
     * we can do actions in the interpreter independent of the player.
     */
    public var god:Actor = new Actor();

    public var env:Environment;

    public function new(environment:Environment)
    {
        this.env = environment;
    }

    public function eval(input:String):Void
    {
        var interpreter:RootExpression = new RootExpression();
        outStream(interpreter.eval(input, this.env, god));
    }
}