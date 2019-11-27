package net.darkglass.iguttae.treewalk.context;

import net.darkglass.iguttae.treewalk.token.Token;
import net.darkglass.iguttae.treewalk.token.TokenType;

class GlobalContext
{
    public var cout:String -> Void;
    public var cerr:String -> Void;
    public var hadError:Bool = false;


    public function new()
    {
        this.cout = this.stringNull;
        this.cerr = this.stringNull;
    }

    /**
     * Sink for string inputs, does nothing.
     * 
     * @param _str input.
     */
    public function stringNull(_str:String):Void
    {
        // can you say "pass"?
    }

    /**
     * Standard output output string for errors.
     * 
     * @param _line     line error was found on
     * @param _message  message to bundle with error
     */
    public function error(_line:Int, _message:String)
    {
        this.report(_line, "", _message);
    }

    public function errorOnToken(_token:Token, _message:String):Void
    {
        if (_token.type == EOF)
        {
            this.report(_token.line, " at end", _message);
        }
        else
        {
            this.report(_token.line, ("at '" + _token.lexeme + "'"), _message);
        }
    }

    public function report(_line:Int, _where:String, _message:String)
    {
        // https://www.craftinginterpreters.com/scanning.html
        //
        // he suggests
        //
        // ```
        // Error: Unexpected "," in argument list.
        //
        //     15 | function(first, second,);
        //                                 ^-- Here.
        // ```
        //
        // that is an exercise for some other time.
        // ~ greysondn, 21 Nov 2019 19:15
        this.cerr("[line " + _line + "] Error" + _where + ": " + _message);
        this.hadError = true;
    }


}