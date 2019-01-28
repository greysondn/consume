package net.darkglass.consume;

import openfl.Assets;
import flixel.addons.ui.FlxUIState;

import flixel.addons.ui.FlxUISprite;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.Registry;

import net.darkglass.consume.substate.OptionSubstate;

import yaml.Yaml;

class TitleState extends FlxUIState
{
    override public function create():Void
    {
        // paint it black
        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);

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
        // sz 162x97
        
        // creators
        // pos 190x293
        // sz  469x25
        var creatorStr = "By copb_phoenix. Based upon an original work by GenkoKitsu.";
        
        var titleCreate:FlxUIText = new FlxUIText(190, 305, 469, creatorStr);
        titleCreate.alignment = "center";
        titleCreate.addFormat(fntcol);
        this.add(titleCreate);

        // quote
        // pos 190x318
        // sz  469x36
        // -----
        // ... this is a bit of a doozy
        // load quotes
        // TODO: Make this capable of loading other locales
        var _yamlFile:String = Assets.getText("assets/data/en-us/welcome_messages.yaml");
        var msgs:Array<String> = Yaml.parse(_yamlFile);
        var rng:FlxRandom = new FlxRandom();
        var rngRoll:Int = rng.int(0, (msgs.length - 1));
        var quoteStr:String = msgs[rngRoll];

        var titleQuote:FlxUIText = new FlxUIText(190, 318, 469, quoteStr);
        titleQuote.alignment = "center";
        titleQuote.addFormat(fntcol);
        this.add(titleQuote);
        
        // menu space
        // pos 190x356
        // sz  469 x 250
        // height each: 42
        // space between: 10
        // New, Load, Options, Faq, Credits
        // --------------------------------
        var buttonNormalImg:String    = "assets/images/gui/classic/nineslice/window.png";
        var buttonHoverImg:String     = "assets/images/gui/classic/nineslice/window-hover.png";
        var buttonClickImg:String     = "assets/images/gui/classic/nineslice/window-click.png";
        var buttonDisabledImg:String  = "assets/images/gui/classic/nineslice/window-disabled.png";

        var buttonEnabledGFX:Array<String>  = [buttonNormalImg, buttonHoverImg, buttonClickImg];
        var buttonDisabledGFX:Array<String> = [buttonDisabledImg, buttonDisabledImg, buttonDisabledImg];

        var slicecoords:Array<Array<Int>> = [[1, 1, 2, 2], [1, 1, 2, 2], [1, 1, 2, 2]];

        var newButton:FlxUIButton = new FlxUIButton(190, 356, "New Game");
        newButton.loadGraphicSlice9(buttonDisabledGFX, 469, 42, slicecoords, false, -1);
        this.add(newButton);

        var loadButton:FlxUIButton = new FlxUIButton(190, 408, "Load");
        loadButton.loadGraphicSlice9(buttonDisabledGFX, 469, 42, slicecoords, false, -1);
        this.add(loadButton);

        var optionsButton:FlxUIButton = new FlxUIButton(190, 460, "Options", onClick_options);
        optionsButton.loadGraphicSlice9(buttonEnabledGFX, 469, 42, slicecoords, false, -1);
        this.add(optionsButton);

        var faqButton:FlxUIButton = new FlxUIButton(190, 512, "FAQ");
        faqButton.loadGraphicSlice9(buttonDisabledGFX, 469, 42, slicecoords, false, -1);
        this.add(faqButton);

        var creditsButton:FlxUIButton = new FlxUIButton(190, 564, "Credits");
        creditsButton.loadGraphicSlice9(buttonDisabledGFX, 469, 42, slicecoords, false, -1);
        this.add(creditsButton);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function onClick_options():Void
    {
        var optionSubstate:OptionSubstate = new OptionSubstate(0x80000000);
		openSubState(optionSubstate);
    }
}