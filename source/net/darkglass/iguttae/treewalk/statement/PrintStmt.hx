package net.darkglass.iguttae.treewalk.statement;

import net.darkglass.iguttae.treewalk.expression.IExpression;
import net.darkglass.iguttae.treewalk.statement.IStatement;
import net.darkglass.iguttae.treewalk.statement.IStmtVisitor;

class PrintStmt implements IStatement
{
    public var expr:IExpression;
    
    public function new(_expr:IExpression)
    {
        this.expr = _expr;
    }
    
    public function accept<T>(_visitor:IStmtVisitor<T>):T
    {
        return _visitor.visitPrintStmt(this);
    }
}