package net.darkglass.consume;

import openfl.Assets;
import flixel.addons.ui.FlxUIState;

import flixel.addons.ui.FlxUISprite;
import flixel.addons.ui.FlxUIText;
import flixel.FlxG;
import flixel.math.FlxRandom;


import net.darkglass.consume.Registry;

import yaml.Yaml;

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
        // ----------
        var titlebg:FlxUISprite = new FlxUISprite(0, 0);
        //                              AARRGGBB   For alpha, FF is opaque and 00 is transparent
        titlebg.makeGraphic(850, 640, 0xFFFFFFFF);
        this.add(titlebg);

        // Logo
        // ----
        var logo:FlxUISprite = new FlxUISprite(190, 34, registry.logoMale);
        this.add(logo);

        // version
        // pos 489x42
        
        // creators
        // pos 190x293
        // sz  469x25

        // quote
        // pos 190x318
        // sz  469x36
        // -----
        // ... this is a bit of a doozy
        // load quotes
        // TODO: Make this capable of loading other locales
        var _yamlFile:String = Assets.getText("assets/data/strings/en-US/welcome_messages.yaml");
        var msgs:Array<String> = Yaml.parse(_yamlFile);
        var rng:FlxRandom = new FlxRandom();
        var rngRoll:Int = rng.int(0, (msgs.length - 1));
        var quoteStr:String = msgs[rngRoll];
        
        // menu space
        // pos 190x354
        // sz  469 x 252
        // -------------
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}