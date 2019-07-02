package net.darkglass.iguttae.gameworld.character.body;

class Measurement
{
    /**
     * Minimum valid measure for this
     */
    public var min:Float;

    /**
     * Maximum valid measure for this
     */
    public var max:Float;

    /**
     * Current measure for this
     */
    public var cur:Float;

    /**
     * Does the thing!
     * 
     * @param minimum lowest valid measure for this.
     * @param maximum highest valid measure for this.
     * @param current current measure for this. Defaults to zero.
     */
    public function new(minimum:Float, maximum:Float, ?current:Float = 0.0)
    {
        this.min = minimum;
        this.max = maximum;
        this.cur = current;
    }
}