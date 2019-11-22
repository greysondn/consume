package net.darkglass.iguttae.treewalk.token;

import net.darkglass.iguttae.treewalk.context.GlobalContext;
import net.darkglass.iguttae.treewalk.token.Token;
import net.darkglass.iguttae.treewalk.token.TokenType;
import net.darkglass.iguttae.treewalk.token.Keywords;

/**
 * Scanner for our tokens.
 * 
 * A scanner just tries to find where tokens begin and end. It doesn't even lex
 * them. It's literally just the first step.
 * 
 */
class Scanner
{
    /**
     * Source we're emitting tokens from.
     */
    private var source:String = "";

    /**
     * Global context we're operating in. Mostly used for output.
     */
    private var global:GlobalContext;

    /**
     * tokens we've scanned
     */
    private var tokens:Array<Token> = new Array<Token>();

    private var start:Int = 0;
    private var current:Int = 0;
    private var line:Int = 1;

    /**
     * Constructor.
     * 
     * @param _source source of tokens for scanner to emit.
     */
    public function new(_global:GlobalContext, _source:String)
    {
        this.source  = _source;
        this.global = _global;
    }

    /**
     * Scan all the tokens in our source
     * 
     * @return Array<Token> all the tokens in our source
     */
    public function scanTokens():Array<Token>
    {
        while (!this.isAtEnd())
        {
            this.start = this.current;
            this.scanToken();
        }

        // mark end of file for the interpreter
        this.tokens.push(new Token(EOF, "", null, this.line));

        // return as promised
        return this.tokens;
    }

    /**
     * Decide whether or not we're at the end of our source input.
     * 
     * @return Bool whether or not we're at the end of source input.
     */
    private function isAtEnd():Bool
    {
        return (this.current >= this.source.length);
    }

    /**
     * Scans for the next token in source and stores it in tokens.
     */
    private function scanToken():Void
    {
        // only store one character in this!
        var char:String = this.advance();

        switch (char)
        {
            // single symbols
            case ".":
                this.addTokenViaType(DOT);
            case ",":
                this.addTokenViaType(COMMA);
            
            case "+":
                this.addTokenViaType(PLUS);
            case "-":
                this.addTokenViaType(MINUS);
            case "*":
                this.addTokenViaType(STAR);

            case ";":
                this.addTokenViaType(SEMICOLON);

            // pairs
            case "(":
                this.addTokenViaType(LEFT_PAREN);
            case ")":
                this.addTokenViaType(RIGHT_PAREN);
            case "{":
                this.addTokenViaType(LEFT_BRACE);
            case "}":
                this.addTokenViaType(RIGHT_BRACE);
            case "[":
                this.addTokenViaType(LEFT_BRACK);
            case "]":
                this.addTokenViaType(RIGHT_BRACK);

            // could be one or two symbols
            case "!":
                if (this.match("="))
                {
                    // !=
                    this.addTokenViaType(NOT_EQUAL);
                }
                else
                {
                    // !
                    this.addTokenViaType(NOT);
                }
            case "=":
                if (this.match("="))
                {
                    // ==
                    this.addTokenViaType(IS_EQUAL);
                }
                else
                {
                    // =
                    this.addTokenViaType(ASSIGNMENT);
                }
            case "<":
                if (this.match("="))
                {
                    // <=
                    this.addTokenViaType(LESS_THAN_OR_EQUAL);
                }
                else
                {
                    // <
                    this.addTokenViaType(LESS_THAN);
                }
            case ">":
                if (this.match("="))
                {
                    // >=
                    this.addTokenViaType(GREATER_THAN_OR_EQUAL);
                }
                else
                {
                    // >
                    this.addTokenViaType(GREATER_THAN);
                }

            // special might be two case
            case "/":
                if (this.match("/"))
                {
                    // that's // - a line comment
                    // so we go to the end of the line
                    while ((this.peek() != "\n") && (!this.isAtEnd()))
                    {
                        this.advance();
                    }
                }
                else
                {
                    // just /
                    this.addTokenViaType(SLASH);
                }
            
            // whitespace, whee?
            case ' ':
                // pass
            case '\r':
                // pass
            case '\t':
                // pass
                
            case '\n':
                // oh, hey, a newline
                this.line = this.line + 1; 

            // literals
            case "\"":
                this.scanString();

            // fallback
            default:
                if (this.isDigit(char))
                {
                    this.scanNumber();
                }
                else if (this.isAlpha(char))
                {
                    this.scanIdentifier();
                }
                else
                {
                    this.global.error(line, "Unexpected character: " + char);
                }
        }
    }

    /**
     * Advances the position of this scanner and spits out the previous symbol.
     * 
     * @return String the symbol we just advanced past.
     */
    private function advance():String
    {
        this.current = this.current + 1;
        return this.source.charAt(this.current - 1);
    }

