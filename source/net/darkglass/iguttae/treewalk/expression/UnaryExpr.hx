package net.darkglass.iguttae.treewalk.expression;

import net.darkglass.iguttae.treewalk.expression.IExpression;
import net.darkglass.iguttae.treewalk.expression.IExprVisitor;
import net.darkglass.iguttae.treewalk.token.Token;

class UnaryExpr implements IExpression
{
    public var op:Token;
    public var right:IExpression;

    public function new(_op:Token, _right:IExpression)
    {
        this.op    = _op;
        this.right = _right;
    }

    public function accept<T>(_visitor:IExprVisitor<T>):T
    {
        return _visitor.visitUnaryExpr(this);
    }
}