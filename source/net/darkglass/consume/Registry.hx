package net.darkglass.consume;

class Registry
{
    public static var instance(default, null):Registry = new Registry();
    
    private function new()
    {
        // pass for now
    }

    public static function create():Registry
    {
        return Registry.instance;
    }
}