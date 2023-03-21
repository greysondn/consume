package net.darkglass.iguttae.gameworld.map;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;

// note from old code
//  /* Special button flags, each button can have one of the following flags on it
//   * 0 - Nothing
//   * 1 - Hunt, passive/active (Allows the player to hunt for prey. passive/active = club/park probably)
//   * 2 - Shop, [shop invintory]
//   * 3 - Talk, NPC (Chat with an NPC, should be an ID from roomNPCs. Eating NPCs will be handled here now)
//   * 4 - Work, Time (Player works for time)
//   * 5 - Toilet
//   * 6 - Sleep
//   */

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
        this.inventory.containerFor.add(this.consts.get("container", "room"));
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

        var tmpOut:Array<String> = [];

        // TODO: MAKE THIS NOT SUCK SO HARD
        for (i in 0...this.inventory.list().length)
        {
            if (!this.inventory.list()[i].isPlayer)
            {
                tmpOut.push(this.inventory.list()[i].name);
            }
        }

        if (tmpOut.length > 1)
        {
            for (i in 0...(tmpOut.length - 1))
            {
                invOut = invOut + tmpOut[i] + ", ";
            }

            invOut = invOut + "and " + tmpOut[tmpOut.length - 1] + ".";
        }
        else if (tmpOut.length == 1)
        {
            invOut = invOut + tmpOut[0] + ".";
        }
        else
        {
            invOut = invOut + "no items here.";
        }

        env.outStream(invOut);
    }
}