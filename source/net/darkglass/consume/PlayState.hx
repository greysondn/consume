package net.darkglass.consume;

import haxe.ui.containers.VBox;
import haxe.ui.containers.Absolute;
import flixel.FlxG;
import flixel.FlxSprite;
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
import net.darkglass.iguttae.expression.GetExpression;
import net.darkglass.iguttae.expression.InventoryExpression;
import net.darkglass.iguttae.expression.DropExpression;
import net.darkglass.iguttae.expression.UnlockExpression;

import net.darkglass.util.flixel.FlxHaxeUiState;

import net.darkglass.iguttae.gameworld.actor.Actor;

import net.darkglass.iguttae.loader.CastleDBLoader;


class PlayState extends FlxHaxeUiState
{
    // -------------------------------------------------------------------------
    // Iggutae's second parser
    // -------------------------------------------------------------------------
    private var registry:Registry = Registry.create();

    // so we can double use direction buttons, mostly
    private var secondButton:Bool = false;
    private var firstText:String = "";


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

        // load environment - new castledb
        var cdb:CastleDBLoader = CastleDBLoader.create();
        cdb.load(this.env);

        // add player to environment
        // TODO: don't hardcode this, move to file
        this.env.player.location = cast(this.env.rooms.get(0), Actor);
        this.env.player.location.inventory.add(this.env.player);
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
        this.env.commands.push(new GetExpression());
        this.env.commands.push(new InventoryExpression());
        this.env.commands.push(new DropExpression());
        this.env.commands.push(new UnlockExpression());
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
        Toolkit.screen.options = { container : uiGroup };
        this.add(this.uiGroup);
        var _ui = ComponentMacros.buildComponent("assets/ui/playstate.xml");
        uiGroup.add(_ui);

        this.cout = _ui.findComponent("cout", Label);
        this.handleCommandOutput("Welcome to consume! Currently being ported.");

        this.cin = _ui.findComponent("cin", Label);
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

        var button_unlock:Button = _ui.findComponent("button_unlock", Button);
        button_unlock.onClick    = this.onPress_button_unlock;
        
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
            if (FlxG.keys.justPressed.ONE)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.TWO)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.THREE)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.FOUR)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.FIVE)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.SIX)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.SEVEN)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.EIGHT)
            {
                res = "8";
            }
            if (FlxG.keys.justPressed.NINE)
            {
                res = "9";
            }
            if (FlxG.keys.justPressed.ZERO)
            {
                res = "0";
            }
            if (FlxG.keys.justPressed.BACKSLASH)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "|";
                }
                else
                {
                    res = "\\";
                }
            }
            else if (FlxG.keys.justPressed.COMMA)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "<";
                }
                else
                {
                    res = ",";
                }
            }
            else if (FlxG.keys.justPressed.GRAVEACCENT)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "~";
                }
                else
                {
                    res = "`";
                }
            }
            else if (FlxG.keys.justPressed.LBRACKET)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "{";
                }
                else
                {
                    res = "[";
                }
            }
            else if (FlxG.keys.justPressed.MINUS)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "_";
                }
                else
                {
                    res = "-";
                }
            }
            else if (FlxG.keys.justPressed.PERIOD)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = ">";
                }
                else
                {
                    res = ".";
                }
            }
            else if (FlxG.keys.justPressed.PLUS)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "+";
                }
                else
                {
                    res = "=";
                }
            }
            else if (FlxG.keys.justPressed.QUOTE)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "\"";
                }
                else
                {
                    res = "'";
                }
            }
            else if (FlxG.keys.justPressed.RBRACKET)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "}";
                }
                else
                {
                    res = "]";
                }
            }
            else if (FlxG.keys.justPressed.SEMICOLON)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = ":";
                }
                else
                {
                    res = ";";
                }
            }
            else if (FlxG.keys.justPressed.SLASH)
            {
                if (FlxG.keys.pressed.SHIFT)
                {
                    res = "?";
                }
                else
                {
                    res = "/";
                }
            }
            else if (FlxG.keys.justPressed.SHIFT)
            {
                // pass
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
                }
            }

            // for whatever reason, shift + numbers didn't work so...
            // wanted to go ahead and handle that here, I'm hoping
            // so I can use my entire effin keyboard.
            if (FlxG.keys.pressed.SHIFT)
            {
                switch(res)
                {
                    case "0":
                        res = ")";
                    case "1":
                        res = "!";
                    case "2":
                        res = "@";
                    case "3":
                        res = "#";
                    case "4":
                        res = "$";
                    case "5":
                        res = "%";
                    case "6":
                        res = "^";
                    case "7":
                        res = "&";
                    case "8":
                        res = "*";
                    case "9":
                        res = "(";
                    default:
                        // if it's not one of those, just pass.
                }
            }

            cin.text = cin.text + res;
            
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

    private function handleMoveButton(str:String):Void
    {
        if (this.secondButton)
        {
            this.handleButton(this.firstText + str);
            this.firstText = "";
            this.secondButton = false;
        }
        else
        {
            this.handleButton("move " + str);
        }
    }

    private function onPress_button_u(e:UIEvent):Void
    {
        this.handleMoveButton("up");
    }

    private function onPress_button_d(e:UIEvent):Void
    {
        this.handleMoveButton("down");
    }

    private function onPress_button_n(e:UIEvent):Void
    {
        this.handleMoveButton("north");
    }

    private function onPress_button_ne(e:UIEvent):Void
    {
        this.handleMoveButton("northeast");
    }

    private function onPress_button_e(e:UIEvent):Void
    {
        this.handleMoveButton("east");
    }

    private function onPress_button_se(e:UIEvent):Void
    {
        this.handleMoveButton("southeast");
    }

    private function onPress_button_s(e:UIEvent):Void
    {
        this.handleMoveButton("south");
    }

    private function onPress_button_sw(e:UIEvent):Void
    {
        this.handleMoveButton("southwest");
    }

    private function onPress_button_w(e:UIEvent):Void
    {
        this.handleMoveButton("west");
    }

    private function onPress_button_nw(e:UIEvent):Void
    {
        this.handleMoveButton("northwest");
    }

    private function onPress_button_i(e:UIEvent):Void
    {
        this.handleMoveButton("in");
    }

    private function onPress_button_o(e:UIEvent):Void
    {
        this.handleMoveButton("out");
    }

    private function onPress_button_look(e:UIEvent):Void
    {
        if (!this.secondButton)
        {
            this.handleButton("look");
        }
    }

    private function onPress_button_unlock(e:UIEvent):Void
    {
        // oh boy, I hate this ricko.
        if (this.secondButton)
        {
            this.cin.text = "> ";
            this.firstText = "";
            this.secondButton = false;
        }
        else
        {
            this.firstText = "unlock ";
            this.secondButton = true;
            this.cin.text = "< SELECT DIRECTION TO UNLOCK, CLICK AGAIN TO CANCEL >";
        }
    }
}