package net.darkglass.consume.substate;

import flixel.addons.ui.FlxUISubState;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI9SliceSprite;

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
        var buttonNormalImg:String    = "assets/images/gui/classic/nineslice/window.png";
        var buttonHoverImg:String     = "assets/images/gui/classic/nineslice/window-hover.png";
        var buttonClickImg:String     = "assets/images/gui/classic/nineslice/window-click.png";
        var buttonDisabledImg:String  = "assets/images/gui/classic/nineslice/window-disabled.png";

        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(23, 23, buttonNormalImg, new Rectangle(0, 0, 804, 594), [1, 1, 2, 2]);
        this.add(background);
    }
}