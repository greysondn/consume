package net.darkglass.util.flixel;

import flixel.FlxState;
import net.darkglass.util.flixel.FlxHaxeUiRegistry;
import haxe.ui.Toolkit;


class FlxHaxeUiState extends FlxState
{
    override public function create():Void
    {
        // parent
        super.create();

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
}