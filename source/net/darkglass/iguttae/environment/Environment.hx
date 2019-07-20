package net.darkglass.iguttae.environment;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.character.Player;
import net.darkglass.iguttae.enums.Verbosity;
import net.darkglass.iguttae.gameworld.container.IndexedEntityContainer;
import net.darkglass.iguttae.gameworld.character.SpeciesIndex;

class Environment
{
    /**
     * Literally all the commands in the game
     */
    public var commands:Array<BaseExpression> = [];

    /**
     * All actors in the game
     */
    public var actors:IndexedEntityContainer = new IndexedEntityContainer();

    /**
     * All items in the game
     */
    public var items:IndexedEntityContainer = new IndexedEntityContainer();

    /**
     * All rooms in the game. Because they're indexed.
     */
    public var rooms:IndexedEntityContainer  = new IndexedEntityContainer();

    /**
     * This is meant to be an output stream to dump text into
     */
    public var outStream:String -> Void;

    /**
     * Command to call on location changes
     */
    public var onLocationChange:String -> Void;

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
     * collection of species to build all the other things out from
     */
    public var species:SpeciesIndex = new SpeciesIndex();
    
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
        this.rooms.metacontainer = this.actors;
        this.items.metacontainer = this.actors;
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