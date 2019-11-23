package net.darkglass.iguttae.treewalk.expression;

import net.darkglass.iguttae.treewalk.expression.BinaryExpr;

/**
 * I believe this is the visitor interface but...
 * 
 * No guarantees. Sorry. It's a little bit over my head and
 * I've decided the best course is to just get my hands dirty.
 * 
 * Where `T` is a type (eg; a class)... But not necessarily
 * always the same class.
 */
interface IVisitor<T>
{
    /**
     * Visit a binary expression.
     *
     * @param _expr The expression to visit.
     * @return T    return
     */
    public function visitBinaryExpr(_expr:BinaryExpr):T;

    /**
     * Visit a Unary expression.
     * 
     * @param _expr The expression to visit.
     * @return T    return
     */
    public function visitUnaryExpr(_expr:UnaryExpr):T;

    /**
     * Visit a grouping expression.
     * 
     * @param _expr The expression to visit.
     * @return T    return
     */
    public function visitGroupingExpr(_expr:GroupingExpr):T;

    /**
     * Visit a literal expression.
     * 
     * @param _expr The expression to visit.
     * @return T    return
     */
    public function visitLiteralExpr(_expr:LiteralExpr):T;
}