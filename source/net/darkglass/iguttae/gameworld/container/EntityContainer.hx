package net.darkglass.iguttae.gameworld.container;

import net.darkglass.iguttae.gameworld.Entity;
import net.darkglass.iguttae.gameworld.ConstantList;

/**
 * Just a type limited (or not) entity container.
 */
class EntityContainer extends Entity
{
    /**
     * The things this is containing
     */
    public var contents:Array<Entity> = [];

    /**
     * The types of containables this can contain.
     */
    public var containerFor:ConstantList = new ConstantList();

    /**
     * Constructor.
     */
    public function new()
    {
        // ya guessed it
        super();
    }

    /**
     * Get all contents answering a given alias
     * 
     * @param alias             Alias to check
     * @return Array<Entity>    everything that answers to it
     */
    public function getAllAnswering(alias:String):Array<Entity>
    {
        var ret:Array<Entity> = [];

        for (entry in this.contents)
        {
            if (entry.answersTo(alias))
            {
                ret.push(entry);
            }
        }

        return ret;
    }

    /**
     * Counts how many contents answer a given alias.
     * 
     * In reality, this just asks for the length of this.getAllAnswering().
     * 
     * @param alias alias to check
     * @return Int  how many things answer to it
     */
    public function countAllAnswering(alias:String):Int
    {
        return getAllAnswering(alias).length;
    }

    /**
     * Put item into this thing's inventory. As opposed to "inside this thing".
     * 
     * TODO: Write more of this function, checks etc
     * 
     * @param ent  entity to put into inventory
     * 
     * @return Bool whether or not it was moved into inventory. If it wasn't,
     *              most likely it's in the place it started.
     */
    public function add(ent:Entity):Bool
    {
        // eventual return
        var ret:Bool = true;

        // put item in inventory
        this.contents.push(ent);

        // return
        return ret;
    }

    /**
     * TODO: Fix docs
     * 
     * Ask actor to remove this item from its inventory. As opposed to its
     * insides. Caller is responsible for taking care of the item in question.
     * 
     * @param ent  entity to drop
     * 
     * @return Bool whether we actually managed to drop it
     */
    public function remove(ent:Entity):Bool
    {
        // one liner
        return this.contents.remove(ent);
    }

    /**
     * All this does is return a list of contents, actually THE list.
     */
    public function list():Array<Entity>
    {
        return this.contents;
    }

    public override function clone():EntityContainer
    {
        var ret:EntityContainer = new EntityContainer();

        // containableIn
        ret.containableIn = this.containableIn.clone();

        // containerFor
        ret.containerFor = this.containerFor.clone();

        // clone count
        this.cloneCount = this.cloneCount + 1;
        ret.cloneCount = this.cloneCount;

        // index
        ret.index = this.index;

        // isClone - we aren't but ret is
        ret.isClone = true;

        // name
        ret.name = this.name;

        // unique
        ret.isUnique = this.isUnique;

        // aliases
        ret.aliases = this.aliases.copy(); // that's a shallow copy!

        // return
        return ret;
    }
}