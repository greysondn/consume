package net.darkglass.iguttae.treewalk.expression;

import net.darkglass.iguttae.treewalk.expression.IExpression;
import net.darkglass.iguttae.treewalk.expression.IVisitor;
import net.darkglass.iguttae.treewalk.token.Token;

/**
 * Binary expression representation.
 */
class BinaryExpr implements IExpression
{
    /**
     * Left value to expression.
     */
    public var left:IExpression;

    /**
     * Operator for expression.
     */
    public var op:Token;

    /**
     * Right value to expression.
     */
    public var right:IExpression;

    /**
     * Creates a new binary expression.
     * 
     * @param _left     expression as left value
     * @param _op       operator
     * @param _right    expression as right value
     */
    public function new(_left:IExpression, _op:Token, _right:IExpression)
    {
        this.left     = _left;
        this.op       = _op;
        this.right    = _right;
    }

    public function accept<T>(_visitor:IVisitor<T>):T
    {
        return _visitor.visitBinaryExpr(this);
    }
}