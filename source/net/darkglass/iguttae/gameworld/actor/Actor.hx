package net.darkglass.iguttae.gameworld.actor;

import net.darkglass.iguttae.enums.Verbosity;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.ConstantList;
import net.darkglass.iguttae.gameworld.Entity;
import net.darkglass.iguttae.gameworld.container.EntityContainer;

/**
 * Parent for interactibles ingame. Not really meant to be called itself.
 */
class Actor extends Entity
{
    /**
     * Whether this is a key
     */
    public var isKey:Bool = false;

    /**
     * Combos for this object
     */
    public var combos:Array<Int> = [];

    /**
     * This object's equipment slots - and what's in them
     */
    public var equipment:Map<Int, Null<Actor>> = [];

    /**
     * Slots this object can be fitted into, if any
     */
    public var validSlots:ConstantList = new ConstantList();

    /**
     * The permissions associated with this actor.
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    public var permissions:ConstantList = new ConstantList();

    /**
     * Whether this object is indestructible
     */
    public var isIndestructible:Bool = false;

    /**
     * Whether this object is a key item
     */
    public var isKeyItem:Bool = false;

    /**
     * This thing's inventory, if it has anything in it.
     */
    public var inventory:EntityContainer = new EntityContainer();

    /**
     * Exits from this, as in a room, typically, but could be anything. A
     * container even.
     */
    public var exits:Map<Compass, Transition> = new Map<Compass, Transition>();

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
     * Constructor
     */
    public function new()
    {
        super();
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
     * Adds an equipment slot to this Actor for no clear reason.
     *
     * @param slot which slot to add, per Constants.hx
     */
    public function addEquipmentSlot(slot:Int):Void
    {
        this.equipment[slot] = null;
    }

    /**
     * Removes an equipment slot from this actor for no clear reason
     * 
     * @param slot which slot to remove, per Constants.hx
     * 
     * @return the Actor that was in that slot.
     */
    public function removeEquipmentSlot(slot:Int):Null<Actor>
    {
        var ret:Actor = null;

        if(this.equipment.exists(slot))
        {
            ret = this.equipment[slot];
            this.equipment.remove(slot);
        }

        return ret;
    }

    public function equip(item:Actor, ?slot:Null<Int> = null):Bool
    {
        // default to the notion we can't equip it.
        var ret:Bool = false;

        // We start with if slot is set, as it's the only valid option in that
        // case.
        if (null != slot)
        {
            // does the slot exist?
            if (this.equipment.exists(slot))
            {
                // is this a valid slot for the equipment?
                if (item.validSlots.contains(slot))
                {
                    // deoccupy the slot
                    this.unequip(slot);
                
                    // put this in it
                    this.equipment[slot] = item;

                    // mark successful
                    ret = true;
                }
            }
        }
        else
        {
            // we'll have to try the slots and just take the first one
            var slotFound:Bool = false;

            for (k in this.equipment.keys())
            {
                if (item.validSlots.contains(k))
                {
                    if (!slotFound)
                    {
                        // we found a slot anyway
                        slotFound = true;

                        // we can just call this with a preferred slot
                        ret = this.equip(item, k);
                    }
                    else if (!ret)
                    {
                        // it wasn't succesfully put in, try again
                        ret = this.equip(item, k);
                    }
                    else
                    {
                        // pass. It's been equipped to some slot.
                        // we don't want to equip it twice.
                    }
                }
            } 
        }

        // finally return
        return ret;
    }

    /**
     * Attempts to remove either whatever may be in the given slot or the given
     * item (but not both from the slot in question. SPECIFY EXACTLY ONE INPUT.
     * 
     * @param slot slot to remove item from.
     * @param item item to remove from whatever slot it's in.
     * @return Bool Whether it was successfully removed. (Subjectively.)
     */
    public function unequip(?slot:Null<Int> = null, ?item:Null<Actor> = null):Bool
    {
        // eventual return
        var ret:Bool = false;

        // make sure programmer isn't an idiot
        if (slot != null && item != null)
        {
            throw "TOO MANY ARGUMENTS TO ACTOR.UNEQUIP()!!!";
        }
        else
        {
            // okay, now try, maybe programmer was smart.
            if (slot != null)
            {
                if (this.equipment.exists(slot))
                {
                    // okay, just set it to null
                    // maybe some checks here later, but it's this simple
                    this.equipment[slot] = null;
                    ret = true;
                }
                else
                {
                    // a nonexistent slot is always emptied successfully.
                    // separated because the if block may be expanded later.
                    ret = true;
                }
            }
            else if (item != null)
            {
                // some special logic in case we want to complicate this later.
                var found = false;

                // we have to iterate the keys of that dictionary looking for it.
                for (k in this.equipment.keys())
                {
                    if (this.equipment[k].answersTo(item.name))
                    {
                        // it's a match!
                        found = true;

                        // might want more complex logic later, but this works
                        // for now.
                        this.equipment[k] = null;

                        // might want more complex 
                        ret = true;
                    }
                }

                // if we never found it, it counts as removed (it wasn't on to
                // begin with)
                if (!found)
                {
                    ret = true;
                }
            }
            else
            {
                // they're both null. How does this programmer manage to remember
                // how to breathe?
                throw "TOO FEW ARGUMENTS TO ACTOR.UNEQUIP()!!!";
            }
        }

        // return
        return ret;
    }

    /**
     * As in this is just a prototype with frills. Make sure you canClone()
     * first. This won't try to stop you if you fail to check for yourself!
     * 
     * @return Actor a clone of this actor
     */
    public override function clone():Actor
    {
        var ret:Actor = new Actor();
        
        // ------------------------
        // copy all the properties!
        // ------------------------

        // brief
        ret.brief = this.brief;

        // containableIn
        ret.containableIn = this.containableIn.clone();

        // clone count
        this.cloneCount = this.cloneCount + 1;
        ret.cloneCount = this.cloneCount;

        // combos
        for (i in 0...this.combos.length)
        {
            ret.combos.push(this.combos[i]);
        }

        // contents, I'm thinking we really shouldn't

        // equipment, I'm thinking we really shouldn't

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

        // weight, in pounds, not including contents
        ret.weight = this.weight;

        // aliases
        for (alias in this.aliases)
        {
            ret.addAlias(alias);
        }

        // return
        return ret;
    }

    public function getAllAnswering(alias:String):Array<Actor>
    {
        var ret:Array<Actor> = [];

        if (this.answersTo(alias))
        {
            ret.push(this);
        }

        for (item in this.inventory.getAllAnswering(alias))
        {
            ret.push(cast(item, Actor));
        }

        return ret;
    }
}