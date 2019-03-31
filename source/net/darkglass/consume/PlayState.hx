package net.darkglass.consume;

import haxe.ui.containers.VBox;
import haxe.ui.containers.Absolute;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;

import haxe.ui.Toolkit;
import haxe.ui.containers.ScrollView;
import haxe.ui.components.Label;
import haxe.ui.macros.ComponentMacros;

import net.darkglass.consume.Registry;
import net.darkglass.iguttae.Iguttae;
import net.darkglass.iguttae.environment.Environment;

import net.darkglass.iguttae.expression.EchoExpression;
import net.darkglass.iguttae.expression.HelpExpression;
import net.darkglass.iguttae.expression.TeleportExpression;
import net.darkglass.iguttae.expression.MoveExpression;

import net.darkglass.iguttae.loader.YamlLoader;

class PlayState extends FlxState
{
    private var registry:Registry = Registry.create();

    // This makes me angry.
    private var outBuffer:Array<String> = [];
    private var lastCommandIndex:Int = 0;

    private var uiGroup:FlxGroup = new FlxGroup();

    private var cin:Label;
    private var cout:Label;
    private var location:Label;
    private var coutContainer:ScrollView;
    private var coutFrame:VBox;
    private var interpreter:Iguttae;

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
        this.env.player.location.describe(this.env);
        this.location.text = this.env.player.location.name;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        this.handleKeyboard();
    }

    private function buildEnv():Void
    {
        this.env.outStream = this.handleOutput;
        this.env.onLocationChange = this.onLocationChange;

        this.env.commands.push(new HelpExpression());
        this.env.commands.push(new EchoExpression());
        this.env.commands.push(new TeleportExpression());
        this.env.commands.push(new MoveExpression());
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
        this.handleCommandOutput("Welcome to consume! Currently being ported.");

        this.cin = _ui.findComponent("cin", Label);
        this.cin.width = 800;
        this.cin.text = "> ";

        this.coutContainer = _ui.findComponent("txtoutscroll", ScrollView);
        this.coutFrame     = _ui.findComponent("txtoutcontainer", VBox);

        this.location = _ui.findComponent("location", Label);
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
            // now add new text
            this.handleCommandOutput(this.cin.text);
            this.interpreter.eval(this.cin.text.substring(1));
            this.coutContainer.vscrollPos = 0;
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
        this.handleOutputCore(txt, false);
    }

    public function handleCommandOutput(txt:String)
    {
        this.handleOutputCore(txt, true);
    }

    public function handleOutputCore(txt:String, isCommand:Bool)
    {
        // append to string array
        this.outBuffer.push(txt);

        // if it's a command, we update the height to scroll to
        if (isCommand)
        {
            this.lastCommandIndex = this.outBuffer.length - 1;
        }

        // angry on the level of wanting to quit, seriously
        var newText:String = "";
        
        // give it!
        for (i in this.lastCommandIndex ... this.outBuffer.length)
        {
            newText = newText + this.outBuffer[i] + "\n\n";
        }

        this.cout.text = newText;
    }

    public function onLocationChange(newLocationName:String):Void
    {
        this.location.text = newLocationName;
    }
}