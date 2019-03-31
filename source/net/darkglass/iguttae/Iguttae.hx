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
    public var env:Environment;

    public function new(environment:Environment)
    {
        this.env = environment;
    }

    public function eval(input:String):Void
    {
        var interpreter:RootExpression = new RootExpression();
        interpreter.eval(input, this.env, this.env.player);
    }
}