package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;

class HelpExpression extends BaseExpression
{
    override public function eval(input:String):String
    {
        // yeah no
        var ret:String = "";
        ret = ret + "----" + "\n";
        ret = ret + "HELP" + "\n";
        ret = ret + "----" + "\n";
        ret = ret + "Available Commands:" + "\n";
        ret = ret + "echo [words]" + "\n";
        ret = ret + "replies with [words]" + "\n";
        ret = ret + "\n";
        ret = ret + "help" + "\n";
        ret = ret + "Prints this help message" + "\n";
        ret = ret + "\n";
        ret = ret + "There may be other, undocumented commands.";

        return ret;
    }
}