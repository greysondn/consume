package net.darkglass.consume.substate;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISubState;
import flixel.addons.ui.FlxUIText;

import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.Registry;
import net.darkglass.consume.ui.WaTTY;

class PreWarnSubstate extends FlxUISubState
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
        var titleTxt:FlxUIText = new FlxUIText(32, 32, 786, "WARNING", 87);
        titleTxt.alignment = "center";
        titleTxt.addFormat(fntcol);
        this.add(titleTxt);

        var wat:WaTTY = new WaTTY(56, 119, 738);
        wat.setFormat("assets/fonts/hack.ttf", 16, 0x000000);
        wat.charWidth  = 76;
        wat.charHeight = 20;
        this.add(wat);

        var closeButton:FlxUIButton = new FlxUIButton(32, 566, "Okay, okay", onClick_close);
        closeButton.loadGraphicSlice9(buttonEnabledGFX, 786, 42, slicecoords, 0, -1);
        this.add(closeButton);

        wat.addText("The flash you're looking at is not a playable game. It is a preview of progress on an engine overhaul for Consume.");
        wat.addText("");
        wat.addText("If you want the playable game, try version 0.52, or come back for version 0.54. I don't want to hear complaints on the topic. I'm working on it.");
        wat.addText("");
        wat.addText("I want to let people see, in a tangible way, where progress for the code is.");
        wat.addText("");
        wat.addText("Please read the description thoroughly if you have a bug to report or want to get in touch with us.");
        wat.addText("");
        wat.addText("Greysondn, 31 March 2019");
        wat.addText("");
    }

    private function onClick_close():Void
    {
        this.close();
    }
}