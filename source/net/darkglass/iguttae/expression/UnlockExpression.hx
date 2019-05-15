package net.darkglass.iguttae.expression;

import net.darkglass.iguttae.expression.BaseExpression;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.expression.clause.DirectionClause;
import net.darkglass.iguttae.gameworld.map.Transition;


class UnlockExpression extends BaseExpression
{
    /**
     * Helper to parse directions from commands
     */
    private var dirClause:DirectionClause;

    public function new()
    {
        // parent always gotta be starting something
        super();

        // internal helpers
        this.dirClause = new DirectionClause();

        // and now
        this.command = "unlock";

        // help text
        this.helpShow    = true;
        this.helpExample = "unlock [direction]";
        this.helpString  = "Attempt to unlock direction. Will automatically search inventory for a matching key.";
    }

    override public function eval(input:String, env:Environment, actor:Actor):Void
    {
        // remove first word, which will just be unlock
        var swap:String = this.removeFirstWord(input);

        // try to get a direction from which side it says
        var trans:Transition = this.dirClause.stringToExit(actor, swap, env);

        // make sure that got a transition for us
        if (trans.index != -1)
        {
            // search inventory of actor, try keys
            var foundKey:Bool = false;   // found a working key?
            var key:Actor = new Actor(); // key?

            for (item in actor.inventory.contents)
            {
                // cast to actor
                var curItem:Actor = cast(item, Actor);

                // now work with it.
                if (curItem.isKey && !foundKey)
                {
                    if (trans.unlockWithKey(curItem))
                    {
                        // found one!
                        foundKey = true;
                        key = curItem;
                    }
                }
            }

            // now if it worked out not
            if (foundKey)
            {
                // sure did
                env.outStream("Unlocked " + swap + " with " + key.name + ".");
            }
            else
            {
                // sure didn't... is it locked, even?
                if (trans.locked)
                {
                    // yeah
                    env.outStream("You don't have a key for " + swap + ".");
                }
                else
                {
                    // might be nice to tell the player it's already unlocked though.
                    env.outStream("You don't have a key for " + swap + "... but it is already unlocked, you know.");
                }
            }
        }

        // end eval, returns void
    }
}