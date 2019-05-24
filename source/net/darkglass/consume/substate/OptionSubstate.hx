package net.darkglass.consume.substate;

import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUISubState;

import flixel.FlxG;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUILine;
import flixel.addons.ui.FlxUILine.LineAxis;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;

import flixel.text.FlxText.FlxTextFormat;

import net.darkglass.consume.Registry;

import openfl.desktop.Clipboard;
import openfl.desktop.ClipboardFormats;

class OptionSubstate extends FlxUISubState
{
    private var registry:Registry = Registry.create();
    private var arousalTickbox:FlxUICheckBox; // Todo: tighten scope

    private var ballsTickbox:FlxUICheckBox;
    private var breastsTickbox:FlxUICheckBox;
    private var penisTickbox:FlxUICheckBox;
    private var vaginaTickbox:FlxUICheckBox;

    private var cuntboyTickbox:FlxUICheckBox;
    private var dickgirlTickbox:FlxUICheckBox;
    private var dollTickbox:FlxUICheckBox;
    private var femaleTickbox:FlxUICheckBox;
    private var hermTickbox:FlxUICheckBox;
    private var maleTickbox:FlxUICheckBox;
    private var neuterTickbox:FlxUICheckBox;

    override public function create():Void 
    {
        // buttons needed:
        //
        // title screen
        // ------------
        // Debug
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
        var buttonEnabledGFX:Array<String>  = registry.gfxset_buttonEnabled;
        var buttonDisabledGFX:Array<String> = registry.gfxset_buttonDisabled;
        var slicecoords:Array<Array<Int>> = registry.gfxset_buttonEnabled_slice;

        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(23, 23, registry.gfx_bgGeneral, new Rectangle(0, 0, 804, 594), registry.gfx_bgGeneral_slice);
        this.add(background);

        // clickable button that doesn't suck too hard to close it?
        var backButton:FlxUIButton = new FlxUIButton(32, 566, "Back", onClick_back);
        backButton.loadGraphicSlice9(buttonEnabledGFX, 786, 42, slicecoords, 0, -1);
        this.add(backButton);

        // title
        // loc  32x32
        // size 786x87
        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);
        var titleTxt:FlxUIText = new FlxUIText(32, 32, 786, "Options", 70);
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
        var difficultyTitleTxt:FlxUIText = new FlxUIText(8, 16, 770, "Difficulty", 32);
        difficultyTitleTxt.alignment = "left";
        tabGroupGame.add(difficultyTitleTxt);

        // difficulty options radio group
        var difficultyIDs:Array<String>   = ["diff_easy", "diff_normal", "diff_hard"];
        var difficultyLabels:Array<String> = ["Easy", "Normal", "Hard"];
        

        var difficultyDescriptionText:String = "Meant to adjust the difficulty of combat\n" +
                                               "\n" +
                                               "I don't think this is being used as of yet.";

        var difficultyDescription:FlxUIText = new FlxUIText(8, 60, 374, difficultyDescriptionText, 12);
        tabGroupGame.add(difficultyDescription);

        var difficultyRadio:FlxUIRadioGroup = new FlxUIRadioGroup(406, 60, difficultyIDs, difficultyLabels, this.onSelect_difficulty);
        this.onCreate_initDifficulty(difficultyRadio);
        tabGroupGame.add(difficultyRadio);

        tabMenu.addGroup(tabGroupGame);
        
        // contents tab contents
        // ---------------------
        var tabGroupContents:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupContents.name = "tab_2";
        
        // general section title
        var contentsGeneralTitleTxt:FlxUIText = new FlxUIText(8, 16, 770, "General", 32);
        contentsGeneralTitleTxt.alignment = "left";
        tabGroupContents.add(contentsGeneralTitleTxt);

        // arousal, with tickbox etc
        var arousalDescriptionText:String = "Enables / Disables sex. Controls if your character becomes aroused.";
        var arousalDescription:FlxUIText = new FlxUIText(8, 60, 374, arousalDescriptionText, 12);
        tabGroupContents.add(arousalDescription);

        arousalTickbox = new FlxUICheckBox(406, 60, null, null, "Arousal", 100, null, this.onToggle_arousal);
        this.onCreate_initArousal(arousalTickbox);
        tabGroupContents.add(arousalTickbox);

        // divider
        var contentsDivider01:FlxUILine = new FlxUILine(4, 90, LineAxis.HORIZONTAL, 778, 0.5, 0x80333333);
        tabGroupContents.add(contentsDivider01);

        // scat, with tickbox etc
        var scatDescriptionText:String = "Enables / Disables scat. Controls if your character defecates or not.";
        var scatDescription:FlxUIText  = new FlxUIText(8, 94, 372, scatDescriptionText, 12);
        tabGroupContents.add(scatDescription);

