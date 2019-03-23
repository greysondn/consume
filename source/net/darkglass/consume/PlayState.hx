package net.darkglass.consume;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;

import haxe.ui.Toolkit;
import haxe.ui.containers.ScrollView;
import haxe.ui.components.Label;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.core.Screen;

import net.darkglass.consume.Registry;
import net.darkglass.iguttae.Iguttae;
import net.darkglass.iguttae.environment.Environment;

import net.darkglass.iguttae.expression.EchoExpression;
import net.darkglass.iguttae.expression.HelpExpression;
import net.darkglass.iguttae.expression.TeleportExpression;

import net.darkglass.iguttae.loader.YamlLoader;

class PlayState extends FlxState
{
    private var registry:Registry = Registry.create();

    private var uiGroup:FlxGroup = new FlxGroup();

    private var cin:Label;
    private var cout:Label;
    private var coutContainer:ScrollView;
    private var interpreter:Iguttae;

    private var prevScroll:Float = 0.0;

    private var env:Environment = new Environment();

    override public function create():Void
    {
        // let parent do its thing
        super.create();

        // build the local environment 
        this.buildEnv();

        // build a ui, plox
        this.buildUI();

        // init iggutae
        this.interpreter = new Iguttae(this.env);

        // load environment
        var y:YamlLoader = YamlLoader.create();
        y.load(this.env);

        // add player to environment
        // TODO: don't hardcode this, move to file
        this.env.player.location = this.env.getRoom(0);
        this.env.player.location.insert(this.env.player);
        this.env.outStream(this.env.player.location.verbose);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        this.handleKeyboard();
    }

    private function buildEnv():Void
    {
        this.env.outStream = this.handleOutput;

        this.env.commands.push(new HelpExpression());
        this.env.commands.push(new EchoExpression());
        this.env.commands.push(new TeleportExpression());
    }

    /**
     * Helper function for the constructor to build out the UI for us.
     */
    private function buildUI():Void
    {
        // init ui bg elements
        var bg:FlxSprite = new FlxSprite(0, 0, "assets/ui/css/classic/state-bg-faked.png");
        this.add(bg);

        // init ui loader
        Toolkit.init({ container : uiGroup });
        this.add(this.uiGroup);
        var _ui = ComponentMacros.buildComponent("assets/ui/playstate.xml");
        uiGroup.add(_ui);

        this.cout = _ui.findComponent("cout", Label);
        this.cout.width = 770;

        this.cout.text = "";

        this.cin = _ui.findComponent("cin", Label);
        this.cin.width = 800;
        this.cin.text = "> ";

        this.coutContainer = _ui.findComponent("txtoutscroll", ScrollView);
        FlxG.watch.add(this.coutContainer, "vscrollPos");
    }

    private function handleKeyboard():Void
    {
        var res:String = "";
        var val:Int = -1;

        if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT)
        {
            // pass, deliberately
        }
        else if (FlxG.keys.justPressed.UP)
        {
            this.coutContainer.vscrollPos = this.coutContainer.vscrollPos - 32;
        }
        else if (FlxG.keys.justPressed.DOWN)
        {
            this.coutContainer.vscrollPos = this.coutContainer.vscrollPos + 32;
        }
        else if (FlxG.keys.justPressed.PAGEUP)
        {
            this.coutContainer.vscrollPos = this.coutContainer.vscrollPos - 300;
        }
        else if (FlxG.keys.justPressed.PAGEDOWN)
        {
            this.coutContainer.vscrollPos = this.coutContainer.vscrollPos + 300;
        }
        else if (FlxG.keys.justPressed.HOME)
        {
            this.coutContainer.vscrollPos = 0;
        }
        else if (FlxG.keys.justPressed.END)
        {
            this.coutContainer.vscrollPos = this.cout.height + 9001;
        }
        else if (FlxG.keys.justPressed.BACKSPACE)
        {
            if (this.cin.text.length > 2)
            {
                this.cin.text = this.cin.text.substr(0, -1);
            }
        }
        else if (FlxG.keys.justPressed.ENTER)
        {
            var scrollpoint:Float = this.cout.height + 42;
            this.handleOutput(this.cin.text);
            this.interpreter.eval(this.cin.text.substring(1));
            this.coutContainer.vscrollPos = scrollpoint;
            this.cin.text = "> ";
        }
        else
        {
            val = FlxG.keys.firstJustPressed();
            
            if (-1 != val)
            {
                res = String.fromCharCode(val);

                if (FlxG.keys.pressed.SHIFT)
                {
                    res = res.toUpperCase();
                }
                else
                {
                    res = res.toLowerCase();
                }

                cin.text = cin.text + res;
            }
        }
    }

    public function handleOutput(txt:String):Void
    {
        this.cout.text = this.cout.text + "\n\n" + txt;
    }

    private function scrollToBottom():Void
    {
        var prevScroll:Float = this.coutContainer.vscrollPos;
        
        var continueScrolling:Bool = true;

        while (continueScrolling)
        {
            FlxG.log.add(prevScroll);

            if (this.coutContainer.vscrollPos == prevScroll)
            {
                continueScrolling = false;
            }
            else
            {
                prevScroll = coutContainer.vscrollPos;
            }
        }
    }
}
