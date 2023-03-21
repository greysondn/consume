package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.expression.ErrorExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;

class RootExpression extends BaseExpression
{
    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // clean that up
        var swap:String = input;
        swap = StringTools.trim(swap);
        swap = swap.toLowerCase();

        // chunk
        var inChunks:Array<String> = swap.split(" ");

        // set up for command
        var next:BaseExpression;

        // command is based on first one entirely
        if (env.hasCommand(inChunks[0]))
        {
            next = env.findCommand(inChunks[0]);
        }
        else
        {
            next = new ErrorExpression();
        }

        // make sure the player is allowed to do that if it's the player
        if (actor.isPlayer)
        {
            if (!next.playerAllowed)
            {
                next = new ErrorExpression();
            }
        }

        // do it
        next.eval(swap, env, actor);
    }
}