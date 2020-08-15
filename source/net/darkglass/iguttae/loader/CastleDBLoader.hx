package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.environment.Environment;

import net.darkglass.iguttae.expression.clause.DirectionClause;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.item.Item;
import net.darkglass.iguttae.gameworld.map.Room;
import net.darkglass.iguttae.gameworld.map.Transition;

import net.darkglass.iguttae.loader.CastleDBData;

import openfl.Assets;

class CastleDBLoader
{
    /**
     * Singleton instance of class
     */
    private static var instance:CastleDBLoader;

    /**
     * Just a handy dandy pointer into our data class.
     */
    private var data = CastleDBData;

    /**
     * DirectionClause, so we can translate these slightly easier.
     */
    private var dirClause:DirectionClause;

    /**
     * Constructor.
     */
    private function new()
    {
        // dummy so that we can have a singleton.

        // also dirclause
        this.dirClause = new DirectionClause();
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
        // rooms are supposed to be first
        this.loadRooms(env);

        // followed by transitions between rooms
        this.loadTransitions(env);

        // load items in
        this.loadItems(env);

        // spawn objects where they go.
        this.loadSpawns(env);
    }


    /**
     * Helper function to load raw room data in
     * 
     * @param env Environment to load rooms into
     */
    private function loadRooms(env:Environment):Void
    {
        for (entry in this.data.rooms.all)
        {
            // placeholder room
            var swp:Room = new Room();

            // index
            swp.index = entry.index;

            // name
            swp.name = entry.name.toString();

            // flags
            for (f in entry.flags)
            {
                // the flags have specific uids.
                // I'll document them as I go about.
                // an easier list would be to just read the database, you know.
                // prolly be more accurate, too.
                switch (f.flag.uid.toString())
                {
                    // is public - whether or not this room is public
                    case "_0007":
                    {
                        swp.permissions.add(swp.consts.get("flag", "public"));
                    }

                    // invalid
                    default:
                    {
                        throw("INVALID KEY FOR ROOM FLAG! : " + f.flag.uid.toString());
                    }
                }
            }

            // verbs - which are wrong in engine, as permissions, sorry!
            for (v in entry.verbs)
            {
                // verbs, which for now are permissions, sorry!
                // I'll document them as I go about
                // an easier list would be to read the database
                // prolly be more accurate, too
                switch (v.verb.uid.toString())
                {
                    // wait - whether we can wait here
                    case "_0013":
                    {
                        swp.permissions.add(swp.consts.get("permission", "wait"));
                    }
                    // work - whether we can work here
                    case "_0012":
                    {
                        // pass - valid, but we do nothing with it
                        // TODO: do something with this.
                    }
                    default:
                    {
                            trace("INVALID KEY FOR ROOM VERB! : " + v.verb.uid.toString());
                            throw("INVALID KEY FOR ROOM VERB! : " + v.verb.uid.toString());
                    }
                }
            }

            // descriptions
            swp.longview = this.fixNewlines(entry.description[0].longview.toString());
            swp.brief = this.fixNewlines(entry.description[0].brief.toString());
            swp.verbose = this.fixNewlines(entry.description[0].verbose.toString());

            // push into environment
            env.rooms.add(swp);
        }

        // all rooms have been added, in theory - let's validate the list!
        if (!env.rooms.checkIntegrity())
        {
            // unpossible status
            // This is most likely in the loader code, not anything in db/etc
            throw "Room integrity failure!";
        }
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
            swp.verbose = entry.description[0].description;
            swp.name = entry.name;
            
            // set all the flags, please
            for (f in entry.flags)
            {
                // the flags have specific uids.
                // I'll document them as I go about.
                // an easier list would be to just read the database, you know.
                // prolly be more accurate, too.
                switch (f.flag.uid.toString())
                {
                    // indestructible
                    case "_0001":
                    {
                        swp.isIndestructible = true;
                    }

                    // keyItem
                    case "_0002":
                    {
                        swp.isKeyItem = true;
                    }

                    // unique
                    case "_0000":
                    {
                        swp.isUnique = true;
                    }

                    // isKey
                    case "_0009":
                    {
                        // stuff for keys, as in a lock
                        swp.isKey = true;

                        // combos
                        for (comboEntry in entry.combos)
                        {
                            swp.combos.push(comboEntry.value);
                        }
                    }

                    // listInInventory
                    case "_0003":
                    {
                        // pass
                        // TODO: write logic for listInInventory
                    }

                    // listInRoom
                    case "_0004":
                    {
                        // pass
                        // TODO: write logic for listInRoom
                    }

                    // invalid
                    default:
                    {
                        throw ("INVALID KEY FOR ITEM FLAG! : " + f.flag.uid.toString());
                    }
                }
            }

            // stuff for aliases
            swp.addAlias(swp.name);

            for (aliasEntry in entry.alias)
            {
                swp.addAlias(aliasEntry.value);
            }

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
     * Helper function to load room transitions in
     *
     * @param env Environment to load transitions into. Must already have rooms
     *            loaded into it or I can basically guarantee this will look
     *            like utter failure.
     */
    private function loadTransitions(env:Environment):Void
    {
        for (entry in this.data.doors.all)
        {
            // need a pair of transitions here
            var swpL:Transition = new Transition();
            var swpR:Transition = new Transition();

            // index
            swpL.index = entry.index;
            swpR.index = entry.index;

            // names, which is basically what we have for now
            swpL.name = entry.rooms[1].description[0].name;
            swpR.name = entry.rooms[0].description[0].name;

            // flags
            for (f in entry.flags)
            {
                // the flags have specific uids.
                // I'll document them as I go about.
                // an easier list would be to just read the database, you know.
                // prolly be more accurate, too.
                switch (f.flag.uid.toString())
                {
                    // 10 locked
                    // 11 timed
                    // 12 hidden

                    // locked
                    case "_0010":
                    {
                        // just tell them they're locked
                        swpL.locked = true;
                        swpR.locked = true;

                        // set combo
                        // TODO: make it possible to have multiple combos
                        swpL.combo = entry.combos[0].value;
                        swpR.combo = entry.combos[0].value;
                    }
                    // timed
                    case "_0011":
                    {
                        // pass
                        // TODO: write logic here
                    }
                    // hidden
                    case "_0012":
                    {
                        // pass
                        // TODO: write logic here
                    }
                }
            }

            // get the two rooms and set them as targets
            var roomL:Actor = cast(env.rooms.get(entry.rooms[0].room.index), Actor);
            var roomR:Actor = cast(env.rooms.get(entry.rooms[1].room.index), Actor);
            swpL.target = roomR;
            swpR.target = roomL;

            // get sides the transitions go on and connect them to rooms
            var sideL:Compass = this.dirClause.stringToCompass(entry.rooms[0].side.shortname, env);
            var sideR:Compass = this.dirClause.stringToCompass(entry.rooms[1].side.shortname, env);
            roomL.addExit(sideL, swpL);
            roomR.addExit(sideR, swpR);

            // connect swaps to each other
            swpL.oppositeSide = swpR;
            swpR.oppositeSide = swpL;

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

    private function fixNewlines(borked:String):String
    {
        var borkbork:Array<String> = borked.split("\\n");
        var ret:String = "";

        for (bork in borkbork)
        {
            ret = ret + bork;
            ret = ret + "\n";
        }

        return ret;
    }
}