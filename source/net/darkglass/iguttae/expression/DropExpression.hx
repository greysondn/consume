package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.Entity;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.expression.clause.ItemClause;

class DropExpression extends BaseExpression
{
    // yeah, I'll need this
    private var outStream:String -> Void;

    public function new()
    {
        // parent always gotta be starting something
        super();

        // and now
        this.command = "drop";

        // aliases for the basic command itself
        this.aliases.push("d");

        // help text
        this.helpShow    = true;
        this.helpExample = "<drop | d> [item]";
        this.helpString  = "Attempt to drop item from inventory. Should fall " +
                           "into current location.";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // what?
        var what:String = this.removeFirstWord(input);

        // set outstream in case we need it
        this.outStream = env.outStream;

        // create clause
        var itemClause:ItemClause = new ItemClause();

        // try to get it
        var item:Actor = itemClause.fromInv(actor, what, this.onAmbiguity, this.onNone);

        // that sets item index to -1 if it's invalid
        if (-1 != item.index)
        {
            if (actor.location.inventory.add(item))
            {
                // set location and say it
                item.location.inventory.remove(item);
                item.location = actor.location;
                env.outStream("You dropped " + item.name);
            }
            else
            {
                // you couldn't do it
                env.outStream("For whatever reason, you couldn't drop " + what);
            }
        }
    }

    private function onAmbiguity(list:Array<Actor>):Void
    {
        this.outStream("Which item did you mean? There's multiple that " + 
                "might match what you asked for. They are:");

        // oh no!
        var itemList:String = "";

        for (item in list)
        {
            itemList = itemList + "- " + item.name + "\n";
        }

        this.outStream(itemList);
    }

    private function onNone(item:String):Void
    {
        this.outStream("There's no " + item + " in your inventory.");
    }
}