    /**
     * Add a token using just its type.
     * 
     * CI suggests an overloaded method but those don't really exist in Haxe so
     * I've gone ahead and broken it into two methods.
     * 
     * @param _type the token's type.
     */
    private function addTokenViaType(_type:TokenType):Void
    {
        this.addToken(_type, null);
    }

    /**
     * Add a token with its literal
     * 
     * @param _type     the token's type
     * @param _literal  the token's literal
     */
    private function addToken(_type:TokenType, _literal:Dynamic):Void
    {
        var text:String = this.source.substring(start, current);
        this.tokens.push(new Token(_type, text, _literal, line));
    }

    /**
     * Try to match the next symbol via a small lookahead
     * 
     * @param _expected     the expected symbol
     * @return Bool         whether or not that symbol is a match
     */
    private function match(_expected:String):Bool
    {
        // eventual return
        var ret:Bool = false;

        // figure this out
        if (this.isAtEnd())
        {
            // can't possibly be expected symbol because we're done
            ret = false;
        }
        else if (source.charAt(current) != _expected)
        {
            // well, it's not the expected one so
            ret = false;
        }
        else
        {
            // oh, hey, it's the expected symbol!
            this.current = this.current + 1;
            ret = true;
        }

        // end
        return ret;
    }

    /**
     * Peeks the next character.
     * 
     * @return String next character, or the NULL terminator if we're at EOF.
     */
    private function peek():String
    {
        var ret:String = "";

        if (this.isAtEnd())
        {
            ret = "\x00";
        }
        else
        {
            ret = this.source.charAt(current);
        }

        return ret;
    }

    /**
     * Scan what should be a string and add the token to our token list
     */
    private function scanString():Void
    {
        while((this.peek() != "\"") && (!isAtEnd()))
        {
            if (peek() == "\n")
            {
                this.line = this.line + 1;
            }

            this.advance();
        }

        if (this.isAtEnd())
        {
            // unterminated string
            this.global.error(line, "Unterminated string.");
        }
        else
        {
            // was terminated, oh my!
            // grab closing quote
            this.advance();

            // trim quotes
            var _value:String = this.source.substring(this.start + 1, this.current - 1);
            this.addToken(STRING, _value);
        }
    }

    /**
     * Determines whether character is a digit.
     * 
     * There's got to be faster ways to do this.
     * 
     * @param _char character
     * @return Bool whether it's a digit
     */
    private function isDigit(_char:String):Bool
    {
        var ord = _char.charCodeAt(0);
        return ((ord >= "0".charCodeAt(0)) && (ord <= "9".charCodeAt(0)));
    } 

    /**
     * Scan what should be a number and add the token to our token list
     */
    private function scanNumber():Void
    {
        // first batch of digits
        while(this.isDigit(this.peek()))
        {
            this.advance();
        }

        // advance if it's digits
        if ((this.peek() == ".") && (this.isDigit(this.peekNext())))
        {
            advance();
            while(this.isDigit(this.peek()))
            {
                this.advance();
            }
        }

        // add the token now
        this.addToken(NUMBER, Std.parseFloat(this.source.substring(this.start, this.current)));
    }
    
    /**
     * Peeks the next symbol. (The one after peek().)
     * 
     * @return String next symbol, or NULL terminator if it's past EOF
     */
    private function peekNext():String
    {
        var ret:String = "";

        if (this.current + 1 >= this.source.length)
        {
            ret = "\x00";
        }
        else
        {
            ret = this.source.charAt(this.current + 1);
        }

        return ret;
    }

    /**
     * Decides whether or not a character is alphabetic.
     * 
     * @param _char character to decide.
     * 
     * @return Bool whether character is alphabetic.
     */
    private function isAlpha(_char:String):Bool
    {
        var code:Int = _char.charCodeAt(0);

        return ((code >= "a".code) && (code <= "z".code)) ||
               ((code >= "A".code) && (code <= "Z".code)) ||
               (code == "_".code);
    }

    /**
     * Decides is a given character is an alphanumeric character
     * 
     * @param _char character to decide
     * 
     * @return Bool whether the given character is alphanumeric
     */
    private function isAlphaNumeric(_char:String):Bool
    {
        return (this.isAlpha(_char) || this.isDigit(_char));
    }

    /**
     * Peeks what should be an identifier and adds it to the token list.
     */
    private function scanIdentifier():Void
    {
        while(this.isAlphaNumeric(this.peek()))
        {
            this.advance();
        }

        // let's check for reserved words
        var text:String = source.substring(start, current);

        // need the object holding our keywords for us here
        var keywords:Keywords = Keywords.create();
        var kw:Map<String, TokenType> = keywords.dict;

        // check for it
        if (kw.exists(text))
        {
            // that's a keyword!
            this.addTokenViaType(kw[text]);
        }
        else
        {
            // that should be an identifier!
            this.addTokenViaType(IDENTIFIER);
        }
    }
}