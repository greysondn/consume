package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.expression.EchoExpression;
import net.darkglass.iguttae.expression.ErrorExpression;
import net.darkglass.iguttae.expression.HelpExpression;


class RootExpression extends BaseExpression
{
    override public function eval(input:String):String
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
        switch inChunks[0]
        {
            case "echo":
            {
                next = new EchoExpression(this.env);
            }
            case "help":
            {
                next = new HelpExpression(this.env);
            }
            default:
            {
                next = new ErrorExpression(this.env);
            }
        }

        // do it
        ret = next.eval(swap);

        // end?
        return ret;
    }
}