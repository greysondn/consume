package net.darkglass.iguttae.environment;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.actor.Actor;

class Environment
{
    /**
     * Literally all the commands in the game
     */
    public var commands:Array<BaseExpression> = [];

    /**
     * All actors in the game
     */
    public var actors:Array<Actor> = [];

    /**
     * All rooms in the game. Because they're indexed.
     */
    public var rooms:Array<Actor>  = [];

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

    /**
     * Add an actor to this game's environment
     * 
     * @param actor actor to add
     */
    public function addActor(actor:Actor):Void
    {
        if (-1 == this.actors.indexOf(actor))
        {
            this.actors.push(actor);
        }
    }

    /**
     * Remove an actor from this game's environment
     * 
     * @param actor actor to remove
     */
    public function removeActor(actor:Actor):Void
    {
        this.actors.remove(actor);
    }

    /**
     * Add room to this game's environment. Actually an indexed thing so...
     * you know, it matters.
     * 
     * @param room room to add
     */
    public function addRoom(room:Actor):Void
    {
        if (-1 == this.rooms.indexOf(room))
        {
            this.rooms.push(room);
            this.rooms.sort(Actor.cmpIndex);
        }

        this.addActor(room);
    }

    /**
     * Remove room from this environment.
     * 
     * @param room room to remove.
     */
    public function removeRoom(room:Actor):Void
    {
        this.rooms.remove(room);
        this.removeActor(room);
    }

    public function checkIndexIntegrity(roster:Array<Actor>):Bool
    {
        // return. true if integrity exists fine
        var ret = true;

        for (i in 0...roster.length)
        {
            if (roster[i].index != i)
            {
                ret = false;
            }
        }

        return ret;
    }
}