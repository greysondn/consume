package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;

class InventoryExpression extends BaseExpression
{
    public function new()
    {
        // parent always gotta be starting something
        super();

        // and now
        this.command = "inventory";

        // aliases for the basic command itself
        this.aliases.push("i");

        // help text
        this.helpShow    = true;
        this.helpExample = "<inventory | i>";
        this.helpString  = "Take a look at your own inventory.";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        if (0 == actor.inventory.list().length)
        {
            env.outStream("You aren't carrying anything.");
        }
        else
        {
            // let's just get that list and dump it, yeah baby
            env.outStream("You are currently carrying:");

            var itemList:String = "";

            for (item in actor.inventory.list())
            {
                itemList = itemList + "- " + item.name + "\n";
            }

            env.outStream(itemList);
        }
    }
}