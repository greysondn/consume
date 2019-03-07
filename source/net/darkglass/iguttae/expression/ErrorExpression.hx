package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;

class ErrorExpression extends BaseExpression
{
    override public function eval(input:String, env:Environment):String
    {
        return "I don't understand what you're asking me to do.";
    }
}