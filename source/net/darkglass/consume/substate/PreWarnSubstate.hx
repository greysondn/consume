package net.darkglass.consume.substate;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISubState;
import flixel.addons.ui.FlxUIText;

import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.ui.WaTTY;

class PreWarnSubstate extends FlxUISubState
{
    override public function create():Void
    {
        // let parent do the thing
        super.create();

        // okay now we can just be unkind
        // if you're trying to make sense of this, look at OptionSubstate.hx
        var buttonNormalImg:String    = "assets/images/gui/classic/nineslice/window.png";
        var buttonHoverImg:String     = "assets/images/gui/classic/nineslice/window-hover.png";
        var buttonClickImg:String     = "assets/images/gui/classic/nineslice/window-click.png";

        var buttonEnabledGFX:Array<String>  = [buttonNormalImg, buttonHoverImg, buttonClickImg];
        var slicecoords:Array<Array<Int>> = [[1, 1, 2, 2], [1, 1, 2, 2], [1, 1, 2, 2]];

        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(23, 23, buttonNormalImg, new Rectangle(0, 0, 804, 594), [1, 1, 2, 2]);
        this.add(background);

        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);
        var titleTxt:FlxUIText = new FlxUIText(32, 32, 786, "WARNING", 87);
        titleTxt.alignment = "center";
        titleTxt.addFormat(fntcol);
        this.add(titleTxt);

        var wat:WaTTY = new WaTTY(32, 119, 738);
        wat.setFormat("assets/fonts/hack.ttf", 16, 0x000000);
        wat.charWidth  = 76;
        wat.charHeight = 20;
        this.add(wat);

        var closeButton:FlxUIButton = new FlxUIButton(32, 566, "Okay, okay", onClick_close);
        closeButton.loadGraphicSlice9(buttonEnabledGFX, 786, 42, slicecoords, false, -1);
        this.add(closeButton);

        wat.addText("The flash you're looking at is not a playable game. It is a preview of progress on an engine overhaul for Consume.");
        wat.addText("");
        wat.addText("If you want the playable game, try version 0.52, or come back for version 0.54. I don't want to hear complaints on the topic. I'm working on it.");
        wat.addText("");
        wat.addText("I want to let people see, in a tangible way, where progress for the code is.");
        wat.addText("");
        wat.addText("Right now, options work without crashing the game and are persistent, but nothing saves longer term. Scrollboxes - which didn't exist in HaxeFlixel and had to be assembled from parts - seem to be working properly enough. Buttons work and are disabled if they should be disabled. The tabbed menu interface works - I'd say works well, even.");
        wat.addText("");
        wat.addText("I am not taking requests or contributions at this time, in any form. Please wait until I'm ready for them. I will announce it. Promise.");
        wat.addText("");
        wat.addText("Greysondn, 7 February 2019");
        wat.addText("");
    }

    private function onClick_close():Void
    {
        this.close();
    }
}