package net.darkglass.iguttae.expression;
import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.exceptions.CompassError;

class MoveExpression extends BaseExpression
{
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
        // decipher command
        var breakPoint:Int  = input.indexOf(" ");
        var dirStr:String = "";
        var continueEval:Bool = false;
    

        // if the breakpoint even exists - it very well may not
        if (-1 == breakPoint)
        {
            // then we should be looking at string already
            dirStr = input;
        }
        else
        {
            // break and you got it
            dirStr = input.substring(breakPoint + 1);
        }

        // so if this errors, we'll just stop running
        // scope direction
        var dirCom:Compass = Compass.NORTH;

        try
        {
            dirCom = env.stringToCompass(dirStr);
            continueEval = true;
        }
        catch (e:CompassError)
        {
            // we can just put out an error on that
            env.outStream("Couldn't understand move command (did you type it correctly?)");
            continueEval = false;
        }

        // and so it continues, I suppose
        var destTran:Null<Transition> = null;

        if (continueEval)
        {
            // try to get a destination
            destTran = actor.location.exits[dirCom];

            if (destTran == null)
            {
                // doesn't exist
                env.outStream("There's no exit in that direction.");
                continueEval = false;
            }
            else
            {
                // exists

                // see if it's locked
                if (destTran.locked == true)
                {
                    env.outStream("That direction is apparently locked, so you can't go there right now.");
                    continueEval = false;
                }
            }
        }

        if (continueEval)
        {
            // actually move the actor
            actor.location.remove(actor);
            actor.location = destTran.target;
            actor.location.insert(actor);

            // update location
            env.onLocationChange(actor.location.name);

            // output new description
            actor.location.describe(env);
        }
    }
}