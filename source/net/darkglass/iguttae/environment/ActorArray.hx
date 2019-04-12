package net.darkglass.iguttae.environment;

import net.darkglass.iguttae.gameworld.actor.Actor;

class ActorArray
{
    // just an array of actors, really
    private var store:Array<Actor> = [];

    /**
     * Metalist of actors to work against when working
     */
    public var metaList:ActorArray;

    public function new()
    {
        // who cares?
    }

    // let's write a few functions, shall we? By which I mostly mean migrate
    // them here.

    /**
     * Add an actor to this array
     * 
     * @param actor actor to add
     */
    public function add(actor:Actor)
    {
        if (-1 == this.store.indexOf(actor))
        {
            this.store.push(actor);

            if (this.metaList != null)
            {
                this.metaList.add(actor);
            }
        }
    }

     /**
     * Remove an actor from this array
     * 
     * @param actor actor to remove
     */
    public function remove(actor:Actor):Void
    {
        this.store.remove(actor);

        if (this.metaList != null)
        {
            this.metaList.remove(actor);
        }
    }
    
    public function checkIntegrity():Bool
    {
        // sort self first
        this.sort();

        // return. true if integrity exists fine
        var ret = true;

        for (i in 0...this.store.length)
        {
            if (this.store[i].index != i)
            {
                ret = false;
            }
        }

        return ret;
    }

    public function sort():Void
    {
        this.store.sort(Actor.cmpIndex);
    }

    public function get(index:Int):Actor
    {
        return this.store[index];
    }
}