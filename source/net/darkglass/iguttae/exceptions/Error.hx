package net.darkglass.iguttae.exceptions;

class Error
{
    private var name:String = "UNNAMED ERROR";
    private var body:String = "";


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