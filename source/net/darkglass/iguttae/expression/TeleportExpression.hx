package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.actor.Actor;

class TeleportExpression extends BaseExpression
{
    public function new()
    {
        // parent can do the thing
        super();
        
        // now actually build this up
        this.command = "teleport";

        this.helpShow = true;
        this.helpExample = "teleport [destination]";
        this.helpString  = "teleports you to the room with id [destination] - max is 32";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // decipher command
        var breakPoint:Int  = input.indexOf(" ");
        var lastHalf:String = input.substring(breakPoint + 1);
        var dest:Int        = Std.parseInt(lastHalf);

        // move actor
        actor.location.remove(actor);
        actor.location = env.getRoom(dest);
        actor.location.insert(actor);

        // output new description
        actor.location.describe(env);
    }
}