package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.loader.CastleDBData;

class CastleDBLoader {
    /**
     * Singleton instance of class
     */
    private static var instance:CastleDBLoader;

    /**
     * Just a handy dandy pointer into our data class.
     */
    private var data = CastleDBData;

    /**
     * Constructor.
     */
    private function new()
    {
        // dummy so that we can have a singleton.
    }

    /**
     * Returns a working, good as new, CastleDB Loader
     * @return CastleDbLoader
     */
    public static function create():CastleDBLoader
    {
        if (null == CastleDBLoader.instance)
        {
            CastleDBLoader.instance = new CastleDBLoader();
        }

        return CastleDBLoader.instance;
    }
}