package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;

class ErrorExpression extends BaseExpression
{
    override public function eval(input:String):String
    {
        return "I don't understand what you're asking me to do.";
    }
}