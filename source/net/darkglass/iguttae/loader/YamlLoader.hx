package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.item.Item;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.map.Room;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.expression.clause.DirectionClause;

import openfl.Assets;

import yaml.Yaml;
import yaml.util.ObjectMap;
import yaml.util.ObjectMap.TObjectMap;

class YamlLoader 
{
    /**
     * Singleton instance of class
     */
    private static var instance:YamlLoader;

    /**
     * Direction clause, because helper functions.
     */
    private var dirClause:DirectionClause;

    /**
     * Constructor.
     */
    private function new()
    {
        // dummy so we can have a singleton

        // also dirclause
        this.dirClause = new DirectionClause();
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
     * Load game into env based on yaml source files
     * 
     * @param env       Environment to load things into.
     * @param roomSrc   Source for room data
     * @param tranSrc   Source for room-to-room connection data
     * @param itemSrc   Source for item base data
     * @param spwnSrc   Source for spawning data for everything else
     */
    public function load(env:Environment,
                            ?roomSrc:String="assets/data/en-us/rooms.yaml",
                            ?tranSrc:String="assets/data/en-us/doors.yaml",
                            ?itemSrc:String="assets/data/en-us/items.yml",
                            ?spwnSrc:String="assets/data/en-us/spawns.yaml"
                        ):Void
    {
        // this typing is bad and there's no elegant fix
        // if you look in the helper functions, strong casts are done in
        // there. Hey, it was that or give up on having a flexible YAML
        // structure. Hell forbid.

        // rooms first
        var roomStr:String  = Assets.getText(roomSrc);
        var roomDat:Array<ObjectMap<String, Dynamic>> = Yaml.parse(roomStr);
        this.loadRooms(env, roomDat);
        
        if(!env.rooms.checkIntegrity())
        {
            // unpossible status
            throw "Room integrity failure!";
        }

        // transitions between rooms now
        var tranStr:String  = Assets.getText(tranSrc);
        var tranDat:Dynamic = Yaml.parse(tranStr);
        this.loadTransitions(env, tranDat);
        // no validation function would work here

        // can now load items
        var itemStr:String  = Assets.getText(itemSrc);
        var itemDat:Dynamic = Yaml.parse(itemStr);
        this.loadItems(env, itemDat);

        // and spawn everything where it goes
        var spwnStr:String  = Assets.getText(spwnSrc);
        var spwnDat:Dynamic = Yaml.parse(spwnStr);
        this.loadSpawns(env, spwnDat);
    }

    /**
     * Helper function to load rooms
     * 
     * TODO: Finish documenting
     * 
     * @param env 
     * @param roomDat
     */
    private function loadRooms(env:Environment, roomDat:Array<ObjectMap<String, Dynamic>>):Void
    {
        // first parts of this are easy, will convey as we go
        for (entry in roomDat)
        {
            // real entries have an index greater than zero
            if (entry.get("index") >= 0)
            {
                // need a room here
                var swp:Room = new Room();

                // index
                swp.index = entry.get("index");

                // get name
                swp.name = entry.get("name");

                // can also set up flags/permissions/etc
                if (entry.get("flags").get("public"))
                {
                    // flag --> public - whether this is a public place
                    swp.permissions.add(swp.consts.get("flag", "public"));
                }
                if (entry.get("permissions").get("wait"))
                {
                    // permissions --> wait - whether we can wait here
                    swp.permissions.add(swp.consts.get("permission", "wait"));
                }

                // get descriptions
                swp.longview = entry.get("desc").get("longview");
                swp.brief    = entry.get("desc").get("brief");
                swp.verbose  = entry.get("desc").get("verbose");

                // push into environment
                env.rooms.add(swp);
            }
        }
    }

    /**
     * Helper function to load transitions rooms
     * 
     * TODO: Finish documenting
     * 
     * @param env 
     * @param transDat
     */
    private function loadTransitions(env:Environment, transDat:Array<ObjectMap<String, Dynamic>>):Void
    {
        for (entry in transDat)
        {
            // real entries have an index greater than or equal to zero
            if (entry.get("index") >= 0)
            {
                // need a pair of transitions here
                var swpL:Transition = new Transition();
                var swpR:Transition = new Transition();

                // index
                swpL.index = entry.get("index");
                swpR.index = entry.get("index");

                // name, will do well enough for now
                swpL.name = entry.get("desc").get("name").get("leftToRight");
                swpR.name = entry.get("desc").get("name").get("rightToLeft");

                if ("" == swpL.name || null == swpL.name)
                {
                    swpL.name = "Unnamed transition " + swpL.index + ".L";
                }
                if ("" == swpR.name || null == swpR.name)
                {
                    swpR.name = "Unnamed transition " + swpR.index + ".R";
                }

                // get the two rooms
                var leftR:Actor  = cast(env.rooms.get(entry.get("rooms").get("left").get("index")), Actor);
                var rightR:Actor = cast(env.rooms.get(entry.get("rooms").get("right").get("index")), Actor);

                // set targets
                swpL.target = rightR;
                swpR.target = leftR;

                // get sides the transitions go on
                var sideL:Compass = this.dirClause.stringToCompass(entry.get("rooms").get("left").get("side"), env);
                var sideR:Compass = this.dirClause.stringToCompass(entry.get("rooms").get("right").get("side"), env);

                // get whether or not the rooms are locked
                var areLocked:Bool = entry.get("flags").get("locked");

                if (areLocked)
                {
                    // set locked
                    swpL.locked = true;
                    swpR.locked = true;

                    // since they're locked, let's get combo for them
                    var theirCombo:Int = entry.get("key").get("combo");
                    
                    swpL.combo = theirCombo;
                    swpR.combo = theirCombo;
                }
                else
                {
                    swpL.locked = false;
                    swpR.locked = false;
                }

                // connect rooms to swaps
                leftR.addExit(sideL, swpL);
                rightR.addExit(sideR, swpR);

                // connect swaps to each other
                swpL.oppositeSide = swpR;
                swpR.oppositeSide = swpL;
            }
        }
    }

    /**
     * Helper function to load raw item data in
     * 
     * TODO: FINISH DOCUMENTING
     * 
     * @param env 
     * @param itemDat 
     */
    private function loadItems(env:Environment, itemDat:Array<ObjectMap<String, Dynamic>>):Void
    {
        for (entry in itemDat)
        {
            // real indexes start at zero
            if (entry.get("index") >= 0)
            {
                // swap holder, to later be injected into env
                var swp:Item = new Item();

                // and the "fun" part
                swp.index   = entry.get("index");
                swp.verbose = entry.get("desc");

                swp.name    = entry.get("name");
                swp.addAlias(swp.name);

                // things specifically for keys
                if (entry.get("key").get("isKey"))
                {
                    swp.isKey = true;

                    // coerce combos so they're iterable
                    var comboArray:Array<Int> = entry.get("key").get("combos");

                    for (comboEntry in comboArray)
                    {
                        swp.combos.push(comboEntry);
                    }
                }

                // aliases
                var aliasArray:Array<String> = entry.get("alias");

                for (entry in aliasArray)
                {
                    swp.addAlias(entry);
                }

                // flags
                swp.isIndestructible = entry.get("flags").get("indestructible");
                swp.isKeyItem        = entry.get("flags").get("key");
                swp.isUnique         = entry.get("flags").get("unique");

                // push into env
                env.items.add(swp);
            }
        }

        // perform integrity check on items
        if (!env.items.checkIntegrity())
        {
            throw "HEY DUMMY YOU BOTCHED THE ITEM LIST, FIX IT";
        }
    }

    private function loadSpawns(env:Environment, spwnDat:Array<ObjectMap<String, Dynamic>>)
    {
        for (entry in spwnDat)
        {
            // real entries start at index zero
            if (entry.get("index") >= 0)
            {
                // just a record of where to put things
                // so let's pull it all here so we can work with it
                var locType:String = entry.get("location").get("type");
                var locIndex:Int   = entry.get("location").get("index");
                var objType:String = entry.get("object").get("type");
                var objIndex:Int   = entry.get("object").get("index");

                // holders for location and actor,
                // but deliberately uninitialized
                var loc:Actor = new Actor();
                var obj:Actor = new Actor();

                // get location itself
                if ("room" == locType)
                {
                    loc = cast(env.rooms.get(locIndex), Actor);
                }
                else
                {
                    throw ("Unknown spawn location type! : " + locType);
                }

                // get object itself
                if ("item" == objType)
                {
                    // well, yes, but...
                    var toCheck:Actor = cast(env.items.get(objIndex), Actor);

                    // can we clone it?
                    if (toCheck.canClone())
                    {
                        // yeah okay, clone it
                        obj = toCheck.clone();
                    }
                }
                else
                {
                    throw ("Unknown spawn object type! : " + objType);
                }

                // put it in there
                loc.inventory.add(obj);
                obj.location = loc;
            }
        }
    }
}