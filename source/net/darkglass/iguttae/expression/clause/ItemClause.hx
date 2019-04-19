package net.darkglass.iguttae.expression.clause;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.Entity;

class ItemClause
{
    public function new()
    {
        // nothing going on here.
    }

    public function fromInv(actor:Actor, itemName:String, onAmbiguity:Array<Actor> -> Void, onNone:String -> Void):Actor
    {
        // ah boy.
        var ret:Actor = new Actor();

        // begin.
        var swp:Array<Actor> = this.getAllFrom(actor, itemName);

        // uniquify
        swp = this.removeDuplicates(swp);

        // and now the "easy" part, I guess
        ret = this.thatPartBasedOnArrayLength(swp, itemName, onAmbiguity, onNone);

        // end
        return ret;
    }

    public function fromLoc(actor:Actor, itemName:String, onAmbiguity:Array<Actor> -> Void, onNone:String -> Void):Actor
    {
        // copypasta
        var ret:Actor = new Actor();

        // begin.
        var swp:Array<Actor> = this.getAllFrom(actor.location, itemName);

        // uniquify
        swp = this.removeDuplicates(swp);

        // and now the "easy" part, I guess
        ret = this.thatPartBasedOnArrayLength(swp, itemName, onAmbiguity, onNone);

        // end
        return ret;
    }

    public function matchingKeyFromInv(actor, validCombos:Array<Int>):Actor
    {
        // default is borked borked
        var ret:Actor = new Actor();
        ret.index = -1;
        
        // whether we found it
        var found:Bool = false;

        // quickly get the actual proper item list
        var swp:Array<Actor> = this.convertToActorArray(actor.inventory.list());

        // and now, this mess
        for (item in swp)
        {
            if (!found && item.isKey)
            {
                for (cCorrect in validCombos)
                {
                    for (cItem in item.combos)
                    {
                        if (cItem == cCorrect)
                        {
                            found = true;
                            ret = item;
                        }
                    }
                }
            }
        }

        // dun dun dun!
        return ret;
    }

    private function getAllFrom(actor:Actor, itemName:String):Array<Actor>
    {
        var swp:Array<Entity> = actor.inventory.getAllAnswering(itemName);
        return this.convertToActorArray(swp);
    }

    private function removeDuplicates(list:Array<Actor>):Array<Actor>
    {
        var ret:Array<Actor> = [];

        for (item in list)
        {
            var unique:Bool = true;

            for (retItem in ret)
            {
                // so the two properties I'mma check are
                // index and name. Figure if those match the dev
                // is trying to break things.
                if (item.name == retItem.name)
                {
                    if (item.index == retItem.index)
                    {
                        unique = false;
                    }
                }
            }

            if (unique)
            {
                ret.push(item);
            }
        }

        return ret;
    }

    private function convertToActorArray(incoming:Array<Entity>):Array<Actor>
    {
        var ret:Array<Actor> = [];

        for (entity in incoming)
        {
            ret.push(cast(entity, Actor));
        }

        return ret;
    }

    private function thatPartBasedOnArrayLength(list:Array<Actor>, itemName:String, onAmbiguity:Array<Actor> -> Void, onNone:String -> Void):Actor
    {
        var ret:Actor = new Actor();

        // check length
        if (0 == list.length)
        {
            // none found
            ret.index = -1;
            onNone(itemName);
        }
        else if (1 == list.length)
        {
            // thankfully exactly one found
            ret = list[0];
        }
        else
        {
            // too many found
            ret.index = -1;
            onAmbiguity(list);
        }

        return ret;
    }

    private function combine(first:Array<Actor>, second:Array<Actor>):Array<Actor>
    {
        var ret:Array<Actor> = [];

        for (entry in first)
        {
            ret.push(entry);
        }

        for (entry in second)
        {
            ret.push(entry);
        }

        return ret;
    }
}