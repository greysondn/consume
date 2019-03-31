package net.darkglass.consume.substate;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISubState;
import flixel.addons.ui.FlxUIText;

import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.Registry;
import net.darkglass.consume.ui.Scrollbar;
import net.darkglass.consume.ui.WaTTY;

class CreditsSubstate extends FlxUISubState
{
    private var registry:Registry = Registry.create();

    override public function create():Void
    {
        // let parent do the thing
        super.create();

        // okay now we can just be unkind
        // if you're trying to make sense of this, look at OptionSubstate.hx
        var buttonEnabledGFX:Array<String>  = registry.gfxset_buttonEnabled;
        var slicecoords:Array<Array<Int>>   = registry.gfxset_buttonEnabled_slice;

        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(23, 23, registry.gfx_bgGeneral, new Rectangle(0, 0, 804, 594), registry.gfx_bgGeneral_slice);
        this.add(background);

        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);
        var titleTxt:FlxUIText = new FlxUIText(32, 32, 786, "Credits", 70); // we really want, like, 87 on non-static targets
        titleTxt.alignment = "center";
        titleTxt.addFormat(fntcol);
        this.add(titleTxt);

        var textframe:FlxUI9SliceSprite = new FlxUI9SliceSprite(56, 119, registry.gfx_bgGeneral, new Rectangle(0, 0, 706, 391), registry.gfx_bgGeneral_slice);
        this.add(textframe);

        var wat:WaTTY = new WaTTY(88, 151, 642);
        wat.setFormat("assets/fonts/hack.ttf", 16, 0x000000);
        wat.charWidth  = 66;
        wat.charHeight = 17;
        this.add(wat);

        var sb:Scrollbar = new Scrollbar(762, 119, 391);
        sb.minScroll = 183;
        sb.maxScroll = 414;
        this.add(sb);

        sb.onScroll        = wat.scrollToPercent;
        sb.scrollUpOne     = wat.scrollUpOne;
        sb.scrollDownOne   = wat.scrollDownOne;
        wat.onLengthChange = sb.updateScrollbarPosition;
        wat.onLineChange   = sb.updateScrollbarPosition;

        wat.addText("--------------------------------------------");
        wat.addText("HaxeFlixel Port Credits (v0.53 and later)");
        wat.addText("--------------------------------------------");
        wat.addText("");
        wat.addText("HaxeFlixel Engine Port");
        wat.addText("Greysondn");
        wat.addText("");
        wat.addText("Based Upon Original Work By");
        wat.addText("GenkoKitsu");
        wat.addText("");
        wat.addText("--------------------------------------------");
        wat.addText("Original Version Credits (v0.52 and earlier)");
        wat.addText("--------------------------------------------");
        wat.addText("");
        wat.addText("Original Game Code and Story");
        wat.addText("Kyra Sunseeker / GenkoKitsu");
        wat.addText("");
        wat.addText("Logo Design");
        wat.addText("Alcathair");
        wat.addText("");
        wat.addText("Guffin Character Design");
        wat.addText("Foxlets");
        wat.addText("");
        wat.addText("Ice Cream Shop Content");
        wat.addText("Foxlets");
        wat.addText("");
        wat.addText("Gym Anal Sex and Scat Scenes");
        wat.addText("Victor Styche");
        wat.addText("");
        wat.addText("Gym Female Oral Sex Scenes");
        wat.addText("BeardyKomodo");
        wat.addText("");
        wat.addText("Bug Fixes and Code Improvements for Original Engine");
        wat.addText("s-r-g-i < https://github.com/s-r-g-i >");
        wat.addText("");
        wat.addText("GenkoKitsu's Patreon Backers");
        wat.addText("Anthony Ahlfield");
        wat.addText("benjamin sanchez");
        wat.addText("Spencer Cochran");
        wat.addText("Wolf");
        wat.addText("Wolfhouse 520");
        wat.addText("");

        wat.scrollToLine(96);

        var backButton:FlxUIButton = new FlxUIButton(32, 566, "Back", onClick_back);
        backButton.loadGraphicSlice9(buttonEnabledGFX, 786, 42, slicecoords, 0, -1);
        this.add(backButton);
    }

    private function onClick_back():Void
    {
        this.close();
    }
}