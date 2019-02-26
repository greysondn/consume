package net.darkglass.consume;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;

import haxe.ui.Toolkit;
import haxe.ui.components.Label;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.core.Screen;

import net.darkglass.consume.Registry;

class PlayState extends FlxState
{
    private var registry:Registry = Registry.create();

    private var uiGroup:FlxGroup = new FlxGroup();

    override public function create():Void
    {
        // let parent do its thing
        super.create();

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
        // init ui bg elements
        var bg:FlxSprite = new FlxSprite(0, 0, "assets/ui/css/classic/state-bg-faked.png");
        this.add(bg);

        // init ui loader
        Toolkit.init({ container : uiGroup });
        this.add(this.uiGroup);
        var _usi = ComponentMacros.buildComponent("assets/ui/playstate.xml");
        uiGroup.add(_usi);

        // var cout:Label = _ui.findComponent("cout", Label);
        // cout.style.fontName = "Hack";
        // _ui.findComponent("someButton", Button).onClick = this.testButton;

        /*
        // dd Title space
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
