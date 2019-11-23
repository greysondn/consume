package net.darkglass.iguttae.treewalk.expression;

import net.darkglass.iguttae.treewalk.expression.IExpression;
import net.darkglass.iguttae.treewalk.expression.IVisitor;


class GroupingExpr implements IExpression
{
    /**
     * Internal expression this groups.
     */
    public var expression:IExpression;

    public function new(_expression:IExpression)
    {
        this.expression = _expression;
    }

    public function accept<T>(_visitor:IVisitor<T>):T
    {
        return _visitor.visitGroupingExpr(this);
    }
}