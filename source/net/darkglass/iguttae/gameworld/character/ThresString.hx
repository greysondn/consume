package net.darkglass.iguttae.gameworld.character;

/**
 * Many strings have thresholds against their values.
 * 
 * For example, if the value is less than or equal to 5, do this; else
 * if it is less than 8 do something else.
 * 
 * This exists to give a structure and standard interface to that
 * construction. Because I hate it with a passion.
 */
class ThresString
{
    /**
     * The actual contents - threshold/value pairs.
     */
    private var contents:Array<ThresValue>;

    /**
     * Fallback if no value ever matches when asked to check.
     */
    private var overflow:String = "OVERLOAD";

    /**
     * @param overloadValue value to default to if nothing else matches.
     */
    public function new(overloadValue:String)
    {
        this.contents = new Array<ThresValue>();
        this.overflow = overloadValue;
    }

    /**
     * Adds a new threshold value. WARNING! Does not provide sorting!
     * 
     * @param threshold  threshold
     * @param value      value
     */
    public function insert(threshold:Float, value:String)
    {
        var swp:ThresValue = new ThresValue();
        swp.thres = threshold;
        swp.val   = value;
        
        this.contents.push(swp);
        this.sort();
    }
    
    /**
     * Not exactly sure how sorts are defined for Haxe, so I'm just kinda
     * winging this with a custom bubble sort here. Probably sucks. I don't
     * really care, it's not meant for large sets.
     */
    public function sort()
    {
        // swap through space for one of the two thres values.
        var swp:ThresValue = new ThresValue();

        // whether we found something in the wrong place on our
        // last pass
        var found:Bool = false;

        // whether we're to continue trying to sort
        var continueSorting:Bool = true;

        // main sort loop
        while(continueSorting)
        {
            // sanity check so we don't out of bounds by accident
            if (this.contents.length > 1)
            {
                // proceed through elements in order
                for (i in 1...this.contents.length)
                {
                    // compare current to previous
                    // does previous go after this one?
                    if (this.contents[i].thres < this.contents[i-1].thres)
                    {
                        // swap them, using the swp as a small buffer
                        swp = this.contents[i-1];
                        this.contents[i-1] = this.contents[i];
                        this.contents[i] = swp;

                        // we found one in the wrong place
                        found = true;
                    }
                }
            }

            // check if we found one in the wrong place
            if (found)
            {
                // yes
                
                // reset
                found = false;
                
                // make sure continueSorting has the correct value
                continueSorting = true;
            } else
            {
                // no

                // stop sorting, we're done!
                continueSorting = false;
            }
        }
    }

    /**
     * Get the string corrosponding to a given threshold value.
     * 
     * @param threshold Comparisons are less than or equal some value x
     *                         to input threshold.
     * @return String   string corrosponding to input threshold.
     */
    public function get(threshold:Float):String
    {
        ret = this.overflow;

        // just iterate through and find the last one we're less than.
        for (i in 0...this.contents.length)
        {
            if (threshold <= this.contents[i].thres)
            {
                ret = this.contents[i].val;
            }
        }

        return ret;
    }
}

/**
 * The actual internal structure to describe these is just a
 * pairing.
 */
typedef ThresValue =
{
    thres:Float,
    val:String
};