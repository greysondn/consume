package net.darkglass.consume;

import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUISprite;

import net.darkglass.consume.Registry;

class TitleState extends FlxUIState
{
    override public function create():Void
    {
        // get this out of the way
        super.create();

        // handle to the registry please
        var registry:Registry = Registry.create();

        // now ui
        
        // background
        var titlebg:FlxUISprite = new FlxUISprite(0, 0);
        //                              AARRGGBB   For alpha, FF is opaque and 00 is transparent
        titlebg.makeGraphic(850, 640, 0xFFFFFFFF);
        this.add(titlebg);

        // Logo
        var logo:FlxUISprite = new FlxUISprite(190, 34, registry.logoMale);
        this.add(logo);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}