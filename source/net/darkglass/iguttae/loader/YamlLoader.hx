package net.darkglass.iguttae.gameworld.map;

class YamlMapLoader 
{
    /**
     * Singleton instance of class
     */
    private static var instance:YamlMapLoader;

    /**
     * Constructor.
     */
    private function new()
    {
        // dummy so we can have a singleton
    }

    /**
     * Returns a working, good-as-new YamlMapLoader.
     */
    public static function create():YamlMapLoader
    {
        if (null == YamlMapLoader.instance)
        {
            YamlMapLoader.instance = new YamlMapLoader();
        }
        
        return YamlMapLoader.instance;
    }

    /**
     * Builds the game map based on Yaml source files
     */
    
}