package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.environment.Environment;

import net.darkglass.iguttae.gameworld.actor.Actor;
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

        // spawn objects where they go.
        this.loadSpawns(env);
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

    /**
     * Helper function to load spawned objects into their places.
     * 
     * @param env environment to spawn objects into.
     */
    private function loadSpawns(env:Environment):Void
    {
        for (entry in this.data.spawns.all)
        {
            // holders for location and actor
            var loc:Actor = new Actor();
            var obj:Actor = new Actor();

            // I needed this shortened, holy crap.
            var entLoc = entry.location[0];

            /*
             * THIS COMMENT NEEDS KEPT UP TO DATE
             * WITH THE FOLLOWING SWITCH BLOCK'S CONTENTS
             *
             * This implementation assumes:
             *  _0000 - room
             */
            switch (entLoc.type.uid.toString())
            {
                case "_0000":
                    loc = cast(env.rooms.get(entLoc.room.index), Actor);
                default:
                    throw("Unknown spawn location type! Check values of SpawnDest!");
            }

            // this too
            var entObj = entry.object[0];

            /*
             * THIS COMMENT NEEDS KEPT UP TO DATE
             * WITH THE FOLLOWING SWITCH BLOCK'S CONTENTS
             *
             * This implementation assumes:
             *  _0001 - item
             */
            switch (entObj.type.uid.toString())
            {
                case "_0001":
                    // we have to make sure it can be cloned first
                    var toCheck:Actor = cast(env.items.get(entObj.item.index), Actor);

                    if (toCheck.canClone())
                    {
                        obj = toCheck.clone();
                    }
                    else
                    {
                        throw ("ATTEMPTED TOO MANY COPIES OF ITEM " + entObj.item.index + " : " + entObj.item.name);
                    }
                default:
                    throw throw("Unknown spawn object type! Check values of SpawnObj!");
            }

            // if we get this far, we should be okay to just insert
            loc.inventory.add(obj);
            obj.location = loc;
        }
    }
}