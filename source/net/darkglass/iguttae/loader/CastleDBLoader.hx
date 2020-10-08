package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.environment.Environment;

import net.darkglass.iguttae.expression.clause.DirectionClause;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.character.Species in IggutaeSpecies;
import net.darkglass.iguttae.gameworld.character.body.BodyPart;
import net.darkglass.iguttae.gameworld.character.body.Measurement;
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
     * Creates the string the FAQ page needs to display.
     * 
     * This really should be in FAQSubstate, but it's just easier to localize it
     * here, unfortunately.
     * 
     * @return String the entire FAQSubstate text block.
     */
    public function createFAQ():String
    {
        // evenutally
        var ret:String = "";

        // easier this way for me
        var divider:String = "-----------------------------------------------";

        // whether we've had at least one thus far
        var notFirst:Bool = false;

        for (entry in this.data.faq.all)
        {
            // only a divider if it's not the first
            if (notFirst)
            {
                ret = ret + divider + "\n\n";
            }
            else
            {
                notFirst = true;
            }

            // question
            ret = ret + "Q: ";
            ret = ret + this.fixNewlines(entry.question);
            ret = ret + "\n\n";

            // answer
            ret = ret + "A: ";
            ret = ret + this.fixNewlines(entry.answer);
            ret = ret + "\n\n";
        }

        // done?

        return ret;
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

        // load species
        this.loadSpecies(env);

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

    /**
     * Helper function to load raw species data in
     *
     * @param env Environment to load species into
     */
    private function loadSpecies(env:Environment):Void
    {
        for (entry in this.data.species.all)
        {
            // placeholder species
            // be aware I had to alias this. See imports.
            var swp:IggutaeSpecies = new IggutaeSpecies();

            // index
            swp.index = entry.index;

            // name
            swp.name = entry.name;

            // body parts
            for  (part in entry.parts)
            {
                var swpPart:BodyPart = new BodyPart(part.slot.name, part.part.name);
                swp.bodyParts.add(swpPart);
            }

            // the part of measures min-max, I suppose.
            for (measure in entry.measures)
            {
                // just some dumb swap one, should really not be allocating this.
                var swpMeasure:Measurement = new Measurement(0, 0);

                switch (measure.measure.uid.toString())
                {
                    // butt
                    case "_0021":
                    {
                        swpMeasure = swp.butt;
                    }
                    // chest
                    case "_0018":
                    {
                        swpMeasure = swp.chest;
                    }
                    // height
                    case "_0016":
                    {
                        swpMeasure = swp.height;
                    }
                    // hips
                    case "_0020":
                    {
                        swpMeasure = swp.hips;
                    }
                    // waist
                    case "_0019":
                    {
                        swpMeasure = swp.waist;
                    }
                    // weight
                    case "_0017":
                    {
                        swpMeasure = swp.weight;
                    }
                }

                // swpmeasure now points at the correct one, we can just do our
                // thing with the values and the world is none the wiser
                swpMeasure.min = measure.min;
                swpMeasure.max = measure.max;
            }

            // and now, depressingly, for the part of measures start.
            // no real way to simplify this so it just sort of has to be each
            // case systematically
            for (measure in entry.startValues)
            {
                switch(measure.measure.uid.toString())
                {
                    // body_measure_breasts
                    case "_0022":
                    {
                        swp.breasts.measure = measure.value;
                    }
                    // body_measure_balls
                    case "_0023":
                    {
                        swp.testes.measure = measure.value;
                    }
                    // body_measure_erect
                    case "_0024":
                    {
                        swp.penisErectionMultiplier = measure.value;
                    }
                    // body_measure_penis_length
                    case "_0025":
                    {
                        swp.penisLength = measure.value;
                    }
                    // body_measure_penis_width
                    case "_0026":
                    {
                        swp.penisWidth = measure.value;
                    }
                    // body_capacity_stomach
                    case "_0027":
                    {
                        swp.stomach.capacity = measure.value;
                    }
                    // body_capacity_bowels
                    case "_0028":
                    {
                        swp.bowels.capacity = measure.value;
                    }
                    // body_capacity_breasts
                    case "_0029":
                    {
                        swp.breasts.capacity = measure.value;
                    }
                    // body_capacity_testes
                    case "_0030":
                    {
                        swp.testes.capacity = measure.value;
                    }
                    // body_gains_fat
                    case "_0031":
                    {
                        swp.stomach.gains = measure.value;
                    }
                    // body_gains_milk
                    case "_0032":
                    {
                        swp.breasts.gains = measure.value;
                    }
                    // body_gains_spunk
                    case "_0033":
                    {
                        swp.testes.gains = measure.value;
                    }
                    // body_digestion_damage
                    case "_0034":
                    {
                        swp.stomach.damage = measure.value;
                        swp.breasts.damage = measure.value;
                        swp.testes.damage  = measure.value;
                    }
                    // body_stretch_stomach_time
                    case "_0035":
                    {
                        swp.stomach.stretchTime = measure.value;
                    }
                    // body_stretch_bowels_time
                    case "_0037":
                    {
                        swp.bowels.stretchTime = measure.value;
                    }
                    // body_stretch_breasts_time
                    case "_0039":
                    {
                        swp.breasts.stretchTime = measure.value;
                    }
                    // body_stretch_testes_time
                    case "_0041":
                    {
                        swp.testes.stretchTime = measure.value;
                    }
                    // body_stretch_stomach_amount
                    case "_0036":
                    {
                        swp.stomach.stretchAmount = measure.value;
                    }
                    // body_stretch_bowels_amount
                    case "_0038":
                    {
                        swp.bowels.stretchAmount = measure.value;
                    }
                    // body_stretch_breasts_amount
                    case "_0040":
                    {
                        swp.breasts.stretchAmount = measure.value;
                    }
                    // body_stretch_testes_amount
                    case "_0042":
                    {
                        swp.testes.stretchAmount = measure.value;
                    }
                }
            }

            // species is now together, add it!
            env.species.add(swp);
        }

        // check integrity! ... this should never fail, frankly, and is outdated.
        if (!env.species.checkIntegrity())
        {
            throw "HEY DUMMY YOU BOTCHED THE SPECIES LIST, FIX IT";
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