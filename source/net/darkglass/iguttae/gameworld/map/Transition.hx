package net.darkglass.iguttae.gameworld.map;

import net.darkglass.iguttae.gameworld.actor.Actor;

/**
 * A lot of people would probably call that a doorway, to be honest.
 */
class Transition extends Actor
{
    /**
     * Where this Transition takes us to
     */
    public var target:Actor;

    /**
     * How long this Transition takes us, in minutes
     */
    public var travelTime:Int;

    /**
     * Whether or not this is locked
     */
    public var locked:Bool;

    /**
     * the combination for this thing's lock
     */
    public var combo:Int;

    /**
     * Test a key in this lock
     * 
     * @param code  code the key corrosponds to
     * 
     * @return Bool whether or not the key works
     */
    public function keyWorks(code:Int):Bool
    {
        // whether that matches even
        var ret:Bool = false;

        // try it
        if (code == this.combo)
        {
            // it's a match!
            ret = true;
        }

        // return
        return ret;
    }

    /**
     * Turn a key in this lock
     * 
     * @param code  key's code
     * @return Bool whether we swapped the state
     */
    public function turnKey(code:Int):Bool
    {
        var ret:Bool = this.keyWorks(code);
        
        if (ret)
        {
            this.locked = !this.locked;
        }
        
        return ret;
    }
}