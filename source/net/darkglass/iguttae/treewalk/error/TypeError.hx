package net.darkglass.iguttae.treewalk.error;

import net.darkglass.iguttae.treewalk.error.Error;
import net.darkglass.iguttae.treewalk.token.Token;

/**
 * Signifier class, expresses that an input to a function was wrong type.
 * 
 * Related to the python error of the same name
 * https://docs.python.org/3/library/exceptions.html#TypeError
 */
class TypeError extends Error
{
    public var message:String;
    public var token:Token;

    public function new(_token:Token, _message:String)
    {
        super();

        this.message = _message;
        this.token   = _token;
    }
}