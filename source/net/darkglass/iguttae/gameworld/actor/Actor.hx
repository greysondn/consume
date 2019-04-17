package net.darkglass.iguttae.gameworld.actor;

import net.darkglass.iguttae.enums.Verbosity;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.Constants;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.ConstantList;

/**
 * Parent for interactibles ingame. Not really meant to be called itself.
 */
class Actor
{
    /**
     * The types of containables this can contain.
     */
    public var containerFor:ConstantList = new ConstantList();

    /**
     * Aliases for this object - as in things it answers to
     */
    private var aliases:Array<String> = [];
    
    /**
     * The types of containers this is containable in
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    public var containableIn:ConstantList = new ConstantList();

    /**
     * The things this is containing
     */
    private var contents:Array<Actor> = [];

    /**
     * Whether this is a key
     */
    public var isKey:Bool = false;

    /**
     * Combos for this object
     */
    public var combos:Array<Int> = [];

    /**
     * The permissions associated with this actor.
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    public var permissions:ConstantList = new ConstantList();

    /**
     * Access point for constants
     */
    public var consts:Constants = Constants.create();

    /**
     * Whether this object is indestructible
     */
    public var isIndestructible:Bool = false;

    /**
     * Whether this object is a key item
     */
    public var isKeyItem:Bool = false;

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
     * Whether this is unique or not. Mostly matters for items, honestly.
     */
    public var isUnique:Bool = false;

    /**
     * Spawn count. Again, mostly matters for items.
     */
    public var cloneCount:Int = 0;

    /**
     * Whether this is a clone or not. Don't clone clones brah.
     */
    public var isClone:Bool = false;

    /**
     * Constructor
     */
    public function new()
    {
        // pass for now
    }

    public function insert(actor:Actor):Void
    {
        if (-1 == this.contents.indexOf(actor))
        {
            // if (this.canContain(actor))
            // {
                this.contents.push(actor);
            // }
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

    /**
     * Put item into this thing's inventory. As opposed to "inside this thing".
     * 
     * TODO: Write more of this function, checks etc
     * 
     * @param item  item to put into inventory
     * 
     * @return Bool whether or not it was moved into inventory. If it wasn't,
     *              most likely it's in the place it started.
     */
    public function hold(item:Actor):Bool
    {
        // eventual return
        var ret:Bool = true;

        // put item in inventory
        this.inventory.push(item);

        // return
        return ret;
    }

    /**
     * Ask actor to remove this item from its inventory. As opposed to its
     * insides. Caller is responsible for taking care of the item in question.
     * 
     * @param item  item to drop
     * 
     * @return Bool whether we actually managed to drop it
     */
    public function drop(item:Actor):Bool
    {
        // eventual return
        var ret:Bool = true;
        
        // attempt to remove it
        ret = this.inventory.remove(item);

        // return
        return ret;
    }

    /**
     * List this actor's inventory. Don't do anything fancy with this -
     * the inventory this returns is literally the player's inventory right now.
     * 
     * @return Array<Inventory> the players inventory
     */
    public function listInventory():Array<Actor>
    {
        return this.inventory;
    }

    /**
     * Whether or not we can clone this.
     * 
     * @return Bool true if we can, false if we can't.
     */
    public function canClone():Bool
    {
        // generally, we can
        var ret:Bool = true;

        // however, if it's unique and one is spawned already, we can't
        if (this.isUnique)
        {
            if (this.cloneCount >= 1)
            {
                ret = false;
            }
        }

        // shouldn't be cloning clones either
        if (this.isClone)
        {
            ret = false;
        }

        // end
        return ret;
    }

    /**
     * As in this is just a prototype with frills. Make sure you canClone()
     * first. This won't try to stop you if you fail to check for yourself!
     * 
     * @return Actor a clone of this actor
     */
    public function clone():Actor
    {
        var ret:Actor = new Actor();
        
        // ------------------------
        // copy all the properties!
        // ------------------------

        // brief
        ret.brief = this.brief;

        // containableIn
        ret.containableIn = this.containableIn.clone();

        // containerFor
        ret.containerFor = this.containerFor.clone();

        // clone count
        this.cloneCount = this.cloneCount + 1;
        ret.cloneCount = this.cloneCount;

        // combos
        for (i in 0...this.combos.length)
        {
            ret.combos.push(this.combos[i]);
        }

        // contents, I'm thinking we really shouldn't

        // exits, can skip I think

        // index
        ret.index = this.index;

        // inventory, can skip I think

        // isClone - we aren't but ret is
        ret.isClone = true;

        // isKey
        ret.isKey = this.isKey;

        // isPlayer, shouldn't confuse the matter

        // location - can skip, I think

        // longview
        ret.longview = this.longview;

        // name
        ret.name = this.name;

        // permissions
        ret.permissions = this.permissions.clone();

        // unique
        ret.isUnique = this.isUnique;

        // key item
        ret.isKeyItem = this.isKeyItem;

        // indestructibe
        ret.isIndestructible = this.isIndestructible;
        
        // verbose
        ret.verbose = this.verbose;

        // weight
        ret.weight = this.weight;

        // aliases
        for (alias in this.aliases)
        {
            ret.addAlias(alias);
        }

        // return
        return ret;
    }

    public function addAlias(alias:String):Void
    {
        this.aliases.push(alias);
    }

    public function answersTo(alias:String):Bool
    {
        var ret:Bool = false;

        for (entry in this.aliases)
        {
            // debugging
            if (entry.toLowerCase() == alias.toLowerCase())
            {
                ret = true;
            }
        }

        return ret;
    }

    public function hasAnyAnswering(alias:String):Bool
    {
        // normally, no, I guess
        var ret:Bool = false;

        // search all contents, inventory, etc
        if (this.answersTo(alias))
        {
            ret = true;
        }

        for (item in this.inventory)
        {
            if (item.answersTo(alias))
            {
                ret = true;
            }
        }

        for (item in this.contents)
        {
            if (item.answersTo(alias))
            {
                ret = true;
            }
        }

        return ret;
    }

    public function getAllAnswering(alias:String):Array<Actor>
    {
        var ret:Array<Actor> = [];

        if (this.answersTo(alias))
        {
            ret.push(this);
        }

        for (item in this.inventory)
        {
            if (item.answersTo(alias))
            {
                ret.push(item);
            }
        }

        for (item in this.contents)
        {
            if (item.answersTo(alias))
            {
                ret.push(item);
            }
        }

        return ret;
    }
}