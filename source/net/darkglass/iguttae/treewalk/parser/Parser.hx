package net.darkglass.iguttae.treewalk.parser;

import net.darkglass.iguttae.treewalk.token.TokenType;
import net.darkglass.iguttae.treewalk.token.Token;

class Parser
{
    private var tokens:Array<Token>;
    private var current:Int = 0;

    public function new(_tokens:Array<Token>)
    {
        this.tokens = _tokens;
    }

    
}