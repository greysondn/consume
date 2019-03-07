package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.expression.ErrorExpression;
import net.darkglass.iguttae.environment.Environment;


class RootExpression extends BaseExpression
{
    override public function eval(input:String, env:Environment):String
    {
        // eventual return
        var ret:String = "";

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

        // do it
        ret = next.eval(swap, env);

        // end?
        return ret;
    }
}