        var scatTickbox:FlxUICheckBox = new FlxUICheckBox(406, 94, null, null, "Scat", 100, null, this.onToggle_scat);
        this.onCreate_initScat(scatTickbox);
        tabGroupContents.add(scatTickbox);

        // NPC section title
        var contentsNPCTitleTxt:FlxUIText = new FlxUIText(8, 138, 770, "NPC Properties", 32);
        contentsNPCTitleTxt.alignment = "left";
        tabGroupContents.add(contentsNPCTitleTxt);

        // Npc section description text
        var contentsNPCDescriptionText:String = "These tickboxes toggle whether or not certain NPC properties are present in the game.\n" +
                                         "\n" +
                                         "I think this was the task the original development stalled on. The selections you make here are saved but they may not be actually applied as of yet.\n" +
                                         "\n" +
                                         "Also be aware that these columns are independent and affect each other. So multiple ones might change as you check boxes.";

        var contentsNPCDescription:FlxUIText  = new FlxUIText(8, 182, 372, contentsNPCDescriptionText, 12);
        tabGroupContents.add(contentsNPCDescription);

        // parts column

        // breasts
        this.breastsTickbox = new FlxUICheckBox(406, 182, null, null, "Breasts", 50, null, this.onToggle_breasts);
        this.onCreate_initBreasts(breastsTickbox);
        tabGroupContents.add(breastsTickbox);

        // vagina
        this.vaginaTickbox = new FlxUICheckBox(406, 202, null, null, "Vagina", 50, null, this.onToggle_vagina);
        this.onCreate_initVagina(vaginaTickbox);
        tabGroupContents.add(vaginaTickbox);

        // penis
        this.penisTickbox = new FlxUICheckBox(406, 222, null, null, "Penis", 50, null, this.onToggle_penis);
        this.onCreate_initPenis(penisTickbox);
        tabGroupContents.add(penisTickbox);

        // balls
        this.ballsTickbox = new FlxUICheckBox(406, 242, null, null, "Balls", 50, null, this.onToggle_balls);
        this.onCreate_initBalls(ballsTickbox);
        tabGroupContents.add(ballsTickbox);

        // sex column

        // cuntboy
        this.cuntboyTickbox = new FlxUICheckBox(502, 182, null, null, "Cuntboy", 100, null, this.onToggle_cuntboy);
        this.onCreate_initCuntboy(cuntboyTickbox);
        tabGroupContents.add(cuntboyTickbox);

        // dickgirl
        this.dickgirlTickbox = new FlxUICheckBox(502, 202, null, null, "Dickgirl", 100, null, this.onToggle_dickgirl);
        this.onCreate_initDickgirl(dickgirlTickbox);
        tabGroupContents.add(dickgirlTickbox);

        // doll
        this.dollTickbox = new FlxUICheckBox(502, 222, null, null, "Doll", 100, null, this.onToggle_doll);
        this.onCreate_initDoll(dollTickbox);
        tabGroupContents.add(dollTickbox);

        // female
        this.femaleTickbox = new FlxUICheckBox(502, 242, null, null, "Female", 100, null, this.onToggle_female);
        this.onCreate_initFemale(femaleTickbox);
        tabGroupContents.add(femaleTickbox);

        // herm
        this.hermTickbox = new FlxUICheckBox(502, 262, null, null, "Herm", 100, null, this.onToggle_herm);
        this.onCreate_initHerm(hermTickbox);
        tabGroupContents.add(hermTickbox);

        // male
        this.maleTickbox = new FlxUICheckBox(502, 282, null, null, "Male", 100, null, this.onToggle_male);
        this.onCreate_initMale(maleTickbox);
        tabGroupContents.add(maleTickbox);

        // neuter
        this.neuterTickbox = new FlxUICheckBox(502, 302, null, null, "Neuter", 100, null, this.onToggle_neuter);
        this.onCreate_initNeuter(neuterTickbox);
        tabGroupContents.add(neuterTickbox);

        tabMenu.addGroup(tabGroupContents);

        // display tab contents
        // --------------------
        var tabGroupDisplay:FlxUI = new FlxUI(null, tabMenu, null);

        tabGroupDisplay.name = "tab_3";

        // just a note for now
        // 8x8
        // width 770
        var displayDescriptionText:String = "So, I'm quite sorry about this, because you're probably in here for font size.\n" +
                                            "\n" +
                                            "Long story short, due to some issues, this isn't possible this instant. Rather than spend 20 hours on a workaround, I decided to just write what I could so this port would be released.\n" +
                                            "\n" +
                                            "Look for this feature to be returned in a later version, as soon as it's possible.";

