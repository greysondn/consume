package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.gameworld.Entity;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;

class GetExpression extends BaseExpression
{
    
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
        // where?
        var loc:Actor = actor.location;

        // what?
        var item:String = this.removeFirstWord(input);

        // try to get it
        var locItems:Array<Entity> = loc.inventory.getAllAnswering(item);

        // check it
        if (0 == locItems.length)
        {
            // nobody here but us chicken
            env.outStream("There's no " + item + " here.");
        }
        else if (1 == locItems.length)
        {
            // only one, we can do this
            var actualItem:Actor = cast(locItems[0], Actor);

            if (actor.inventory.add(actualItem))
            {
                // set location and say it
                actualItem.location.inventory.remove(actualItem);
                actualItem.location = actor;
                env.outStream("You picked up " + actualItem.name);
            }
            else
            {
                // you couldn't do it
                env.outStream("For whatever reason, you couldn't pick up " + item);
            }
        }
        else
        {
            // more than one, ask to disambiguate
            env.outStream("Which item did you mean? There's multiple that " + 
                            "might match what you asked for. They are:");

            // oh no!
            var itemList:String = "";

            for (item in locItems)
            {
                itemList = itemList + "- " + item.name + "\n";
            }

            env.outStream(itemList);
        }
    }
}