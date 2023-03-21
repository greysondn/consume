package net.darkglass.iguttae.gameworld.container;

import net.darkglass.iguttae.gameworld.container.EntityContainer;

/**
 * Entity container, but indexed, so each object in it is also
 * unique.
 * 
 * This means it can only contain one of each object. If you need
 * a more general container, try {@link net.darkglass.gameworld.container.EntityContainer EntityContainer}.
 */
class IndexedEntityContainer extends EntityContainer
{
    /**
     * TODO: Fix docs
     * 
     * Metalist, basically a list which should - in turn - contain this one.
     * 
     * This is done by just adding entities to the metalist, just like they're
     * added here, when asked to add.
     */
    public var metacontainer:IndexedEntityContainer;

    public function new()
    {
        // basically still half of nothing.
        super();
    }

    /**
     * TODO: Write docs
     * 
     * @param ent 
     * @return Bool whether or not it was actually added
     */
    override public function add(ent:Entity):Bool
    {
        var ret:Bool = false;

        if (-1 == this.contents.indexOf(ent))
        {
            ret = true;

            this.contents.push(ent);

            if (this.metacontainer != null)
            {
                this.metacontainer.add(ent);
            }
        }

        return ret;
    }

    /**
     * TODO: Write docs
     * 
     * @param ent 
     * @return Bool whether or not it was actually removed
     */
    override public function remove(ent:Entity):Bool
    {
        // no need for intermediary variable if we do
        // metalist first
        if (this.metacontainer != null)
        {
            this.metacontainer.remove(ent);
        }

        return this.contents.remove(ent);
    }

    public function checkIntegrity():Bool
    {
        // sort self first
        this.sort();

        // return. true if integrity exists fine
        var ret = true;

        for (i in 0...this.contents.length)
        {
            if (this.contents[i].index != i)
            {
                ret = false;
            }
        }

        return ret;
    }

    /**
     * Sort the contents of this container.
     * 
     * Due to how integrity and access is defined, this is
     * necessary to ensure proper retrieval with `get()`.
     */
    private function sort():Void
    {
        this.contents.sort(Entity.cmpIndex);
    }

    /**
     * TODO: Write docs
     * 
     * @param index 
     * @return Entity
     */
    public function get(index:Int):Entity
    {
        return this.contents[index];
    }
}