package net.darkglass.iguttae.gameworld.character;

/**
 * Acts as a main per-character pub/sub hub for signalling.
 * 
 * Actually makes things easier, despite how complicated they are,
 */
class CharacterPubsubhub
{
    // known signals to implement:
    // onMoveBlock    --> when the character's movement is blocked
    // onAttacked     --> when the character is attacked
    // onChangeEdible --> when the character's edibility changes
    // onChangeFat    --> when the character's fat changes
    // onChangeGender --> when the character's gender changes
    // onFatBurn      --> when the character does something to burn fat
    // onDigest       --> when the character digests something
    // onItemDraw     --> when the character trigers an item draw

    /**
     * Map of listeners in this array. Yep.
     */
    public var listeners:Map<String, Map<String, ()->String>> = [];

    public function new()
    {
        // pass?
    }

    public function addListener(signal:String, id:String, listener:()->String):Void
    {
        // well, first, does it exist?
        if (!this.listeners.exists(signal))
        {
            // then create it, empty
            this.listeners.set(signal, []);
        }

        // alright, now register that listener
        this.listeners[signal].set(id, listener);
    }

    public function removeListener(id:String):Void
    {
        // just remove it from all points
        for (key in this.listeners.keys())
        {
            this.listeners[key].remove(id);
        }
    }

    public function broadcast(signal:String):String
    {
        // yes, it needs to start with one character
        var ret:String = "|";

        // fire off the signal if it has any listeners
        if (!this.listeners.exists(signal))
        {
            for (listener in this.listeners[signal])
            {
                // run it, should be a function
                ret = ret + listener() + "|";
            }
        }

        // yeah, this is why it starts at 1 character.
        ret = ret.substring(1, -1);

        // return it anyway
        return ret;
    }
}