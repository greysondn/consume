package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;

class HelpExpression extends BaseExpression
{
    public function new()
    {
        // parent can do the thing
        super();
        
        // now actually build this up
        this.command = "help";

        this.helpShow    = true;
        this.helpExample = "help";
        this.helpString  = "displays this help text";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // yeah no
        var outStr:String = "";
        outStr = outStr + "------------" + "\n";
        outStr = outStr + "COMMAND HELP" + "\n";
        outStr = outStr + "------------" + "\n";

        for (command in env.commands)
        {
            if (command.helpShow)
            {
                outStr = outStr + "\n" + "-> " + command.helpExample + "\n";
                outStr = outStr + command.helpString + "\n"; 
            }
        }

        outStr = outStr + "\n";
        outStr = outStr + "There may be other, undocumented commands.";

        env.outStream(outStr);
    }
}