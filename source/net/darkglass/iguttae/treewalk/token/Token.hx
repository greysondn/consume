package net.darkglass.iguttae.treewalk.token;

import net.darkglass.iguttae.treewalk.token.TokenType;

class Token
{
    public var type:TokenType;
    public var lexeme:String;
    public var literal:Dynamic;
    public var line:Int;

    public function new(_type:TokenType, _lexeme:String, _literal:Dynamic, _line:Int)
    {
        this.type    = _type;
        this.lexeme  = _lexeme;
        this.literal = _literal;
        this.line    = _line;
    }

    public function toString():String
    {
        return (this.type + " " + this.lexeme + " " + this.literal);
    }
}