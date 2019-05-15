package net.darkglass.iguttae.gameworld;

/**
 * Base class for all world entities in Iguttae
 */
class Entity
{
    /**
     * The types of containers this is containable in.
     */
    public var containableIn:ConstantList = new ConstantList();

    /**
     * Access point for constants
     */
    public var consts:Constants = Constants.create();

    /**
     * Aliases for this object - as in things it answers to
     */
    private var aliases:Array<String> = [];

    /**
     * Whether this is unique or not. Mostly matters for items, honestly.
     */
    public var isUnique:Bool = false;

    /**
     * Index, for indexed actors. This is considered undefined for arbitrary
     * actors, but some - like rooms and transitions - are actually indexed.
     */
    public var index:Int;

    /**
     * Whether or not this is the player
     */
    public var isPlayer:Bool = false;

    /**
     * Spawn count. Again, mostly matters for items.
     */
    public var cloneCount:Int = 0;

    /**
     * Whether this is a clone or not. Don't clone clones brah.
     */
    public var isClone:Bool = false;

    /**
     * Name of this actor
     */
    public var name:String = "ERROR: NO NAME";

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

    public function new()
    {
        // surprise! half of nothing!
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
     * @return Actor a clone of this entity
     */
    public function clone():Entity
    {
        var ret:Entity = new Entity();

        // containableIn
        ret.containableIn = this.containableIn.clone();

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

    /**
     * TODO: Fix docs
     * 
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
    public static function cmpIndex(left:Entity, right:Entity):Int
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
}