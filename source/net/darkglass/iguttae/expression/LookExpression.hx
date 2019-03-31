package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;

class LookExpression extends BaseExpression
{
    public function new()
    {
        // parent can do the thing
        super();
        
        // now actually build this up
        this.command = "look";

        this.helpShow    = true;
        this.helpExample = "look";
        this.helpString  = "displays the description for the current location";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        actor.location.describe(env);
    }
}