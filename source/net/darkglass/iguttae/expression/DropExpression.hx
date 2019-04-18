package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.Entity;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;

class DropExpression extends BaseExpression
{
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
        // where?
        var loc:Actor = actor.location;

        // what?
        var what:String = this.removeFirstWord(input);

        // try to get it
        var actorItems:Array<Entity> = actor.inventory.getAllAnswering(what);

        // make item pool unique-ish
        var actorItemsUniq:Array<Entity> = this.removeDuplicates(actorItems);

        // check it
        if (0 == actorItemsUniq.length)
        {
            // nobody here but us chicken
            env.outStream("There's no " + what + " in your inventory.");
        }
        else if (1 == actorItemsUniq.length)
        {
            // only one, we can do this
            var actualItem:Actor = cast(actorItemsUniq[0], Actor);

            if (actor.location.inventory.add(actualItem))
            {
                // set location and say it
                actualItem.location.inventory.remove(actualItem);
                actualItem.location = actor.location;
                env.outStream("You dropped " + actualItem.name);
            }
            else
            {
                // you couldn't do it
                env.outStream("For whatever reason, you couldn't drop " + what);
            }
        }
        else
        {
            // more than one, ask to disambiguate
            env.outStream("Which item did you mean? There's multiple that " + 
                            "might match what you asked for. They are:");

            // oh no!
            var itemList:String = "";

            for (item in actorItemsUniq)
            {
                itemList = itemList + "- " + item.name + "\n";
            }

            env.outStream(itemList);
        }
    }
}