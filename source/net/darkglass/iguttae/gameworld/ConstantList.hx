// fully ported

package net.darkglass.iguttae.gameworld;

class ConstantList
{
    /**
     * Internal list of constants
     */
    private var list:Array<Int> = [];

    /**
     * Constructor
     */
    public function new()
    {
        // nothing going on here!
    }

    /**
     * Helper function to check if a list has a constant
     * 
     * @param constant  constant to check for
     * @return Bool     whether constant is in list
     */
    public function contains(constant:Int):Bool
    {
        return (this.list.indexOf(constant) != -1);
    }

    /**
     * Add constant to list if it isn't already there
     * 
     * @param constant  constant to add to list
     */
    public function add(constant:Int):Void
    {
        if (this.list.indexOf(constant) == -1)
        {
            this.list.push(constant);
        }
    }

    /**
     * Remove constant from list if it's there
     * 
     * @param constant  constant to remove from list
     */
    public function remove(constant:Int):Void
    {
        this.list.remove(constant);
    }

    /**
     * Gets the intersection of this constant list with another constant list.
     * 
     * @param other the other list to intersect with
     * 
     * @return ConstantList containing all common between this one and that one.
     */
    public function getIntersectionWith(other:ConstantList):ConstantList
    {
        var ret:ConstantList = new ConstantList();

        for (entry in this.list)
        {
            if (other.contains(entry))
            {
                ret.add(entry);
            }
        }

        return ret;
    }

    /**
     * Clone this list
     * 
     * @return ConstantList a new list that is a clone of this list.
     */
    public function clone():ConstantList
    {
        var ret:ConstantList = new ConstantList();

        for (entry in this.list)
        {
            ret.add(entry);
        }

        return ret;
    }
}