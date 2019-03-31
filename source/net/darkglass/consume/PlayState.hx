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
import haxe.ui.events.UIEvent;
import haxe.ui.components.Button;


import net.darkglass.consume.Registry;
import net.darkglass.iguttae.Iguttae;
import net.darkglass.iguttae.environment.Environment;

// import net.darkglass.iguttae.expression.EchoExpression;
import net.darkglass.iguttae.expression.HelpExpression;
// import net.darkglass.iguttae.expression.TeleportExpression;
import net.darkglass.iguttae.expression.MoveExpression;
import net.darkglass.iguttae.expression.LookExpression;

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
        // this.env.commands.push(new EchoExpression());
        // this.env.commands.push(new TeleportExpression());
        this.env.commands.push(new MoveExpression());
        this.env.commands.push(new LookExpression());
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

        // navigational buttons
        
        // var button_u:Button = _ui.findComponent("button_u", Button);
        // button_u.onClick    = this.onPress_button_u;
        
        // var button_d:Button = _ui.findComponent("button_d", Button);
        // button_d.onClick    = this.onPress_button_d;

        var button_n:Button = _ui.findComponent("button_n", Button);
        button_n.onClick    = this.onPress_button_n;

        var button_ne:Button = _ui.findComponent("button_ne", Button);
        button_ne.onClick    = this.onPress_button_ne;

        var button_e:Button = _ui.findComponent("button_e", Button);
        button_e.onClick    = this.onPress_button_e;

        var button_se:Button = _ui.findComponent("button_se", Button);
        button_se.onClick    = this.onPress_button_se;

        var button_s:Button = _ui.findComponent("button_s", Button);
        button_s.onClick    = this.onPress_button_s;

        var button_sw:Button = _ui.findComponent("button_sw", Button);
        button_sw.onClick    = this.onPress_button_sw;

        var button_w:Button = _ui.findComponent("button_w", Button);
        button_w.onClick    = this.onPress_button_w;

        var button_nw:Button = _ui.findComponent("button_nw", Button);
        button_nw.onClick    = this.onPress_button_nw;

        // var button_i:Button = _ui.findComponent("button_i", Button);
        // button_i.onClick    = this.onPress_button_i;

        // var button_o:Button = _ui.findComponent("button_o", Button);
        // button_o.onClick    = this.onPress_button_o;

        // common action rack buttons
        var button_look:Button = _ui.findComponent("button_look", Button);
        button_look.onClick    = this.onPress_button_look;
        
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

    private function handleButton(command:String):Void
    {
        this.handleCommandOutput("> " + command);
        this.interpreter.eval(command);
        this.coutContainer.vscrollPos = 0;
        this.cin.text = "> ";
    }

    private function onPress_button_u(e:UIEvent):Void
    {
        this.handleButton("move up");
    }

    private function onPress_button_d(e:UIEvent):Void
    {
        this.handleButton("move down");
    }

    private function onPress_button_n(e:UIEvent):Void
    {
        this.handleButton("move north");
    }

    private function onPress_button_ne(e:UIEvent):Void
    {
        this.handleButton("move northeast");
    }

    private function onPress_button_e(e:UIEvent):Void
    {
        this.handleButton("move east");
    }

    private function onPress_button_se(e:UIEvent):Void
    {
        this.handleButton("move southeast");
    }

    private function onPress_button_s(e:UIEvent):Void
    {
        this.handleButton("move south");
    }

    private function onPress_button_sw(e:UIEvent):Void
    {
        this.handleButton("move southwest");
    }

    private function onPress_button_w(e:UIEvent):Void
    {
        this.handleButton("move west");
    }

    private function onPress_button_nw(e:UIEvent):Void
    {
        this.handleButton("move northwest");
    }

    private function onPress_button_i(e:UIEvent):Void
    {
        this.handleButton("move in");
    }

    private function onPress_button_o(e:UIEvent):Void
    {
        this.handleButton("move out");
    }

    private function onPress_button_look(e:UIEvent):Void
    {
        this.handleButton("look");
    }
}