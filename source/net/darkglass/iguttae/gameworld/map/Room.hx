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

        // if we ever get scrollback working, or log, this needs changed
        // env.outStream(wrapper + "\n" + this.name + "\n" + wrapper);
        super.describe(env);
        


        // items
        this.printItems(env);

        // exits
        env.outStream(this.getExitList(env));
    }

    public function printItems(env:Environment):Void
    {
        var invOut:String = "You see ";

        if (this.contents.length > 1)
        {
            for (i in 0...(this.contents.length - 1))
            {
                invOut = invOut + this.contents[i].name + ", ";
            }

            invOut = invOut + "and " + this.contents[this.contents.length - 1] + ".";
        }
        else if (this.contents.length == 1)
        {
            invOut = invOut + this.contents[0] + ".";
        }
        else
        {
            invOut = invOut + "no items here.";
        }

        env.outStream(invOut);
    }
}