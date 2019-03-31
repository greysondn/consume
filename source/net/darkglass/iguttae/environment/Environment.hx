package net.darkglass.iguttae.environment;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.character.Player;
import net.darkglass.iguttae.enums.Verbosity;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.exceptions.CompassError;

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
     * This is meant to be an output stream to dump text into
     */
    public var outStream:String -> Void;

    /**
     * Command to call on location changes
     */
    public var onLocationChange:String -> Void;

    /**
     * All rooms in the game. Because they're indexed.
     */
    public var rooms:Array<Actor>  = [];

    /**
     * Whether we can use god commands as a player
     */
    public var iddqd:Bool = true;

    /**
     * Sometimes, you just need the hand of god. Well, actually, this is so
     * we can do actions in the interpreter independent of the player.
     */
    public var god:Actor = new Actor();

    /**
     * Our current verbosity setting
     */
    public var verbosity:Verbosity = Verbosity.VERBOSE;

    /**
     * The player. Sometimes we need things done specifically with it and all
     * for it. Blaaaaaah.
     */
    public var player:Player = new Player();
    
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

    public function getRoom(index:Int):Actor
    {
        return this.rooms[index];
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

    public function checkRoomIntegrity():Bool
    {
        return this.checkIndexIntegrity(this.rooms);
    }

    /**
     * Helper function to determine compass based on string
     * 
     * @param str string input
     * 
     * @return Compass corrosponding to str
     * 
     * @throws CompassError if str doesn't corrospond to a Compass
     */
    public function stringToCompass(str:String):Compass
    {
        // eventual return
        var ret:Compass = Compass.NORTH;

        // convert to lowercase so I can have simpler checks
        var swp:String = str.toLowerCase();

        // this is all pretty straightforward
        if (("n" == swp) || ("north" == swp))
        {
            ret = Compass.NORTH;
        }
        else if (("ne" == swp) || ("northeast" == swp))
        {
            ret = Compass.NORTHEAST;
        }
        else if (("e" == swp) || ("east" == swp))
        {
            ret = Compass.EAST;
        }
        else if (("se" == swp) || ("southeast" == swp))
        {
            ret = Compass.SOUTHEAST;
        }
        else if (("s" == swp) || ("south" == swp))
        {
            ret = Compass.SOUTH;
        }
        else if (("sw" == swp) || ("southwest" == swp))
        {
            ret = Compass.SOUTHWEST;
        }
        else if (("w" == swp) || ("west" == swp))
        {
            ret = Compass.WEST;
        }
        else if (("nw" == swp) || ("northwest" == swp))
        {
            ret = Compass.NORTHWEST;
        }
        else if (("i" == swp) || ("in" == swp))
        {
            ret = Compass.IN;
        }
        else if (("o" == swp) || ("out" == swp))
        {
            ret = Compass.OUT;
        }
        else if (("u" == swp) || ("up" == swp))
        {
            ret = Compass.UP;
        }
        else if (("d" == swp) || ("down" == swp))
        {
            ret = Compass.DOWN;
        }
        else
        {
            throw (new CompassError("Couldn't parse direction - " + swp));
        }

        // return
        return ret;
    }
}