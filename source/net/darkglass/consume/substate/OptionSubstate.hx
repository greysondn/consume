package net.darkglass.consume.substate;

import flixel.addons.ui.FlxUISubState;

class OptionSubstate extends FlxUISubState
{
    override public function create():Void 
    {
        // buttons needed:
        //
        // title screen
        // ------------
        // Scat
        // Arousal
        // Debug
        // Font Size+
        // Font Size-
        // Difficulty +
        // Difficulty -
        // NPC Gender
        //
        // ingame
        // -----------------
        // back to Main Menu
        // Save
        super.create();

        // why don't we organize these options? ... But
        // first! ... We'll need to build a window proper
        // for them. So that's my first task, I suppose.

    }
}