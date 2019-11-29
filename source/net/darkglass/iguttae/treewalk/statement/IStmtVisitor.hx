package net.darkglass.iguttae.treewalk.statement;

import net.darkglass.iguttae.treewalk.statement.ExpressionStmt;
import net.darkglass.iguttae.treewalk.statement.PrintStmt;

/**
 * Interface for a statement visitor. Yeparooni. We've done this.
 */
interface IStmtVisitor<T>
{
    public function visitExpressionStmt(_stmt:ExpressionStmt):T;
    public function visitPrintStmt(_stmt:PrintStmt):T;
}