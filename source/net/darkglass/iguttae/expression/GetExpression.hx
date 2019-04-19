package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.Entity;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.expression.clause.ItemClause;

class GetExpression extends BaseExpression
{
    // yeah, I'll need this
    private var outStream:String -> Void;

    public function new()
    {
        // parent always gotta be starting something
        super();

        // and now
        this.command = "get";

        // aliases for the basic command itself
        this.aliases.push("g");

        // help text
        this.helpShow    = true;
        this.helpExample = "<get | g> [item]";
        this.helpString  = "Attempt to pick up [item] from current location " +
                           "and add it to your inventory.";
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
        var item:Actor = itemClause.fromLoc(actor, what, this.onAmbiguity, this.onNone);

        // well then. That will set -1 for index if it failed.
        if (-1 != item.index)
        {
            // set location and say it
            item.location.inventory.remove(item);
            actor.inventory.add(item);
            item.location = actor;
            env.outStream("You picked up " + item.name);
        }
    }

    // actor:Actor, itemName:String, onAmbiguity:Array<Actor> -> String -> Void, onNone:String -> Void

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
        this.outStream("There's no " + item + " here.");
    }
}