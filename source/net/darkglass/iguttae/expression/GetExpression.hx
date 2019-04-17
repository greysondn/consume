package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
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

        // ask if it has any
        if (loc.hasAnyAnswering(item))
        {
            // has something anyway, so let's get it
            var itemHere:Array<Actor> = loc.getAllAnswering(item);

            // just one?
            if (1 == itemHere.length)
            {
                // just one, can try it
                var actualItem:Actor = itemHere[0];

                if(actor.hold(actualItem))
                {
                    // say it!
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

                for (item in itemHere)
                {
                    itemList = itemList + "- " + item.name + "\n";
                }

                env.outStream(itemList);
            }

        }
        else
        {
            // has no such thing
            env.outStream("There's no " + item + " here.");
        }

    }
}