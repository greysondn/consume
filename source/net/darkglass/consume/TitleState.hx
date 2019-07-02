package net.darkglass.consume;

import openfl.Assets;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.PlayState;
import net.darkglass.consume.Registry;

import net.darkglass.consume.substate.CreditsSubstate;
import net.darkglass.consume.substate.FAQSubstate;
import net.darkglass.consume.substate.OptionSubstate;
import net.darkglass.consume.substate.PreWarnSubstate;

import yaml.Yaml;

// new version pieces
import net.darkglass.util.flixel.FlxHaxeUiState;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import haxe.ui.Toolkit;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.components.Button;
import haxe.ui.events.UIEvent;

class TitleState extends FlxHaxeUiState
{
    public var uiGroup:FlxGroup;

    override public function create():Void
    {
        // parent
        super.create();

        // handle to the registry please
        var registry:Registry = Registry.create();

        // new ui stuffs
        this.uiGroup = new FlxGroup();

        var bg:FlxSprite = new FlxSprite(0, 0, "assets/images/gui/classic/bg/title_faked.png");
        this.add(bg);

        // init ui loader
        Toolkit.screen.options = { container : this.uiGroup };
        this.add(this.uiGroup);
        var _ui = ComponentMacros.buildComponent("assets/ui/titlestate.xml");
        uiGroup.add(_ui);

        // wire up the buttons
        var newBut:Button = _ui.findComponent("new", Button);
        newBut.onClick = this.onClick_new;

        // load would go here

        var option:Button = _ui.findComponent("options", Button);
        option.onClick = this.onClick_options;

        var faq:Button =  _ui.findComponent("faq", Button);
        faq.onClick = this.onClick_faq;

        var credits:Button = _ui.findComponent("credits", Button);
        credits.onClick = this.onClick_credits;

        // old ui stuffs we're still doing

        // paint it black
        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);

        // Logo
        // ----
        var logo:FlxSprite = new FlxSprite(190, 34, registry.logo);
        this.add(logo);

        // version
        // pos 489x42
        // sz 162x97
        var verText:FlxText = new FlxText(551, 227, 162, registry.release);
        verText.alignment = "center";
        verText.addFormat(fntcol);
        this.add(verText);

        // creators
        // pos 190x293
        // sz  469x25
        var creatorStr:String = "By copb_phoenix. Based upon an original work by GenkoKitsu.";
        var titleCreate:FlxText = new FlxText(190, 305, 469, creatorStr);
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

        // get random quotes
        // there were some for random dates that we didn't add in yet, I'll have
        // to redesign the file to do that.
        //
        // TODO: redesign the file to do that.
        //
        // Jan 01 - New Year's - "Happy New Year!"
        // Aug 08 - Kyra's BD  - "Happy Birthday Kyra!"
        // Oct 31 - Halloween  - "Happy Halloween!"
        // Nov 25 - Greyson BD - "Happy Birthday greysondn!"
        // Dec 25 - Christmas  - "Merry Christmas!"
        var rngRoll:Int = rng.int(0, (msgs.length - 1));
        var quoteStr:String = msgs[rngRoll];

        var titleQuote:FlxText = new FlxText(190, 318, 469, quoteStr);
        titleQuote.alignment = "center";
        titleQuote.addFormat(fntcol);
        this.add(titleQuote);

        // warning!
        var prewarnSubstate:PreWarnSubstate = new PreWarnSubstate(0x80000000);
        openSubState(prewarnSubstate);
    }

    // new game
    // load
    // options
    // faq
    // credits

    public function onClick_new(ignored:UIEvent):Void
    {
        if (this.doHxui)
        {
            FlxG.switchState(new PlayState());
        }
    }

    public function onClick_options(ignored:UIEvent):Void
    {
        if (this.doHxui)
        {
            var optionSubstate:OptionSubstate = new OptionSubstate(0x80000000);
            openSubState(optionSubstate);
        }
    }

    public function onClick_faq(ignored:UIEvent):Void
    {
        if (this.doHxui)
        {
            var faqSubstate:FAQSubstate = new FAQSubstate(0x80000000);
            openSubState(faqSubstate);
        }
    }

    public function onClick_credits(ignored:UIEvent):Void
    {
        if (this.doHxui && (this.subState == null))
        {
            var creditsSubstate:CreditsSubstate = new CreditsSubstate(0x80000000);
            openSubState(creditsSubstate);
        }
    }
}