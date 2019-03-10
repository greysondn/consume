package net.darkglass.iguttae.gameworld.map;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.actor.ContainerType;

class Room extends Actor
{
    /**
     * Constructor.
     */
    public function new()
    {
        // let parent do its thing
        super();

        // and now
        this.addContainerFor(ContainerType.ROOM);
    }
}