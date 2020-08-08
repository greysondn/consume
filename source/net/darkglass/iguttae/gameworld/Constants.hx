package net.darkglass.iguttae.gameworld;

/**
 * Singleton class of constants for actors
 */
class Constants 
{
    /**
     * The only instance of this class
     */
    private static var instance:Constants = new Constants();

    /**
     * Valid strings to use as prefixes to constants
     * 
     * TODO: Externalize this to a file.
     */
    private var prefixes:Array<String> = [
        "container",
        "flag",
        "permission",
        "slot"
    ];

    /**
     * List of actual constants
     * 
     * TODO: Externalize this to a file.
     */
    private var keyList:Array<String> = [
        // ----------
        // containers
        // ----------
        //
        // whether this is a room/able to be contained in a room
        "container.room",
        // whether this is a stomach/able to be contained in a stomach
        "container.stomach",
        // whether this is storage/able to be contained in storage
        "container.storage",
        // whether this has an inventory/is able to be contained in an inventory
        "container.inventory",
        // -----
        // flags
        // -----
        //
        // whether an actor is edible
        "flag.edible",
        // whether this area is public
        "flag.public",
        // whether a passage is hidden
        "flag.hidden",
        // whether something is locked
        "flag.locked",
        // whether something operates on a timer
        "flag.timer",
        // -----------
        // permissions
        // -----------
        //
        // whether or not an actor can wait and if waiting is allowed here
        "permission.wait",
        // -----
        // slots
        // -----
        // Either this means that such equipment slots exist
        // OR
        // that such a thing can be equipped in an equipment slot
        // OR
        // that this entry represents the given equipment slot.

        // the left ring finger - or the only ring slot
        // if you're playing classic.
        "slot.ringLeftRing",

        // a one handed weapon - or the only weapon slot
        // if you're playing classic.
        "slot.weapon.onehanded",

        // the torso armor - or the only armor slot
        // if you're playing classic.
        "slot.armor.torso"
    ];

    /**
     * dummy constructor to make it private
     */
    private function new()
    {
        // pass
    }

    /**
     * Call this to ostensibly create a new Constants
     * 
     * @return Constants ostensibly new Constants
     */
    public static function create():Constants
    {
        return Constants.instance;
    }

    /**
     * Gives some consistent value that can be used for the key with prefix
     * 
     * For now these are ints. Later on I might get more clever with them
     * 
     * @param prefix   prefix for key
     * @param key      key itself
     * @return Int     a stable value for prefix.key
     */
    public function get(prefix:String, key:String):Int
    {
        // the impossible value returns!
        var ret:Int = -1;

        if (this.exists(prefix, key))
        {
            ret = this.keyList.indexOf(prefix + "." + key);
        }
        else
        {
            // yeah, that qualifies as a major error
            throw ("Invalid constant key asked for! : "  + prefix + "." + key); 
        }

        return ret;
    }

    /**
     * Checks whether this prefix and key even exists
     * 
     * @param prefix    prefix for key
     * @param key       key itself
     * @return Bool     whether it even exists
     */
    public function exists(prefix:String, key:String):Bool
    {
        // eventual return
        var ret:Bool = true;

        // make sure the prefix is valid first
        if (this.prefixes.indexOf(prefix) == -1)
        {
            ret = false;
        }
        else
        {
            if (this.keyList.indexOf(prefix + "." + key) == -1)
            {
                ret = false;
            }
        }

        return ret;
    }

    /**
     * Convert int to key string (future proofed storage)
     * 
     * @param incoming int for const
     */
    public function intToKey(incoming:Int)
    {
        return this.keyList[incoming];
    }

    /**
     * Converts key string to int (future proofed storage)
     * 
     * @param incoming key string for const
     */
    public function keyToInt(incoming:String)
    {
        return this.keyList.indexOf(incoming);
    }
}