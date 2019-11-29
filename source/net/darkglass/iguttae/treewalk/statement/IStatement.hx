package net.darkglass.iguttae.treewalk.statement;

import net.darkglass.iguttae.treewalk.statement.IStmtVisitor;

/**
 * I think this is the interface for statements, but no promises.
 */
interface IStatement
{
    /**
     * Accept a visitor.
     *
     * @param _visitor Some visitor we might accept.
     * @return T       The visitor's template type is also our return type.
     */
    public function accept<T>(_visitor:IStmtVisitor<T>):T;
}