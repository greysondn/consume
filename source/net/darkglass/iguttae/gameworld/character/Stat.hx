package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.item.Item;

/**
 * Represents a statistic
 */
class Stat
{
    /**
     * The base value for this, basically if the character
     * was nude and unaffected, this would be the stat
     */
    public var base:Int = 0;

    /**
     * A flat modifier. Typically needed for health.
     */
    public var mod:Int = 0;

    /**
     * changes due to equipment
     */
    public var equipModifiers:Map<Item, Int> =  [];

    /**
     * Add a piece of equipment
     */
    public function addEquipment(item:Item, value:Int):Void
    {
        this.equipModifiers.set(item, value);
    }

    /**
     * Remove a piece of equipment
     */
    public function removeEquipment(item:Item):Void
    {
        this.equipModifiers.remove(item);
    }

    /**
     * The current effective value
     */
    public var current(get, null):Int;

    public function get_current():Int
    {
        var ret:Int = this.base;

        ret = ret + this.mod;

        for (key in this.equipModifiers.keys())
        {
            ret = ret + this.equipModifiers[key];
        }

        return ret;
    }

    public function new()
    {
        // pass, really.
    }
}