package net.darkglass.iguttae.gameworld.actor;

import net.darkglass.iguttae.enums.Verbosity;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.actor.Constants;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.environment.Environment;

/**
 * Parent for interactibles ingame. Not really meant to be called itself.
 */
class Actor
{
    /**
     * The types of containables this can contain.
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    private var containerFor:Array<Int> = [];
    
    /**
     * The types of containers this is containable in
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    private var containableIn:Array<Int> = [];

    /**
     * The things this is containing
     */
    private var contents:Array<Actor> = [];

    /**
     * The permissions associated with this actor.
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    private var permissions:Array<Int> = [];

    /**
     * Access point for constants
     */
    public var consts:Constants = Constants.create();

    /**
     * Whether or not this is the player
     */
    public var isPlayer:Bool = false;

    /**
     * This thing's inventory, if it has one.
     */
    public var inventory:Array<Actor> = [];

    /**
     * Exits from this, as in a room, typically, but could be anything. A
     * container even.
     */
    public var exits:Map<Compass, Transition> = new Map<Compass, Transition>();
    
    /**
     * Name of this actor
     */
    public var name:String = "ERROR: NO NAME";

    /**
     * Weight this actor has. In pounds, apparently.
     */
    public var weight:Float = 0;

    /**
     * Location this is in. Might be someone else, in which case it means their
     * stomach.
     */
    public var location:Actor;

    /**
     * String to print when this is looked at from elsewhere
     */
    public var longview:String;

    /**
     * Description to show when "brief" is the current output mode
     */
    public var brief:String;

    /**
     * Description to show when "verbose" is the current output mode
     */
    public var verbose:String;

    /**
     * Index, for indexed actors. This is considered undefined for arbitrary
     * actors, but some - like rooms and transitions - are actually indexed.
     */
     public var index:Int;

    /**
     * Constructor
     */
    public function new()
    {
        // pass for now
    }
    
    /**
     * Helper function to check if a list has a constant
     * 
     * @param list      list to check
     * @param constant  constant to check for
     * @return Bool     whether constant is in list
     */
    private function hasConstant(list:Array<Int>, constant:Int):Bool
    {
        return (list.indexOf(constant) != -1);
    }

    /**
     * Add constant to list if it isn't already there
     * 
     * @param list      list to add to
     * @param constant  constant to add to list
     */
    private function addConstant(list:Array<Int>, constant:Int):Void
    {
        if (list.indexOf(constant) == -1)
        {
            list.push(constant);
        }
    }

    /**
     * Remove constant from list if it's there
     * 
     * @param list      list to remove constant from
     * @param constant  constant to remove from list
     */
    private function removeConstant(list:Array<Int>, constant:Int):Void
    {
        list.remove(constant);
    }

    /**
     * Check whether this is a valid container for cType.
     *
     * @param constant  type we wonder if this is a container for
     * @return Bool     whether it's a container for cType
     */
    public function isContainerFor(constant:Int):Bool
    {
        return this.hasConstant(this.containerFor, constant);
    }
    
    /**
     * Makes this now be a container for cType if it wasn't already
     * 
     * @param constant container type
     */
    public function addContainerFor(constant:Int):Void
    {
        this.addConstant(this.containerFor, constant);
    }

    /**
     * Makes this now not be a container for cType if it was before
     * 
     * @param constant container type
     */
    public function removeContainerFor(constant:Int):Void
    {
        this.removeConstant(containerFor, constant);
    }

    /**
     * Check whether this is containable in cType.
     *
     * @param constant type of container we wonder if this can go into
     * @return Bool whether it's containable in cType
     */
    public function isContainableIn(constant:Int):Bool
    {
        return this.hasConstant(this.containableIn, constant);
    }
    
    /**
     * Makes this now be containable in cType if it wasn't already
     * 
     * @param cType container type
     */
    public function addContainableIn(constant:Int):Void
    {
        this.addConstant(this.containableIn, constant);
    }
    
    /**
     * Makes this not be containable in cType if it was before
     * 
     * @param cType container type
     */
    public function removeContainableIn(constant:Int):Void
    {
        this.removeConstant(this.containableIn, constant);
    }

    /**
     * Tells us whether this can contain actor.
     * 
     * TODO: Finish docs
     * 
     * @param actor 
     * @return Bool
     */
    public function canContain(actor:Actor):Bool
    {
        // eventual return
        var ret:Bool = false;

        // iterate
        for (cType in this.containerFor)
        {
            if (actor.isContainableIn(cType))
            {
                ret = true;
            }
        }
        // end
        return ret;
    }

