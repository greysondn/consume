package net.darkglass.iguttae.gameworld.character;

class SpeciesIndex
{
    private var contents:Array<Species> = [];

    public function new()
    {
        // lot of nothing
    }

    public function add(member:Species):Bool
    {
        var ret:Bool = false;

        if (-1 == this.contents.indexOf(member))
        {
            ret = true;

            this.contents.push(member);
        }

        return ret;
    }

    public function remove(member:Species):Bool
    {
        return this.contents.remove(member);
    }

    private function sort():Void
    {
        this.contents.sort(Species.cmpIndex);
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

    public function get(index:Int):Species
    {
        return this.contents[index];
    }
}