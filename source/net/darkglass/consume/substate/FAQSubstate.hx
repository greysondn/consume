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

class FAQSubstate extends FlxUISubState
{
    private var registry:Registry = Registry.create();

    override public function create():Void
    {
        super.create();

        var buttonEnabledGFX:Array<String>  = registry.gfxset_buttonEnabled;
        var slicecoords:Array<Array<Int>> = [[1, 1, 2, 2], [1, 1, 2, 2], [1, 1, 2, 2]];

        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(23, 23, registry.gfx_buttonNormal, new Rectangle(0, 0, 804, 594), [1, 1, 2, 2]);
        this.add(background);

        var fntcol:FlxTextFormat = new FlxTextFormat(0xFF000000);
        var titleTxt:FlxUIText = new FlxUIText(32, 32, 786, "FAQ", 70);
        titleTxt.alignment = "center";
        titleTxt.addFormat(fntcol);
        this.add(titleTxt);

        var textframe:FlxUI9SliceSprite = new FlxUI9SliceSprite(56, 119, registry.gfx_buttonNormal, new Rectangle(0, 0, 706, 391), [1, 1, 2, 2]);
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

        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: The game really, really sucks now! What is even going on "  +
                        "with this anymore?");
        wat.addText("");
        wat.addText("A: Genko's code was a real mess. Instead of trying to work "   +
                    "with it, I decided to port the core game and redesign it to "  +
                    "be more tolerable. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Who are you anyway? Why did you take this project over?");
        wat.addText("");
        wat.addText("A: My name is pretty insignificant in the grand scheme. I "    +
                    "studied a lot of game design and am a fan of older text "      +
                    "adventure games, and Consume always bothered me in that "      +
                    "arena but I felt that there was no reason to poke it "         +
                    "until recent when it was declared abandoned. My reasons "      +
                    "are somewhat myriad and not all pure; in the long run, I'm "   +
                    "hoping to make enough money and design a text interpreter "    +
                    "to step from here to releasing more conventional games. "      +
                    "(Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Make money? How?");
        wat.addText("");
        wat.addText("A: More likely than not, Patreon or donations on this specific "  +
                    "project. This isn't exactly storefront friendly material, "    +
                    "after all. But the engine could be used to make games that "   +
                    "could be more viable, I think, as long as I design it right. " +
                    "(Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Are you going to write in new content? More scenes of the player being eaten? More types of vore?");
        wat.addText("");
        wat.addText("A: I haven't ruled this out, but it's not on my list just yet. "   +
                    "The first priority MUST be to get the game in a more maintainable " +
                    "state. If that happens, then even if I abandon it someone else " +
                    "would find it easier to pick up and fiddle with later on. So given " +
                    "that, everything else is on the back burner until the porting process " +
                    "is done. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Will there be [insert type of vore]? Will there be [insert species]?");
        wat.addText("");
        wat.addText("A: No promises. See above question. TBD. Etc.  (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Will there be graphics? Can I make graphics for the game?");
        wat.addText("");
        wat.addText("A: This question is shelved. Please see the question two above. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Can I write scenes then?");
        wat.addText("");
        wat.addText("A: Much like the above answers, I don't want to try to slide " +
                    "in new content while I'm working on the port. Wait for now.  " +
                    "There will come a point I'm open to contributions and write "  +
                    "a guide for people to follow. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Can I pay for this game? Who should I pay, even?");
        wat.addText("");
        wat.addText("A: I guess that gets complicated to follow, but basically, " +
                    "I hope I eventually reach a point where I can say I've done " +
                    "enough work and paying me isn't a sin. For now? I'd suggest " +
                    "probably nobody; I'm the one currently working on this, and " +
                    "I'm not taking money until I feel I've earned it. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: What did you use to make Consume's HaxeFlixel port?");
        wat.addText("");
        wat.addText("A: Haxe, and Haxeflixel. Genko seems to have not understood the ecosystem very well. I've had years of experience in it, and I've been working with Flixel longer than there's been a Haxe port of it. The IDE is VS-Code; the platform of choice is (regretably) Windows 10. Game testing is done via a debug build for HTML5, running in Google Chrome. Beyond this, it's just a difference in experience - not, I think, in ability. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Why is it called a WaTTY?");
        wat.addText("");
        wat.addText("A: Very few people will come to this question, but there is a category of people who will. Wa is Japanese for bad, and a TTY is a text interface used for extremely old machinery and text-to-speech systems. The joke here is that it's not a very good TTY (it's not, it just gets the job done)... and also I get to name every instance of WaTTY a wat for extra points, because wat is even going on anymore. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Will you reopen the Reddit community? Or start your own?");
        wat.addText("");
        wat.addText("A: Reddit really doesn't like when a banned subreddit changes its name and reopens. I suggest not doing that. (Greysondn, 7 February 2019)");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: Will you open some kind of community or something?");
        wat.addText("");
        wat.addText("A: Check the FA description for a Discord server.");
        wat.addText("");
        wat.addText("-----------------------------------------------------------------");
        wat.addText("");
        wat.addText("Q: How many lines are left to port from the old codebase to the new one?");
        wat.addText("");
        wat.addText("A: These may be out of date, and it's not a perfect measure of progress but...");
        
        var progressTxt:String = "";
        progressTxt = progressTxt + "Main.hx             -  7 600" + "\n";
        progressTxt = progressTxt + "" + "\n";
        progressTxt = progressTxt + "AlertBox.hx         -      0" + "\n";
        progressTxt = progressTxt + "MyButton.hx         -      0" + "\n";
        progressTxt = progressTxt + "MyCharacter.hx      -    818" + "\n";
        progressTxt = progressTxt + "MyExit.hx           -     46" + "\n";
        progressTxt = progressTxt + "MyFileSaveObject.hx -      0" + "\n";
        progressTxt = progressTxt + "MyItem_Armor.hx     -     98" + "\n";
        progressTxt = progressTxt + "MyItem_Food.hx      -    110" + "\n";
        progressTxt = progressTxt + "MyItem_Key.hx       -     40" + "\n";
        progressTxt = progressTxt + "MyItem_Ring.hx      -     79" + "\n";
        progressTxt = progressTxt + "MyItem_Weapon.hx    -    113" + "\n";
        progressTxt = progressTxt + "MyItem.hx           -     71" + "\n";
        progressTxt = progressTxt + "MyNPC.hx            -    371" + "\n";
        progressTxt = progressTxt + "MyPerk.hx           -     26" + "\n";
        progressTxt = progressTxt + "MyPlayerObject.hx   -    862" + "\n";
        progressTxt = progressTxt + "MyQuest.hx          -     28" + "\n";
        progressTxt = progressTxt + "MyRoom.hx           -     67" + "\n";
        progressTxt = progressTxt + "MySpecies.hx        -    120" + "\n";
        progressTxt = progressTxt + "MyTimer.hx          -     63" + "\n";
        progressTxt = progressTxt + "PlayCard.hx         -     65" + "\n";
        progressTxt = progressTxt + "PlayerCharacter.hx  -    143" + "\n";
        progressTxt = progressTxt + "" + "\n";
        progressTxt = progressTxt + "Total               - 10 720" + "\n";
        wat.addText(progressTxt);
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