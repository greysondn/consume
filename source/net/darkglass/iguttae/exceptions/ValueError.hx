package net.darkglass.iguttae.exceptions;

import net.darkglass.iguttae.exceptions.Error;

class ValueError extends Error
{
    public function new(str:String)
    {
        // let parent do its thing
        super(str);
        
        this.name = "ValueError";
    }
}