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
        var _ui = ComponentMacros.buildComponent("assets/ui/playstate.xml");
        uiGroup.add(_ui);

        var cout:Label = _ui.findComponent("cout", Label);
        cout.width = 770;
    }
}
