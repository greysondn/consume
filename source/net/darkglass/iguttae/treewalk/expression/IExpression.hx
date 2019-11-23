package net.darkglass.iguttae.treewalk.expression;

/**
 * I think this is the expression interface but... no promises.
 */
interface IExpression
{
    /**
     * Accept a visitor.
     * 
     * @param _visitor Some visitor we might accept.
     * @return T       The visitor's template type is also our return type.
     */
    public function accept<T>(_visitor:IVisitor<T>):T;
}