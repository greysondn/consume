package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;

class UnlockExpression extends BaseExpression
{
    public function new()
    {
        // parent always gotta be starting something
        super();

        // and now
        this.command = "unlock";

        // help text
        this.helpShow    = true;
        this.helpExample = "unlock [direction] <with [item]>";
        this.helpString  = "Attempt to unlock direction, optionally a " +
                           "specific item."
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        
    }
}