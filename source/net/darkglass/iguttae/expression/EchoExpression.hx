package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.actor.Actor;

class EchoExpression extends BaseExpression
{
    public function new()
    {
        // parent can do the thing
        super();
        
        // now actually build this up
        this.command = "echo";

        this.helpShow = true;
        this.helpExample = "echo [words]";
        this.helpString  = "repeats [words] back to you";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // let's just find out where to chunk it!
        var breakPoint:Int = input.indexOf(" ");

        // and then print the substring!
        env.outStream(input.substring(breakPoint + 1));
    }
}