package net.darkglass.iguttae.exceptions;

import net.darkglass.iguttae.exceptions.ValueError;

class CompassError extends ValueError
{
    public function new(msg:String)
    {
        super(msg);
        this.name = "CompassError";
    }
}