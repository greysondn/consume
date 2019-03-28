package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.map.Room;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.gameworld.actor.Compass;

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
     * Load game into env based on yaml source files
     * 
     * @param env       Environment to load things into.
     * @param roomSrc   Source for room data
     * @param tranSrc   Source for room-to-room connection data
     */
    public function load(env:Environment, ?roomSrc:String="assets/data/en-us/rooms.yaml", ?tranSrc:String="assets/data/en-us/doors.yaml"):Void
    {
        // this typing is bad and there's no elegant fix
        // if you look in the helper functions, strong casts are done in
        // there. Hey, it was that or give up on having a flexible YAML
        // structure. Hell forbid.

        // rooms first
        var roomStr:String  = Assets.getText(roomSrc);
        var roomDat:Array<ObjectMap<String, Dynamic>> = Yaml.parse(roomStr);
        this.loadRooms(env, roomDat);
        
        if(!env.checkRoomIntegrity())
        {
            // unpossible status
            throw "Room integrity failure!";
        }

        // transitions between rooms now
        var tranStr:String  = Assets.getText(tranSrc);
        var tranDat:Dynamic = Yaml.parse(tranStr);
        this.loadTransitions(env, tranDat);
        // no validation function would work here

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
                    swp.addPermission(swp.consts.get("flag", "public"));
                }
                if (entry.get("permissions").get("wait"))
                {
                    // permissions --> wait - whether we can wait here
                    swp.addPermission(swp.consts.get("permission", "wait"));
                }

                // get descriptions
                swp.longview = entry.get("desc").get("longview");
                swp.brief    = entry.get("desc").get("brief");
                swp.verbose  = entry.get("desc").get("verbose");

                // push into environment
                env.addRoom(swp);
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
                var leftR:Actor  = env.getRoom(entry.get("rooms").get("left").get("index"));
                var rightR:Actor = env.getRoom(entry.get("rooms").get("right").get("index"));

                // get sides the transitions go on
                var sideL:Compass = env.stringToCompass(entry.get("rooms").get("left").get("side"));
                var sideR:Compass = env.stringToCompass(entry.get("rooms").get("right").get("side"));

                // set targets
                swpL.target = rightR;
                swpR.target = leftR;

                // connect rooms to swaps
                leftR.addExit(sideL, swpL);
                rightR.addExit(sideR, swpR);
            }
        }
    }
}