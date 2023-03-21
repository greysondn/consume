package net.darkglass.util.flixel;

/**
 * Dead simple registry (singleton) for haxeui in flixel
 * 
 * Not pretty, but gets the job done
 */
class FlxHaxeUiRegistry
{
    /**
     * whether or not haxeui-flixel has been initialized
     */
    public var initialized:Bool = false;

    /**
     * Instance of this class. The only.
     */
    private static var instance:FlxHaxeUiRegistry;

    private function new()
    {
        // does nothing, non?
    }

    public static function create():FlxHaxeUiRegistry
    {
        // make sure instance exists
        if (null == FlxHaxeUiRegistry.instance)
        {
            FlxHaxeUiRegistry.instance = new FlxHaxeUiRegistry();
        }

        return FlxHaxeUiRegistry.instance;
    }
}