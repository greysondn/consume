package net.darkglass.iguttae.gameworld.item;

import net.darkglass.iguttae.gameworld.actor.Actor;

class Item extends Actor
{
    public function new()
    {
        // let parent do the thing
        super();

        // items are containable in rooms
        this.containableIn.add(this.consts.get("container", "room"));

        // items are containable in stomachs
        this.containableIn.add(this.consts.get("container", "stomach"));

        // items are containable in inventories
        this.containableIn.add(this.consts.get("container", "inventory"));
    }
}