package net.darkglass.consume.substate;

import flixel.group.FlxGroup;
import flixel.FlxSprite;

import net.darkglass.util.flixel.FlxHaxeUiSubstate;

import haxe.ui.Toolkit;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.components.Label;
import haxe.ui.containers.VBox;
import haxe.ui.components.Button;
import haxe.ui.events.UIEvent;

import openfl.utils.Assets;

import yaml.Yaml;
import yaml.util.ObjectMap;

class FAQSubstate extends FlxHaxeUiSubstate
{
    public static var outStr:String = "";

    override public function create():Void
    {
        // parent
        super.create();

        // instance vars
        var uiGroup = new FlxGroup();

        // fake bg
        var bg_faked:FlxSprite = new FlxSprite(23, 23, "assets/images/gui/classic/bg/faq_faked.png");
        this.add(bg_faked);

        // ui toolkit
        Toolkit.screen.options = { container : uiGroup };
        this.add(uiGroup);
        
        var _ui = ComponentMacros.buildComponent("assets/ui/substate/faq.xml");
        uiGroup.add(_ui);

        var cout:Label = _ui.findComponent("cout", Label);
        cout.width = 686;

        var but:Button = _ui.findComponent("close", Button);
        but.onClick = this.onClick_back;


        // load text from YAML
        this.loadText(cout);
    }

    private function loadText(cout:Label):Void
    {
        if ("" == outStr)
        {
            // eventually
            var outTxt:String = "";

            // easier this way for me
            var divider:String = "-----------------------------------------------";

            // load source
            var txtSrc:String = Assets.getText("assets/data/en-us/faq.yaml");
            var txtDat:Array<ObjectMap<String, Dynamic>> = Yaml.parse(txtSrc);

            // we iterate over it
            for (entry in txtDat)
            {
                // real entries have an id greater than zero
                if (entry.get("id") >= 0)
                {
                    // only a divider if it's not the first
                    if (entry.get("id") != 0)
                    {
                        outTxt = outTxt + divider + "\n\n";
                    }
                    
                    // question and answer
                    outTxt = outTxt + "Q: " + entry.get("q") + "\n\n";
                    outTxt = outTxt + "A: " + entry.get("a") + "\n\n";
                }
            }

            // stash to use later
            outStr = outTxt;
        }

        // set it, finally
        cout.text = outStr;
    }

    private function onClick_back(ignored:UIEvent):Void
    {
        this.close();
    }
}