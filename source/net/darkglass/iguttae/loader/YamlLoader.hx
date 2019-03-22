package net.darkglass.iguttae.loader;

class YamlLoader 
{
    /**
     * Singleton instance of class
     */
    private static var instance:YamlLoader;

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
    public static function create():YamlLoader
    {
        if (null == YamlLoader.instance)
        {
            YamlLoader.instance = new YamlLoader();
        }
        
        return YamlLoader.instance;
    }

    /**
     * Builds the game map based on Yaml source files
     */
    
}