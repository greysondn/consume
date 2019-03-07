package net.darkglass.iguttae.environment;

import net.darkglass.iguttae.expression.BaseExpression;

class Environment
{
    public var commands:Array<BaseExpression> = [];

    public function new()
    {
        // it's got variables! YEAH!
    }

    public function hasCommand(mneumonic:String):Bool
    {
        var ret:Bool = false;

        for (command in this.commands)
        {
            if (command.answersTo(mneumonic))
            {
                ret = true;
            }
        }

        return ret;
    }

    public function findCommand(mneumonic:String):BaseExpression
    {
        var ret:BaseExpression = null;

        for (command in this.commands)
        {
            if (command.answersTo(mneumonic))
            {
                ret = command;
            }
        }

        return ret;
    }
}