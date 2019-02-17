package net.darkglass.consume;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;

import haxe.ui.Toolkit;
import haxe.ui.*;

import net.darkglass.consume.Registry;

class PlayState extends FlxState
{
    private var registry:Registry = Registry.create();

    private var uiGroup:FlxGroup = new FlxGroup();

    override public function create():Void
    {
        // let parent do its thing
        super.create();

        // mimics substates on title screen in classic
        this.bgColor = 0xFF7F7F7F;

        // build a ui, plox
        this.buildUI();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    /**
     * Helper function for the constructor to build out the UI for us.
     */
    private function buildUI():Void
    {
        // init ui
        Toolkit.init({ container : uiGroup });
        this.add(this.uiGroup);

        // now actually assemble the ui

        /**
        // background
        var bg_main:FlxUI9SliceSprite = new FlxUI9SliceSprite(9, 16, registry.gfx_bgGeneral, new Rectangle(0, 0, 832, 608), registry.gfx_bgGeneral_slice, 0, false);
        this.add(bg_main);

        // Title space
        // TODO: Text with area name
        // TODO: Text with date and time
        var bg_top:FlxUI9SliceSprite = new FlxUI9SliceSprite(9, 16, registry.gfx_bgTopBar, new Rectangle(0, 0, 832, 56), registry.gfx_bgTopBar_slice, 0, false);
        this.add(bg_top);

        // text area
        // TODO: Add WaTTY
        var bg_text:FlxUI9SliceSprite = new FlxUI9SliceSprite(9, 72, registry.gfx_bgTextArea, new Rectangle(0, 0, 800, 368), registry.gfx_bgTextArea_slice, 0, false);
        this.add(bg_text);
        */
    }
    
}
