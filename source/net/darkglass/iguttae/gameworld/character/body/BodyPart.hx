package net.darkglass.iguttae.gameworld.character.body;

class BodyPart
{
    /**
     * Name for this specific body part
     */
    public var name:String = "BP_DESC";

    /**
     * reference id for this body part when looking up
     */
    public var id:String = "BP_ID";

    /**
     * Whether or not this is phallic in nature - grows, shrinks, has three
     * measures that relate to that, etc
     */
    public var isPhallic:Bool = false;

    public var pMultiplier:Float = 0.0;

    public var pWidth:Float = 0.0;

    public var pLength:Float = 0.0;

    /**
     * Creates a brand new spanking shiny body part
     * 
     * @param _id   the term to use to refer to this part for lookup
     * @param _name the descriptor used for this body part
     */
    public function new(_id:String, _name:String)
    {
        this.name = _name;
        this.id   = _id;
    }

    public function clone():BodyPart
    {
        // just spawn literally any old body part
        var ret:BodyPart = new BodyPart("", "");

        // copy properties into it
        ret.id = this.id;
        ret.isPhallic = this.isPhallic;
        ret.name = this.name;
        ret.pLength = this.pLength;
        ret.pMultiplier = this.pMultiplier;
        ret.pWidth = this.pWidth;

        // return
        return ret;
    }
}