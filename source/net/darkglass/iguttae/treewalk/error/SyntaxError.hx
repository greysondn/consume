package net.darkglass.iguttae.treewalk.error;

import net.darkglass.iguttae.treewalk.error.Error;

/**
 * Python style syntax error.
 * 
 * From the python 3 exceptions documentation, adapted for usecase:
 * https://docs.python.org/3/library/exceptions.html
 * 
 * Raised when the parser encounters a syntax error. This may occur when reading
 * the initial script or standard input (also interactively).
 * 
 * Instances of this class have attributes filename, lineno, offset and text for
 * easier access to the details.
 */
class SyntaxError extends Error
{
    public var filename:String;
    public var lineno:Int;
    public var offset:Int;
    public var text:String;

    public function new(_filename:String, _lineno:Int, _offset:Int, _text:String)
    {
        super();
        
        this.filename = _filename;
        this.lineno   = _lineno;
        this.offset   = _offset;
        this.text     = _text;
    }
}