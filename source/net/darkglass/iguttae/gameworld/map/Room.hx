package net.darkglass.iguttae.gameworld.map;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;

class Room extends Actor
{
    /**
     * Constructor.
     */
    public function new()
    {
        // let parent do its thing
        super();

        // and now... it's a container for room stuff!
        this.addContainerFor(this.consts.get("container", "room"));
    }

    override public function describe(env:Environment)
    {
        var wrapper:String = "";

        for (whatever in 0...this.name.length)
        {
            wrapper = wrapper + "-";
        }

        env.outStream(wrapper + "\n" + this.name + "\n" + wrapper);
        super.describe(env);
    }
}