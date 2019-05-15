package net.darkglass.iguttae.expression.clause;

import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.environment.Environment;

class DirectionClause
{
    public function new()
    {
        // half of nothing!
    }

    public function stringToExit(actor:Actor, str:String, env:Environment):Transition
    {
        // placeholder
        var ret:Transition = new Transition();
        ret.index = -1;

        // get the compass bearing
        var exitCompass:Compass = this.stringToCompass(str, env);

        // so we would have output the error string, whatever
        // now we make sure that's valid anyway
        if (exitCompass != Compass.INVALID)
        {
            // and now try to get the exit in question
            if (actor.location.exits[exitCompass] == null)
            {
                // doesn't exist
                env.outStream("There's no exit in that direction.");
            }
            else
            {
                // it exists!
                ret = actor.location.exits[exitCompass];
            }
        }

        // and now we
        return ret;
    }

    /**
     * Helper function to determine compass based on string
     * 
     * @param str string input
     * 
     * @return Compass corrosponding to str, or Compass.INVALID if none corrosponds
     */
    public function stringToCompass(str:String, env:Environment):Compass
    {
        // eventual return
        var ret:Compass = Compass.INVALID;

        // convert to lowercase so I can have simpler checks
        var swp:String = str.toLowerCase();

        // this is all pretty straightforward
        if (("n" == swp) || ("north" == swp))
        {
            ret = Compass.NORTH;
        }
        else if (("ne" == swp) || ("northeast" == swp))
        {
            ret = Compass.NORTHEAST;
        }
        else if (("e" == swp) || ("east" == swp))
        {
            ret = Compass.EAST;
        }
        else if (("se" == swp) || ("southeast" == swp))
        {
            ret = Compass.SOUTHEAST;
        }
        else if (("s" == swp) || ("south" == swp))
        {
            ret = Compass.SOUTH;
        }
        else if (("sw" == swp) || ("southwest" == swp))
        {
            ret = Compass.SOUTHWEST;
        }
        else if (("w" == swp) || ("west" == swp))
        {
            ret = Compass.WEST;
        }
        else if (("nw" == swp) || ("northwest" == swp))
        {
            ret = Compass.NORTHWEST;
        }
        else if (("i" == swp) || ("in" == swp))
        {
            ret = Compass.IN;
        }
        else if (("o" == swp) || ("out" == swp))
        {
            ret = Compass.OUT;
        }
        else if (("u" == swp) || ("up" == swp))
        {
            ret = Compass.UP;
        }
        else if (("d" == swp) || ("down" == swp))
        {
            ret = Compass.DOWN;
        }

        // handling
        if (Compass.INVALID == ret)
        {
            // there's no direction, whee
            env.outStream("That wasn't a direction.");
        }

        // return
        return ret;
    }
}