    /**
     * Check if this actor has a certain permission
     * 
     * @param constant
     * @return Bool
     */
    public function hasPermission(constant:Int):Bool
    {
        return this.hasConstant(this.permissions, constant);
    }

    /**
     * Add a permission to this actor if it isn't present already.
     * 
     * @param permission 
     */
    public function addPermission(constant:Int):Void
    {
        this.addConstant(this.permissions, constant);
    }

    /**
     * Remove a permission from this actor, if it's present.
     * 
     * @param permission 
     */
    public function removePermission(constant:Int):Void
    {
        this.removeConstant(this.permissions, constant);
    }

    public function insert(actor:Actor):Void
    {
        if (-1 == this.contents.indexOf(actor))
        {
            if (this.canContain(actor))
            {
                this.contents.push(actor);
            }
        }
    }

    public function remove(actor:Actor):Void
    {
        this.contents.remove(actor);
    }

    public function describe(env:Environment):Void
    {
        if (Verbosity.VERBOSE == env.verbosity)
        {
            env.outStream(this.verbose);
        }
        else
        {
            throw "WHAT IS VERBOSITY EVEN TO YOU";
        }
    }

    /**
     * Compare actors based on their indexes. Compatible with array sorts
     * in Haxe.
     * 
     * @param left  first actor, left hand of comparisons
     * @param right second actor, right hand of comparisons
     * 
     * @return Int  -1 if left  < right,
     *               0 if left == right,
     *               1 if left  > right
     */
    public static function cmpIndex(left:Actor, right:Actor):Int
    {
        // if you get an error from sort, something has gone horribly wrong.
        var ret:Int = 9001;

        if (left.index < right.index)
        {
            ret = -1;
        }
        else if (left.index > right.index)
        {
            ret = 1;
        }
        else if (left.index == right.index)
        {
            ret = 0;
        }

        return ret;
    }

    /**
     * TODO: Document
     * 
     * @param side 
     * @param trans 
     */
    public function addExit(side:Compass, trans:Transition):Void
    {
        // validation? Never heard of it.
        this.exits[side] = trans;
    }

    /**
     * TODO: Document
     * 
     * @param env
     * @return String
     */
    public function getExitList(env:Environment):String
    {
        var ret:String = "";
        var verbosity:Verbosity = env.verbosity;
        ret = ret + "Exits from here:";

        if (verbosity == Verbosity.VERBOSE)
        {
            for (dir in this.exits.keys())
            {
                if (Compass.NORTH == dir)
                {
                    ret = ret + "\n" + "- North : " + this.exits[dir].name;
                }
                else if (Compass.NORTHEAST == dir)
                {
                    ret = ret + "\n" + "- Northeast : " + this.exits[dir].name;
                }
                else if (Compass.EAST == dir)
                {
                    ret = ret + "\n" + "- East : " + this.exits[dir].name;
                }
                else if (Compass.SOUTHEAST == dir)
                {
                    ret = ret + "\n" + "- Southeast : " + this.exits[dir].name;
                }
                else if (Compass.SOUTH == dir)
                {
                    ret = ret + "\n" + "- South : " + this.exits[dir].name;
                }
                else if (Compass.SOUTHWEST == dir)
                {
                    ret = ret + "\n" + "- Southwest : " + this.exits[dir].name;
                }
                else if (Compass.WEST == dir)
                {
                    ret = ret + "\n" + "- West : " + this.exits[dir].name;
                }
                else if (Compass.NORTHWEST == dir)
                {
                    ret = ret + "\n" + "- Northwest : " + this.exits[dir].name;
                }
                else if (Compass.UP == dir)
                {
                    ret = ret + "\n" + "- Up : " + this.exits[dir].name;
                }
                else if (Compass.DOWN == dir)
                {
                    ret = ret + "\n" + "- Down : " + this.exits[dir].name;
                }
                else if (Compass.IN == dir)
                {
                    ret = ret + "\n" + "- In : " + this.exits[dir].name;
                }
                else if (Compass.OUT == dir)
                {
                    ret = ret + "\n" + "- Out : " + this.exits[dir].name;
                }
                else
                {
                    // impossible!
                    throw "Impossible!";
                }
            }
        }

        // return
        return ret;
    }
}