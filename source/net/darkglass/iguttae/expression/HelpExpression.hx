package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;

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

    override public function eval(input:String, env:Environment):String
    {
        // yeah no
        var ret:String = "";
        ret = ret + "------------" + "\n";
        ret = ret + "COMMAND HELP" + "\n";
        ret = ret + "------------" + "\n";

        for (command in env.commands)
        {
            if (command.helpShow)
            {
                ret = ret + "\n" + "-> " + command.helpExample + "\n";
                ret = ret + command.helpString + "\n"; 
            }
        }

        ret = ret + "\n";
        ret = ret + "There may be other, undocumented commands.";

        return ret;
    }
}