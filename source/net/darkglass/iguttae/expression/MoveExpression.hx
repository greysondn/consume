package net.darkglass.iguttae.expression;
import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.expression.clause.DirectionClause;

class MoveExpression extends BaseExpression
{
    // helper for processing directions yo
    private var dirClause:DirectionClause = new DirectionClause();

    public function new()
    {
        // parent
        super();

        // and now
        this.command = "move";

        // aliases for the basic command itself
        this.aliases.push("go");

        // an alias or two for every direction!
        this.aliases.push("n");
        this.aliases.push("north");

        this.aliases.push("ne");
        this.aliases.push("northeast");

        this.aliases.push("e");
        this.aliases.push("east");

        this.aliases.push("se");
        this.aliases.push("southeast");

        this.aliases.push("s");
        this.aliases.push("south");

        this.aliases.push("sw");
        this.aliases.push("southwest");

        this.aliases.push("w");
        this.aliases.push("west");

        this.aliases.push("nw");
        this.aliases.push("northwest");

        this.aliases.push("i");
        this.aliases.push("in");

        this.aliases.push("o");
        this.aliases.push("out");

        this.aliases.push("u");
        this.aliases.push("up");

        this.aliases.push("d");
        this.aliases.push("down");

        // and help text
        this.helpShow = true;
        this.helpExample = "<move|go> [direction]";
        // feeling like this helpstring is a compelling case for externalizing
        // these strings.
        this.helpString  = "Moves in the indicated direction. You can use " + 
                           "move or go... or nothing... but direction is " +
                           "mandatory!" + "\n" +
                           "-- Valid directions -- \n" +
                           "n  | north" + "\n" +
                           "ne | northeast" + "\n" +
                           "e  | east" + "\n" +
                           "se | southeast" + "\n" +
                           "s  | south" + "\n" +
                           "sw | southwest" + "\n" +
                           "w  | west" + "\n" +
                           "nw | northwest" + "\n" +
                           "i  | in" + "\n" +
                           "o  | out" + "\n" +
                           "u  | up" + "\n" +
                           "d  | down";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        var dirStr:String = this.removeFirstWord(input);
        var destTran:Transition = this.dirClause.stringToExit(actor, dirStr, env);

        // destTran will have an index of -1 if there's a problem.
        if (destTran.index != -1)
        {
            // see if it's locked
            if (destTran.locked == true)
            {
                env.outStream("That direction is apparently locked, so you can't go there right now.");
            }
            else
            {
                // should be fine
                this.doMove(actor, destTran.target, env);
            }
        }

        // end eval, returns void
    }

    private function doMove(actor:Actor, dest:Actor, env:Environment)
    {
            // actually move the actor
            actor.location.inventory.remove(actor);
            actor.location = dest;
            actor.location.inventory.add(actor);

            // update location
            env.onLocationChange(actor.location.name);

            // output new description
            actor.location.describe(env);
    }
}