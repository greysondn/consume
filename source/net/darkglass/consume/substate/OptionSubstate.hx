package net.darkglass.consume.substate;

import flixel.addons.ui.FlxUISubState;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.text.FlxText.FlxTextFormat;

class OptionSubstate extends FlxUISubState
{
    override public function create():Void 
    {
        // buttons needed:
        //
        // title screen
        // ------------
        // Scat
        // Arousal
        // Debug
        // Font Size+
        // Font Size-
        // Difficulty +
        // Difficulty -
        // NPC Gender
        //
        // ingame
        // -----------------
        // back to Main Menu
        // Save
        super.create();

        // why don't we organize these options? ... But
        // first! ... We'll need to build a window proper
        // for them. So that's my first task, I suppose.
        var buttonNormalImg:String    = "assets/images/gui/classic/nineslice/window.png";
        var buttonHoverImg:String     = "assets/images/gui/classic/nineslice/window-hover.png";
        var buttonClickImg:String     = "assets/images/gui/classic/nineslice/window-click.png";
        var buttonDisabledImg:String  = "assets/images/gui/classic/nineslice/window-disabled.png";

        var buttonEnabledGFX:Array<String>  = [buttonNormalImg, buttonHoverImg, buttonClickImg];
        var buttonDisabledGFX:Array<String> = [buttonDisabledImg, buttonDisabledImg, buttonDisabledImg];
        var slicecoords:Array<Array<Int>> = [[1, 1, 2, 2], [1, 1, 2, 2], [1, 1, 2, 2]];

        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(23, 23, buttonNormalImg, new Rectangle(0, 0, 804, 594), [1, 1, 2, 2]);
        this.add(background);

        // clickable button that doesn't suck too hard to close it?
        var backButton:FlxUIButton = new FlxUIButton(32, 566, "Back", onClick_back);
        backButton.loadGraphicSlice9(buttonEnabledGFX, 786, 42, slicecoords, false, -1);
        this.add(backButton);

        // title
        // loc  32x32
        // size 786x87
        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);
        var titleTxt:FlxUIText = new FlxUIText(32, 32, 786, "Options", 87);
        titleTxt.alignment = "center";
        titleTxt.addFormat(fntcol);
        this.add(titleTxt);

        // basic tab menu (holy crap!)
        var tabs:Array<{name:String, label:String}> =   [
                                            { name:"tab_1", label:"Game"},
                                            { name:"tab_2", label:"Contents"},
                                            { name:"tab_3", label:"Display"},
                                            { name:"tab_4", label:"Debug"}
                                                        ];

        var tabMenu = new FlxUITabMenu(null, tabs, true);
        tabMenu.x = 32;
        tabMenu.y = 127;
        tabMenu.resize(786, 431);
        
        // about tab contents
        // pos 40x154
        // siz 770x396

        // game tab contents
        var tabGroupGame:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupGame.name = "tab_1";

        tabMenu.addGroup(tabGroupGame);

        // contents tab contents
        var tabGroupContents:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupContents.name = "tab_2";

        tabMenu.addGroup(tabGroupContents);

        // display tab contents
        var tabGroupDisplay:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupDisplay.name = "tab_3";

        tabMenu.addGroup(tabGroupDisplay);

        // debug tab contents
        var tabGroupDebug:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupDebug.name = "tab_4";

        tabMenu.addGroup(tabGroupDebug);

        // remember when we started the tab menu? Now we can add it to the state.
		this.add(tabMenu);
    }

    public function onClick_back():Void
    {
        this.close();
    }
}