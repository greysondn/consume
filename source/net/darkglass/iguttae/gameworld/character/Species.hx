package net.darkglass.iguttae.gameworld.character;

import net.darkglass.iguttae.gameworld.character.body.ContainerBodyPart;
import net.darkglass.iguttae.gameworld.character.body.BodyPartCollection;
import net.darkglass.iguttae.gameworld.character.body.Measurement;

class Species
{
    public var index:Int = -1;
    public var name:String = "SPECIES_NAME";

    /**
     * All the parts of this species' bodies.
     */
    public var bodyParts:BodyPartCollection = new BodyPartCollection();

    public var height:Measurement = new Measurement(0, 0);
    public var weight:Measurement = new Measurement(0, 0);
    public var chest:Measurement  = new Measurement(0, 0);
    public var waist:Measurement  = new Measurement(0, 0);
    public var hips:Measurement   = new Measurement(0, 0);
    public var butt:Measurement   = new Measurement(0, 0);

    public var testes:ContainerBodyPart  = new ContainerBodyPart();
    public var breasts:ContainerBodyPart = new ContainerBodyPart();
    public var stomach:ContainerBodyPart = new ContainerBodyPart();
    public var bowels:ContainerBodyPart  = new ContainerBodyPart();

    /**
     * This has to be done manually I think. I know that's a bummer.
     */
    public function new(){}

    /**
     * TODO: Write docs
     * 
     * @return Species
     */
    public function clone():Species
    {
        // seed
        var ret:Species = new Species();

        // clone all properties into this
        ret.index     = this.index;
        ret.name      = this.name;

        ret.bodyParts = this.bodyParts.clone();

        ret.height = this.height.clone();
        ret.weight = this.weight.clone();
        ret.chest  = this.chest.clone();
        ret.waist  = this.waist.clone();
        ret.hips   = this.hips.clone();
        ret.butt   = this.butt.clone();

        ret.testes = this.testes.clone();
        ret.breasts = this.breasts.clone();
        ret.stomach = this.stomach.clone();
        ret.bowels  = this.bowels.clone();

        return ret;
    }
}