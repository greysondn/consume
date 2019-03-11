package net.darkglass.iguttae.environment;

import net.darkglass.iguttae.expression.BaseExpression;

class Environment
{
    /**
     * Literally all the commands in the game
     */
    public var commands:Array<BaseExpression> = [];


    /**
     * Whether we should print literally all messages or not.
     * 
     * This is likely most important when the game is loading, to be honest.
     */
     public var printAll:Bool = false;

    /**
     * Constructor
     */
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