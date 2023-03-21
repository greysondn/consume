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
     * Opposite side of this door. Doesn't necessarily have to exist. Will be
     * locked/unlocked/etc if it does exist.
     */
    public var oppositeSide:Transition;

    /**
     * TODO: Document
     *  
     * @param codes 
     * @return Bool
     */
    public function anyCodeWorks(codes:Array<Int>):Bool
    {
        var ret:Bool = false;

        for (code in codes)
        {
            if (this.codeWorks(code))
            {
                ret = true;
            }
        }

        return ret;
    }

    /**
     * Test a code in this lock
     * 
     * @param code  code to check
     * 
     * @return Bool whether or not the code works
     */
    public function codeWorks(code:Int):Bool
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
     * Check whether a key works in this door at all
     * 
     * @param key       key to check
     * @return Bool     whether or not it works
     */
    public function keyWorks(key:Actor):Bool
    {
        return this.anyCodeWorks(key.combos);
    }

    public function getWorkingCode(codes:Array<Int>):Int
    {
        var ret:Int = -1;

        for (code in codes)
        {
            if (this.codeWorks(code))
            {
                ret = code;
            }
        }

        return ret;
    }

    /**
     * Turn a key in this lock
     * 
     * @param key  key to turn
     * @return Bool whether the key turned in the lock
     */
    public function turnKey(key:Actor):Bool
    {
        var ret:Bool = this.keyWorks(key);
        
        // we can skip the formalities, after all
        if (ret)
        {
            this.locked = !this.locked;

            if (null != this.oppositeSide)
            {
                this.oppositeSide.locked = !this.oppositeSide.locked;
            }
        }
        
        return ret;
    }

    /**
     * TODO
     * @param key 
     * @return Bool whether the key turned in the lock
     */
    public function unlockWithKey(key:Actor):Bool
    {
        var ret:Bool = false;

        if (this.keyWorks(key))
        {
            this.locked = false;
            ret = true;

            if (null != this.oppositeSide)
            {
                this.oppositeSide.locked = false;
            }
        }

        return ret;
    }

    public function lockWithKey(key:Actor):Bool
    {
        var ret:Bool = false;

        if (this.keyWorks(key))
        {
            this.locked = true;
            ret = true;

            if (null != this.oppositeSide)
            {
                this.oppositeSide.locked = true;
            }
        }

        return ret;
    }
}