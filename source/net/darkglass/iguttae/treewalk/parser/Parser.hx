package net.darkglass.iguttae.treewalk.parser;

import net.darkglass.iguttae.treewalk.context.GlobalContext;
import net.darkglass.iguttae.treewalk.token.TokenType;
import net.darkglass.iguttae.treewalk.token.Token;
import net.darkglass.iguttae.treewalk.expression.*;
import net.darkglass.iguttae.treewalk.error.SyntaxError;


class Parser
{
    private var tokens:Array<Token>;
    private var current:Int = 0;

    /**
     * Global context we're operating in. Mostly used for output.
     */
    private var global:GlobalContext;

    public function new(_tokens:Array<Token>, _global:GlobalContext)
    {
        this.tokens = _tokens;
        this.global = _global;
    }

    // -------------------------------------------------------------------------
    // Main parser function itself
    // -------------------------------------------------------------------------
    public function parse():IExpression
    {
        var ret:IExpression = new LiteralExpr("ERR! PARSE NEVER RAN!");

        try
        {
            ret = this.expression();
        }
        catch (e:SyntaxError)
        {
            ret = new LiteralExpr("ERR! PARSER FAILED WITH SYNTAX ERROR");
        }

        return ret;
    }

    // -------------------------------------------------------------------------
    // Main expression matching functions
    // -------------------------------------------------------------------------

    // we go in preceedence order to help with sanity
    // see doc/docs/commands.ebnf


    // ebnf --> Expression
    private function expression():IExpression
    {
        return this.equality();
    }

    // ebnf --> EqualityExpr
    private function equality():IExpression
    {
        // maybe this is a child, or maybe this is left.
        // so we call it expr because we just don't know.
        // this will be the case constantly so I won't be repeating myself.
        var expr:IExpression = this.comparison();

        while (this.match([NOT_EQUAL, IS_EQUAL]))
        {
            var op:Token = this.previous();
            var right:IExpression = this.comparison();
            // this is what happens if expr turns out to be left
            expr = new BinaryExpr(expr, op, right);
        }

        return expr;
    }

    // ebnf --> ComparisonExpr
    private function comparison():IExpression
    {
        var expr:IExpression = this.addition();
        
        while (this.match([GREATER_THAN, GREATER_THAN_OR_EQUAL,
                           LESS_THAN,    LESS_THAN_OR_EQUAL]))
        {
            var op:Token = this.previous();
            var right:IExpression = this.addition();
            expr = new BinaryExpr(expr, op, right);
        }

        return expr;
    }

    // ebnf --> AddSubExpr
    private function addition():IExpression
    {
        var expr:IExpression = this.multiplication();
        
        while (this.match([MINUS, PLUS]))
        {
            var op:Token = this.previous();
            var right:IExpression = this.multiplication();
            expr = new BinaryExpr(expr, op, right);
        }
        
        return expr;
    }

    // ebnf --> MultDivExpr
    private function multiplication():IExpression
    {
        var expr:IExpression = this.unary();
        
        while (this.match([SLASH, STAR]))
        {
            var op:Token = this.previous();
            var right:IExpression = this.unary();
            expr = new BinaryExpr(expr, op, right);
        }
        
        return expr;
    }

    private function unary():IExpression
    {
        var ret:IExpression = new LiteralExpr("ERR! PARSER! UNCAUGHT UNARY");

        if (this.match([NOT, MINUS]))
        {
            var op:Token = this.previous();
            var right:IExpression = this.unary();
            ret = new UnaryExpr(op, right);
        }
        else
        {
            ret = this.primary();
        }

        return ret;
    }

    private function primary():IExpression
    {
        var ret:IExpression = new LiteralExpr("ERR! PARSER! UNCAUGHT PRIMARY");

        // TODO
        // this is missing a null token. I need to fix that.
        if (this.match([BOOLEAN]))
        {
            if (this.previous().lexeme == "true")
            {
                ret = new LiteralExpr(true);
            }
            else
            {
                ret = new LiteralExpr(false);
            }
        }
        else if (this.match([NUMBER, STRING]))
        {
            ret = new LiteralExpr(this.previous().literal);
        }
        else if (this.match([LEFT_PAREN]))
        {
            var expr:IExpression = this.expression();
            this.consume(RIGHT_PAREN, "Expect ')' after expression.");
            ret = new GroupingExpr(expr);
        }
        else
        {
            throw (this.error(this.peek(), "Expect expression."));
        }

        return ret;
    }

    // -------------------------------------------------------------------------
    // Helper functions
    // -------------------------------------------------------------------------

    private function advance():Token
    {
        if (!this.isAtEnd())
        {
            this.current = this.current + 1;
        }

        return this.previous();
    }

    private function check(_type:TokenType):Bool
    {
        var ret:Bool = false;

        if (this.isAtEnd())
        {
            ret = false;
        }
        else
        {
            ret = this.peek().type == _type;
        }

        return ret;
    }

    private function consume(_type:TokenType, _message:String)
    {
        var ret:Token = new Token(STRING, "PARSER! CONSUME FAILED!", null, 100);

        if (this.check(_type))
        {
            ret = this.advance();
        }
        else
        {
            throw (this.error(this.peek(), _message));
        }
    }

    private function error(_token:Token, _message:String):SyntaxError
    {
        global.errorOnToken(_token, _message);
        return (new SyntaxError("???", _token.line, -1, _token.lexeme));
    }

    private function isAtEnd():Bool
    {
        return this.peek().type == EOF;
    }

    private function match(_types:Array<TokenType>):Bool
    {
        var ret:Bool = false;

        for (_type in _types)
        {
            if (this.check(_type))
            {
                this.advance();
                ret = true;
            }
        }

        return ret;
    }

    private function peek():Token
    {
        return this.tokens[current];
    }

    private function previous():Token
    {
        return this.tokens[current - 1];
    }

    private function synchronize():Void
    {
        // get past the known bad symbol, right off
        this.advance();

        // we'll eject on a sync
        var eject:Bool = false;

        // and now to go until we need to eject...
        while(!eject)
        {
            if (this.isAtEnd())
            {
                // end of file? Sync.
                eject = true;
            }
            else if (this.previous().type == SEMICOLON)
            {
                // end of line? Sync.
                eject = true;
            }
            else
            {
                // needed a switch block for my sanity's sake
                switch (peek().type)
                {
                    // CLASS
                    // FUN
                    // VAR
                    // FOR
                    case IF:
                        eject = true;
                    // WHILE
                    // PRINT
                    // RETURN
                    default:
                        // advance because we've not found a symbol we can sync
                        // via
                        this.advance();
                }
            }
        }
    }
}