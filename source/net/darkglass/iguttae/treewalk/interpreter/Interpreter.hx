package net.darkglass.iguttae.treewalk.interpreter;

import net.darkglass.iguttae.treewalk.context.GlobalContext;
import net.darkglass.iguttae.treewalk.expression.*;
import net.darkglass.iguttae.treewalk.token.Token;
import net.darkglass.iguttae.treewalk.token.TokenType;
import net.darkglass.iguttae.treewalk.error.TypeError;

class Interpreter implements IExprVisitor<Dynamic>
{
    // globals, mostly so we can print it
    private var global:GlobalContext;

    public function new(_global:GlobalContext)
    {
        this.global = _global;
    }

    // -------------------------------------------------------------------------
    // Main OOMPH function
    // -------------------------------------------------------------------------
    public function interpret(_expr:IExpression):Void
    {
        try
        {
            // oh boy ren
            var val:Dynamic = this.evaluate(_expr);
            this.global.cout(this.stringify(val));
        }
        catch (_typeError:TypeError)
        {
            // let global deal with it.
            this.global.typeError(_typeError);
        }
    }

    // -------------------------------------------------------------------------
    // Main expression Visitation functions (IExprVisitor)
    // -------------------------------------------------------------------------

    public function visitBinaryExpr(_expr:BinaryExpr):Dynamic
    {
        // default to null, which is a bad idea, I know.
        // it just needs some value to make the thing happy.
        // null is at least sane here.
        var ret:Dynamic = null;

        // and take care of the side expressions
        var left:Dynamic = this.evaluate(_expr.left);
        var right:Dynamic = this.evaluate(_expr.right);

        // and we do different things based on the operators.
        switch(_expr.op.type)
        {
            // mostly maths
            case MINUS:
                // subtraction
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) - cast(right, Float);
            case PLUS:
                // addition or concatenantion
                if (Std.is(left, Float) && Std.is(right, Float))
                {
                    ret = cast(left, Float) + cast(right, Float);
                }
                else if (Std.is(left, String) && Std.is(right, String))
                {
                    ret = cast(left, String) + cast(right, String);
                }
                else
                {
                    throw(new TypeError(_expr.op, "Operands must be two numbers or two strings."));
                }
            case SLASH:
                // divison
                // TODO: handle divide by zero
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) / cast(right, Float);
            case STAR:
                // multiplication
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) * cast(right, Float);
            
            // mostly comparators
            case GREATER_THAN:
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) > cast(right, Float);
            case GREATER_THAN_OR_EQUAL:
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) >= cast(right, Float);
            case LESS_THAN:
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) < cast(right, Float);
            case LESS_THAN_OR_EQUAL:
                this.checkNumberOperands(_expr.op, left, right);
                ret = cast(left, Float) <= cast(right, Float);

            // equality comparisons
            case NOT_EQUAL:
                ret = !this.isEqual(left, right);
            case IS_EQUAL:
                ret = this.isEqual(left, right);

            // fallback
            default:
                // just in case
                ret = null;
        }

        // end
        return ret;
    }

    public function visitUnaryExpr(_expr:UnaryExpr):Dynamic
    {
        // This is not a fun logic chain to disentangle.

        // default to null, which is a bad idea, I know.
        // it just needs some value to make the thing happy.
        // null is at least sane here.
        var ret:Dynamic = null;

        // eval the internal function
        var right:Dynamic = this.evaluate(_expr.right);

        // eval the unary operator
        switch (_expr.op.type)
        {
            case MINUS:
                // cast to float first, because it's dynamic.
                this.checkNumberOperand(_expr.op, right);
                ret = -(cast(right, Float));
            case NOT:
                // this time we'll have whatever, and just use it.
                ret = !(this.isTruthy(right));
            default:
                // still pass, but makes the compiler happy.
                ret = null;
        }

        // that's it
        return ret;
    }

    public function visitGroupingExpr(_expr:GroupingExpr):Dynamic
    {
        return this.evaluate(_expr.expression);
    }

    public function visitLiteralExpr(_expr:LiteralExpr):Dynamic
    {
        return _expr.value;
    }

    // -------------------------------------------------------------------------
    // Helper functions
    // -------------------------------------------------------------------------

    private function checkNumberOperand(_operator:Token, _operand:Dynamic):Void
    {
        // we only really care if it's not, honestly.
        if (!Std.is(_operand, Float))
        {
            throw(new TypeError(_operator, "Operand must be a number."));
        }
    }

    private function checkNumberOperands(_operator:Token, _left:Dynamic, _right:Dynamic):Void
    {
        // we only really care if it's not, honestly.
        if (!(Std.is(_left, Float) && Std.is(_right, Float)))
        {
            throw(new TypeError(_operator, "Operands must be numbers."));
        }
    }

    private function evaluate(_expr:IExpression):Dynamic
    {
        return _expr.accept(this);
    }

    private function isEqual(_left:Dynamic, _right:Dynamic):Bool
    {
        // start with a sane default, I'll be explict later
        var ret:Bool = false;

        // as an oddity, we have to cast. Oh no.
        if (Std.is(_left, null) && Std.is(_right, null))
        {
            // null
            ret = true;
        }
        else if (Std.is(_left, String) && Std.is(_right, String))
        {
            // strings
            ret = cast(_left, String) == cast(_right, String);
        }
        else if (Std.is(_left, Bool) && Std.is(_right, Bool))
        {
            // bools
            ret = cast(_left, Bool) == cast(_right, Bool);
        }
        else if (Std.is(_left, Float) && Std.is(_right, Float))
        {
            // floats
            ret = cast(_left, Float) == cast(_right, Float);
        }
        else
        {
            // comparing non-homogenous types is false for now
            ret = false;
        }

        // end
        return ret;
    }

    private function isTruthy(_obj:Dynamic):Bool
    {
        // this is a hard choice. Genko didn't have any real strong opinions so
        // I'm going with the pythonic solution. ~Grey, 27 November 2019
        //
        // https://discordapp.com/channels/@me/550044508566454284/649437386220109824
        // Probably only myself and Genko can open that, but at least it's in
        // record somewhere.

        var ret:Bool = false; // doesn't matter, I'll set it explicitly as we go

        // type casting is weird because we have to establish type first
        if (Std.is(_obj, Bool))
        {
            // it's already a boolean, we just return it to its type.
            ret = cast(_obj, Bool);
        }
        else if (Std.is(_obj, Float))
        {
            // rule for numbers
            // zero is false, everything else is true
            if ((cast(_obj, Float)) == 0)
            {
                ret = false;
            }
            else
            {
                ret = true;
            }
        }
        else if (Std.is(_obj, String))
        {
            // rule for strings
            // empty string is false, everything else is true
            if (cast(_obj, String) == "")
            {
                ret = false;
            }
            else
            {
                ret = true;
            }
        }
        else
        {
            // should never be reached.
            ret = false;
        }

        return ret;
    }

    private function stringify(_obj:Dynamic):String
    {
        // ya-huh.
        var ret:String = "";

        // every type we have
        if (Std.is(_obj, null))
        {
            // TODO: replace with a proper keyword
            ret = "null";
        }
        else if (Std.is(_obj, Float))
        {
            ret = Std.string(cast(_obj, Float));
        }
        else if (Std.is(_obj, Bool))
        {
            ret = Std.string(cast(_obj, Bool));
        }
        else if (Std.is(_obj, String))
        {
            ret = cast(_obj, String);
        }
        else
        {
            // should never be reached
            ret = "EVAL TO INVALID TYPE, WAIT WTF?";
        }

        // end
        return ret;
    }
}