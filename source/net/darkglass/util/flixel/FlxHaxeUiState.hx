package net.darkglass.util.flixel;

import flixel.FlxSubState;
import flixel.FlxState;
import net.darkglass.util.flixel.FlxHaxeUiRegistry;
import haxe.ui.Toolkit;


class FlxHaxeUiState extends FlxState
{
    /**
     * Whether or not we should be doing Haxeui things.
     * 
     * It's expected this will be checked manually.
     */
    public var doHxui:Bool;

    override public function create():Void
    {
        // parent
        super.create();

        // let hxui run
        this.doHxui = true;

        // make sure haxeui-flixel has been initialized
        var reg:FlxHaxeUiRegistry = FlxHaxeUiRegistry.create();

        if (!reg.initialized)
        {
            Toolkit.init({ container : this });
            reg.initialized = true;
        }

        // reimplement default behavior, which is to make this haxeui container
        Toolkit.screen.options = { container : this };
    }

    override function openSubState(SubState:FlxSubState)
    {
        // ask this to not update hxui
        this.doHxui = false;

        // and move along
        super.openSubState(SubState);
    }

    override function closeSubState() {
        // unpause haxeui
        this.doHxui = true;

        // and move along
        super.closeSubState();
    }
}