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
        this.interpreter.outStream = this.handleOutput;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        this.handleKeyboard();
    }

    private function buildEnv():Void
    {
        this.env.commands.push(new HelpExpression());
        this.env.commands.push(new EchoExpression());
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

        this.cout.text = "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n";
        this.cout.text = cout.text + "\n" + "This is just a test.";
        this.cout.text = cout.text + "\n" + "Not a drill though.";
        this.cout.text = cout.text + "\n";

        this.cout.text = cout.text + "\n" + "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin elementum est in sodales auctor. Suspendisse augue ex, laoreet ut congue ac, interdum a est. Pellentesque id metus eu nibh rutrum placerat eget a massa. Proin posuere facilisis tempor. Morbi ac facilisis orci, id iaculis nisi. Suspendisse vel sem nec massa tincidunt gravida id ullamcorper magna. Donec sodales viverra pellentesque. In non quam feugiat, porta urna et, varius erat. Ut dapibus lacus bibendum sem tempor pellentesque. Morbi at risus nec mauris consectetur ultrices.";

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
