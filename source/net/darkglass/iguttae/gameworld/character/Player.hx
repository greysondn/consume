package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.character.Character;

class Player extends Character
{
    public function new()
    {
        // let parent do its thing
        super();

        // we're a player
        this.isPlayer = true;
    }
}