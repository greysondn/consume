package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.actor.ContainerType;

class Character extends Actor
{
    public function new()
    {
        // let parent do its thing
        super();

        // characters are containable in rooms
        this.addContainableIn(ContainerType.ROOM);
    }
}
