package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.environment.Environment;

import net.darkglass.iguttae.gameworld.item.Item;

import net.darkglass.iguttae.loader.CastleDBData;

import openfl.Assets;

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
            
            // load data in, wait, wtf?
            CastleDBLoader.instance.data.load(Assets.getText("assets/data/main.cdb"));
        }

        return CastleDBLoader.instance;
    }

    /**
     * Loads game into env based on main cdb source file.
     * 
     * For the time being, requires the YAML loader to run first.
     * This will only be the case while migrations from one format to the other
     * are still ongoing. Sorry!
     * 
     * @param env Environment to load things into.
     */
    public function load(env:Environment):Void
    {
        // load items in
        this.loadItems(env);
    }

    /**
     * Helper function to load raw item data in.
     * 
     * @param env Environment to load items into.
     */
    private function loadItems(env:Environment):Void
    {
        trace(this.data);
    }
}