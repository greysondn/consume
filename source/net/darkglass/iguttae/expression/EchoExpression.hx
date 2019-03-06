package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;

class EchoExpression extends BaseExpression
{
    override public function eval(input:String):String
    {
        // let's just find out where to chunk it!
        var breakPoint:Int = input.indexOf(" ");

        // and then return the substring!
        return input.substring(breakPoint + 1);
    }
}