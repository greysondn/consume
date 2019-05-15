package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.actor.Actor;

/**
 * Characters should be derived from this class, or members of this class.
 * 
 * This just sets sane defaults for everything.
 */
class Character extends Actor
{
    public function new()
    {
        // let parent do its thing
        super();

        // characters are containable in rooms
        this.containableIn.add(this.consts.get("container", "room"));

        // characters are containable in stomachs
        this.containableIn.add(this.consts.get("container", "stomach"));

        // characters can hold things in inventories, whee!
        this.inventory.containerFor.add(this.consts.get("container", "inventory"));
    }
}
