package net.darkglass.consume.substate;

import flixel.addons.ui.FlxUISubState;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;

import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.Registry;

class OptionSubstate extends FlxUISubState
{
    private var registry:Registry = Registry.create();

    override public function create():Void 
    {
        // comment was NSFW, scrubbed
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
        // -----------------
        var tabGroupGame:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupGame.name = "tab_1";

        // difficulty title
        var difficultyTitleTxt:FlxUIText = new FlxUIText(8, 8, 770, "Difficulty", 32);
        difficultyTitleTxt.alignment = "left";
        tabGroupGame.add(difficultyTitleTxt);

        // difficulty options radio group
        var difficultyIDs:Array<String>   = ["diff_easy", "diff_normal", "diff_hard"];
        var difficultyLabels:Array<String> = ["Easy", "Normal", "Hard"];
        

        var difficultyDescriptionText:String = "Meant to adjust the difficulty of combat\n" +
                                               "\n" +
                                               "I don't think this is being used as of yet.";

        var difficultyDescription:FlxUIText = new FlxUIText(8, 68, 374, difficultyDescriptionText, 12);
        tabGroupGame.add(difficultyDescription);

        var difficultyRadio:FlxUIRadioGroup = new FlxUIRadioGroup(
                                                    406,  // x pos
                                                    68, // y pos
                                                    difficultyIDs, // code ids
                                                    difficultyLabels, // user labels
                                                    this.onSelect_difficulty, // callback
                                                    50, // vertical space between buttons
                                                    100, // max width of a button
                                                    40, // height of a button
                                                    100 // max width of a label
                                                        );
        this.onCreate_initDifficulty(difficultyRadio);
        tabGroupGame.add(difficultyRadio);

        tabMenu.addGroup(tabGroupGame);
        
        // contents tab contents
        // ---------------------
        var tabGroupContents:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupContents.name = "tab_2";

        tabMenu.addGroup(tabGroupContents);

        // display tab contents
        // --------------------
        var tabGroupDisplay:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupDisplay.name = "tab_3";

        tabMenu.addGroup(tabGroupDisplay);

        // debug tab contents
        // ------------------
        var tabGroupDebug:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupDebug.name = "tab_4";

        tabMenu.addGroup(tabGroupDebug);

        // remember when we started the tab menu? Now we can add it to the state.
		this.add(tabMenu);
    }

    /**
     * Just closes the substate.
     */
    public function onClick_back():Void
    {
        this.close();
    }

    /**
     * Sets selected id in difficulty radio buttons to match the difficulty set
     * in registry. Intended for use when this substate is created.
     * 
     * @param difficultyRadio radio buttons from the difficulty settings.
     */
    public function onCreate_initDifficulty(difficultyRadio:FlxUIRadioGroup)
    {
        // TODO: Murder magic strings AND numbers.
        switch (this.registry.difficulty)
        {
            case 0.5:
                difficultyRadio.selectedId = "diff_easy";
            case 1.0:
                difficultyRadio.selectedId = "diff_normal";
            case 1.5:
                difficultyRadio.selectedId = "diff_hard";
            default:
                // throw error
        }
    }

    /**
     * adjusts difficulty value in game's registry
     * 
     * @param diff_id the id of the now selected difficulty
     */
    public function onSelect_difficulty(diff_id:String):Void
    {
        // TODO: Assasinate magic numbers.
        switch (diff_id)
        {
            case "diff_easy":
                this.registry.difficulty = 0.5;
            case "diff_normal":
                this.registry.difficulty = 1.0;
            case "diff_hard":
                this.registry.difficulty = 1.5;
            default:
                // throw an error
        }
    }
}