package net.darkglass.iguttae.treewalk.expression;

// probably easier to just import the entire package
import net.darkglass.iguttae.treewalk.expression.*;

class AstPrinter implements IVisitor<String>
{
    public function new()
    {
        
    }

    public function print(_expr:IExpression):String
    {
        return _expr.accept(this);
    }

    private function parenthesize(_name:String, _exprs:Array<IExpression>)
    {
        var ret = "";
        ret = ret + "(";
        ret = ret + _name;

        for (expr in _exprs)
        {
            ret = ret + " ";
            ret = ret + expr.accept(this);
        }

        ret = ret + ")";
        
        return ret;
    }

    public function visitBinaryExpr(_expr:BinaryExpr):String
    {
        return parenthesize(_expr.op.lexeme, [_expr.left, _expr.right]);
    }
    
    public function visitUnaryExpr(_expr:UnaryExpr):String
    {
        return parenthesize(_expr.op.lexeme, [_expr.right]);
    }
    
    public function visitGroupingExpr(_expr:GroupingExpr):String
    {
        return parenthesize("group", [_expr.expression]);
    }

    public function visitLiteralExpr(_expr:LiteralExpr):String
    {
        var ret = "";

        if (_expr.value == null)
        {
            // our null type is undefined, but it's a thing, yeah
            ret = "NULL";
        }
        else
        {
            // I don't like this
            ret = _expr.value.toString();
        }

        return ret;
    }
}