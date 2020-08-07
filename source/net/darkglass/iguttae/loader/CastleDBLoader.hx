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
        for (entry in this.data.items.all)
        {
            // placeholder item
            var swp:Item = new Item();

            // populate some simple fields, nothing fancy here
            swp.index = entry.index;
            swp.verbose = entry.description;
            swp.name = entry.name;
            
            // stuff for keys - as in a lock
            if (entry.key[0].isKey)
            {
                // is key
                swp.isKey = true;

                // combos
                for (comboEntry in entry.key[0].combo)
                {
                    swp.combos.push(comboEntry.value);
                }
            }

            // stuff for aliases
            swp.addAlias(swp.name);

            for (aliasEntry in entry.alias)
            {
                swp.addAlias(aliasEntry.value);
            }

            // flags
            var flags = entry.flag[0];

            swp.isIndestructible = flags.indestructible;
            swp.isKeyItem        = flags.keyItem;
            swp.isUnique         = flags.unique;

            // push into env
            env.items.add(swp);
        }

        // perform integrity check on items
        if (!env.items.checkIntegrity())
        {
            // just going to mention, this is more likely to indicate an issue
            // in the loader now with CDB assigning dense array indexes.
            throw "HEY DUMMY YOU BOTCHED THE ITEM LIST, FIX IT";
        }
    }
}