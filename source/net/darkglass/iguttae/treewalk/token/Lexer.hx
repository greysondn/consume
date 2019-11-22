package net.darkglass.iguttae.treewalk.token;

import net.darkglass.iguttae.treewalk.token.Token;
import net.darkglass.iguttae.treewalk.token.TokenType;

class Lexer
{
    /**
     * The script we're lexing, hopefully
     */
    private var source:String;

    /**
     * Our lexed tokens, in order no less.
     */
    private var tokens:Array<Token> = [];


    private var start:Int   = 0;
    private var current:Int = 0;
    private var line:Int    = 1; 

    /**
     * Create a new lexer.
     * 
     * @param _source String form source of what we're lexing.
     */
    public function new(_source:String)
    {
        this.source = _source;
    }

    public function scanTokens():Array<Token>
    {
        while (!this.isAtEnd())
        {
            start = current;
            this.scanToken();
        }

        this.tokens.push(new Token(EOF, "", null, line));
        return this.tokens;
    }

    /**
     * Decide if we're at the end of our source file
     * 
     * @return Boolean Whether we're at the end of our source file
     */
    private function isAtEnd():Bool
    {
        return (this.current >= this.source.length);
    }

    private function scanToken():Void
    {
        var _cha:String = this.advance();

        switch (_cha) {
            // all the singles, just a starting selection
            case '.':
                this.addToken(DOT);
            case ',':
                this.addToken(COMMA);

            case '+':
                this.addToken(PLUS);
            case '-':
                this.addToken(MINUS);
            case '*':
                this.addToken(STAR);
            // SLASH
            
            case ';':
                this.addToken(SEMICOLON);

            // ASSIGNMENT

            // Some of the pairs, too!
            case '(':
                this.addToken(LEFT_PAREN);
            case ')':
                this.addToken(RIGHT_PAREN);
            case '{':
                this.addToken(LEFT_BRACE);
            case '}':
                this.addToken(RIGHT_BRACE);
            // LEFT_BRACK
            // RIGHT_BRACK
        }
    }

    private function advance():String
    {
        this.current = this.current + 1;
        return source.charAt(this.current - 1);
    }

    private function addToken(_type:TokenType, _literal:Dynamic = null):Void
    {
        var _text:String = source.substring(this.start, this.current);
        this.tokens.push(new Token(_type, _text, _literal, this.line));
    }
}