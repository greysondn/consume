package net.darkglass.iguttae.exceptions;

class Error
{
    public var name:String = "UNNAMED ERROR";
    public var body:String = "";


    public function new(str:String)
    {
        this.name = "ERROR";
        this.body = str;
    }

    public function toString():String
    {
        return this.name + " : " + this.body;
    }
}