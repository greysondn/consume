package net.darkglass.iguttae.treewalk.expression;

import net.darkglass.iguttae.treewalk.expression.IExpression;
import net.darkglass.iguttae.treewalk.expression.IExprVisitor;

class LiteralExpr implements IExpression
{
    public var value:Dynamic;

    public function new(_value:Dynamic)
    {
        this.value = _value;
    }

    public function accept<T>(_visitor:IExprVisitor<T>):T
    {
        return _visitor.visitLiteralExpr(this);
    }
}