        var displayDescription:FlxUIText = new FlxUIText(8, 8, 770, displayDescriptionText, 12);
        tabGroupDisplay.add(displayDescription);

        tabMenu.addGroup(tabGroupDisplay);

        // debug tab contents
        // ------------------
        var tabGroupDebug:FlxUI = new FlxUI(null, tabMenu, null);
        tabGroupDebug.name = "tab_4";

        var hackTestTextTxt:String = "1234567890123456789012345678901234567890\n" +
                                     "The plan, you see, is to put tests in this tab\n" +
                                     "|\n" +
                                     "\\|\n" +
                                     "Okay.. I lied.";

        var hackTestText:FlxUIText = new FlxUIText(8, 8, 500, hackTestTextTxt);
        hackTestText.setFormat("assets/fonts/hack.ttf", 16);
        tabGroupDebug.add(hackTestText);

        var clipboardButton:FlxButton = new FlxButton(200, 65, "Copied!", this.onClick_clipboard);
        tabGroupDebug.add(clipboardButton);

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

    public function onClick_clipboard():Void
    {
        var cb:Clipboard = Clipboard.generalClipboard;
        cb.setData(ClipboardFormats.TEXT_FORMAT, "It worked!");
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
                FlxG.log.error("Impossible difficulty selected! (WTF?!?)");
        }
    }

    public function onCreate_initArousal(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.arousalEnabled;
    }

    public function onCreate_initBalls(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.ballsEnabled;
    }

    public function onCreate_initBreasts(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.breastsEnabled;
    }

    public function onCreate_initCuntboy(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.cuntboyEnabled;
    }

    public function onCreate_initDickgirl(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.dickgirlEnabled;
    }

    public function onCreate_initDoll(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.dollEnabled;
    }

    public function onCreate_initFemale(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.femaleEnabled;
    }

    public function onCreate_initHerm(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.hermEnabled;
    }

    public function onCreate_initMale(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.maleEnabled;
    }

    public function onCreate_initNeuter(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.neuterEnabled;
    }

    public function onCreate_initPenis(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.penisEnabled;
    }

    public function onCreate_initScat(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.scatEnabled;
    }

    public function onCreate_initVagina(aTickbox:FlxUICheckBox):Void
    {
        aTickbox.checked = registry.vaginaEnabled;
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

    /**
     * Performs relevant toggle on arousal in game registry.
     */
    public function onToggle_arousal():Void
    {
        registry.arousalEnabled = !registry.arousalEnabled;
    }

    /**
     * Performs relevant toggle on balls in game registry.
     */
    public function onToggle_balls():Void
    {
        registry.ballsEnabled = !registry.ballsEnabled;

        if (registry.ballsEnabled)
        {
            registry.penisEnabled = true;
            this.penisTickbox.checked = true;
        }

        helper_secondaryChanged();
    }

    /**
     * Performs relevant toggle on breasts in game registry.
     */
    public function onToggle_breasts():Void
    {
        registry.breastsEnabled = !registry.breastsEnabled;
        helper_secondaryChanged();
    }

    /**
     * Performs relevant toggle on cuntboy in game registry.
     */
    public function onToggle_cuntboy():Void
    {
        registry.cuntboyEnabled = !registry.cuntboyEnabled;
        helper_sexChanged();
    }

    /**
     * Performs relevant toggle on dickgirl in game registry.
     */
    public function onToggle_dickgirl():Void
    {
        registry.dickgirlEnabled = !registry.dickgirlEnabled;
        helper_sexChanged();
    }
    
    /**
     * Performs relevant toggle on doll in game registry.
     */
    public function onToggle_doll():Void
    {
        registry.dollEnabled = !registry.dollEnabled;
        helper_sexChanged();
    }

    /**
     * Performs relevant toggle on female in game registry.
     */
    public function onToggle_female():Void
    {
        registry.femaleEnabled = !registry.femaleEnabled;
        helper_sexChanged();
    }
    
    /**
     * Performs relevant toggle on herm in game registry.
     */
    public function onToggle_herm():Void
    {
        registry.hermEnabled = !registry.hermEnabled;
        helper_sexChanged();
    }

    /**
     * Performs relevant toggle on male in game registry.
     */
    public function onToggle_male():Void
    {
        registry.maleEnabled = !registry.maleEnabled;
        helper_sexChanged();
    }

    /**
     * Performs relevant toggle on neuter in game registry.
     */
    public function onToggle_neuter():Void
    {
        registry.neuterEnabled = !registry.neuterEnabled;
        helper_sexChanged();
    }

    /**
     * Performs relevant toggle on penis in game registry.
     */
    public function onToggle_penis():Void
    {
        registry.penisEnabled = !registry.penisEnabled;

        if (!registry.penisEnabled)
        {
            this.ballsTickbox.checked = false;
            registry.ballsEnabled = false;
        }

        helper_secondaryChanged();
    }

    /**
     * Performs relevant toggle on scat in game registry.
     */
    public function onToggle_scat():Void
    {
        registry.scatEnabled = !registry.scatEnabled;
    }

    /**
     * Performs relevant toggle on vagina in game registry.
     */
    public function onToggle_vagina():Void
    {
        registry.vaginaEnabled = !registry.vaginaEnabled;
        helper_secondaryChanged();
    }

    /**
     * Meant to be called when a sexual property changes, to set sexes that
     * match.
     */
    private function helper_secondaryChanged():Void
    {
        // I started to do this as an exhaustive binary tree, but it's not
        // very practical to do it that way.
        //
        // instead, just do it as a series of if statements. It won't drive
        // you crazy.

        // female
        if (registry.breastsEnabled && registry.vaginaEnabled)
        {
            registry.femaleEnabled = true;
            this.femaleTickbox.checked = true;
        }
        else
        {
            registry.femaleEnabled = false;
            this.femaleTickbox.checked = false;
        }

        // male
        if (registry.penisEnabled)
        {
            registry.maleEnabled = true;
            this.maleTickbox.checked = true;
        }
        else
        {
            registry.maleEnabled = false;
            this.maleTickbox.checked = false;
        }

        // herms
        if (registry.penisEnabled && registry.vaginaEnabled)
        {
            registry.hermEnabled = true;
            this.hermTickbox.checked = true;
        }
        else
        {
            registry.hermEnabled = false;
            this.hermTickbox.checked = false;
        }
        

        // dickgirl
        if (registry.breastsEnabled && registry.penisEnabled)
        {
            registry.dickgirlEnabled = true;
            this.dickgirlTickbox.checked = true;
        }
        else
        {
            registry.dickgirlEnabled = false;
            this.dickgirlTickbox.checked = false;
        }

        // doll
        if (registry.breastsEnabled)
        {
            registry.dollEnabled = true;
            this.dollTickbox.checked = true;
        }
        else
        {
            registry.dollEnabled = false;
            this.dollTickbox.checked = false;
        }

        // cuntboy
        if (registry.vaginaEnabled)
        {
            registry.cuntboyEnabled = true;
            this.cuntboyTickbox.checked = true;
        }
        else
        {
            registry.cuntboyEnabled = false;
            this.cuntboyTickbox.checked = false;
        }

        // neuter
        // actually, the fallback check for neuter, more like.
        this.helper_neuterFallbackCheck();
    }

    /**
     * Meant to be called when sexes are changed for NPCS
     * 
     * Makes sure at least one sex is enabled, and sets genitals in accordance
     * with how sexes have been set.
     */
    private function helper_sexChanged():Void
    {
        // breasts
        if (registry.femaleEnabled ||
            registry.dickgirlEnabled ||
            registry.dollEnabled)
        {
            this.breastsTickbox.checked = true;
            registry.breastsEnabled = true;
        }
        else
        {
            this.breastsTickbox.checked = false;
            registry.breastsEnabled     = false;
        }

        // vagina
        if (registry.femaleEnabled ||
            registry.hermEnabled ||
            registry.cuntboyEnabled)
        {
            this.vaginaTickbox.checked = true;
            registry.vaginaEnabled     = true;
        }
        else
        {
            this.vaginaTickbox.checked = false;
            registry.vaginaEnabled     = false;
        }

        // penis
        //
        // balls must be absent if penis is absent, is the only major stickler
        // here.
        if (registry.maleEnabled ||
            registry.hermEnabled ||
            registry.dickgirlEnabled)
        {
            this.penisTickbox.checked = true;
            registry.penisEnabled     = true;
        }
        else
        {
            this.penisTickbox.checked = false;
            registry.penisEnabled     = false;

            this.ballsTickbox.checked = false;
            registry.ballsEnabled     = false;
        }

        // make sure at least one sex was left checked, after all
        this.helper_neuterFallbackCheck();
    }

    /**
     * Meant to be called when a sexes are changed, just in case a fallback is
     * necessary because the user is being a bit of a silly goose
     */
    private function helper_neuterFallbackCheck():Void
    {
        // if neuter wound up true, fallback to setting neuter true.
        if (!registry.cuntboyEnabled &&
            !registry.dickgirlEnabled &&
            !registry.dollEnabled &&
            !registry.femaleEnabled &&
            !registry.hermEnabled &&
            !registry.maleEnabled)
        {
            this.neuterTickbox.checked = true;
            registry.neuterEnabled     = true;
        }
    }
}