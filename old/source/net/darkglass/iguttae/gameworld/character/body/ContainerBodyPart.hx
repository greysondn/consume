package net.darkglass.iguttae.gameworld.character.body;

class ContainerBodyPart
{
    /**
     * Whether this actually exists
     */
    public var exists:Bool = false;

    /**
     * Whether this is producing, whatever that means
     * 
     * breasts - whether we're lactating
     * testes  - whether we're able to produce spunk
     * stomach - whether digestion leads to bowels
     * bowels  - whether digestion fills bowels
     */
    public var isProducing:Bool = false;

    /**
     * Measure of this thing, whatever that means
     * 
     * replaces:
     * breastSize
     * ballSize
     */
    public var measure:Float = 0.0;

    /**
     * Capacity of this thing, whatever that means
     * 
     * for the stomach, this is in cubic inches
     * for the bowels, this is in cubic inches
     * for the breats, this is in gallons
     * for the testes, this is in ounces
     * 
     * 
     */
    public var capacity:Float = 0.0;

    /**
     * Gains this thing gets, whatever that means
     */
    public var gains:Float = 0.0;

    /**
     * Stretch time of this thing, whatever that means
     */
    public var stretchTime:Float = 0.0;

    /**
     * Amount this stretches per time, whatever that means
     */
    public var stretchAmount:Float = 0.0;

    /**
     * Amount of damage this does per time, whatever that means
     */
    public var damage:Float = 0.0;

    /**
     * There's no constructor that's going to go deep enough.
     * 
     * Set this all by hand.
     */
    public function new() {}

    public function clone():ContainerBodyPart
    {
        var ret:ContainerBodyPart = new ContainerBodyPart();

        ret.exists = this.exists;
        ret.isProducing = this.isProducing;
        ret.measure = this.measure;
        ret.capacity = this.capacity;
        ret.gains = this.gains;
        ret.stretchTime = this.stretchTime;
        ret.stretchAmount = this.stretchAmount;
        ret.damage = this.damage;

        return ret;
    }
}