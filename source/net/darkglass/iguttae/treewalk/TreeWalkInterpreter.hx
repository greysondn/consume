package net.darkglass.iguttae.treewalk;

import net.darkglass.iguttae.treewalk.context.LocalContext;
import net.darkglass.iguttae.treewalk.context.ObjectContext;
import net.darkglass.iguttae.treewalk.context.GlobalContext;
import net.darkglass.iguttae.treewalk.expression.*;
import net.darkglass.iguttae.treewalk.parser.Parser;
import net.darkglass.iguttae.treewalk.token.*;



class TreeWalkInterpreter
{
    public function new()
    {
        // that's right, half of nothing. Context free, baby!
        // ... Award yourself a brownie point if you get that joke.
    }

    public function eval(_global:GlobalContext, _object:ObjectContext, _local:LocalContext, _line:String)
    {
        // I think we end up paralelling run here
        this.run(_global, _object, _local, _line);
    }

    public function evalScript(_global:GlobalContext, _object:ObjectContext, _local:LocalContext, _script:String)
    {
        // right, this is run with some fancy features, I guess.
        for (_line in _script.split("\n"))
        {
            for (_statement in _line.split(";"))
            {
                this.run(_global, _object, _local, _statement);
            }
        }
    }

    public function run(_global:GlobalContext, _object:ObjectContext, _local:LocalContext, _source:String)
    {
        // I'm resetting this here. This might be wrong to do
        _global.hadError = false;

        // and now we move along
        var scanner:Scanner = new Scanner(_global, _source);
        var tokens:Array<Token> = scanner.scanTokens();
        var parser:Parser = new Parser(tokens, _global);
        var expr:IExpression = parser.parse();

        if (!_global.hadError)
        {
            _global.cout(new AstPrinter().print(expr));
        }
    }
}