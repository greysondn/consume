package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;

class ErrorExpression extends BaseExpression
{
    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        env.outStream("I don't understand what you're asking me to do.");
    }
}