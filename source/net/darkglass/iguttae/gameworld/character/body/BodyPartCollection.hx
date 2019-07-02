package net.darkglass.iguttae.gameworld.character.body;

/**
 * Sensible storage for body parts
 */
class BodyPartCollection
{
    /**
     * The contents of this container.
     */
    private var contents:Array<BodyPart> = [];

    public function new()
    {
        // that's it.
    }

    public function add(part:BodyPart):Bool
    {
        // eventual return
        var ret:Bool = true;

        // put item in inventory
        this.contents.push(part);

        // return
        return ret;
    }

    public function remove(part:BodyPart):Bool
    {
        // one liner
        return this.contents.remove(part);
    }

    public function list():Array<BodyPart>
    {
        return this.contents;
    }

    public function count(_id:String):Int
    {
        // eventual return
        var ret:Int = 0;

        // iterate
        for (part in this.contents)
        {
            if (part.id == _id)
            {
                ret = ret + 1;
            }
        }

        // done
        return ret;
    }

    public function has(_id:String):Bool
    {
        return (this.count(_id) > 0);
    }

    public function clone():BodyPartCollection
    {
        // eventual return
        var ret:BodyPartCollection = new BodyPartCollection();

        // systematically clone and add all members
        for (prt in this.contents)
        {
            ret.add(prt.clone());
        }

        // return
        return ret;
    }
}