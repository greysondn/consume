package net.darkglass.iguttae.loader;

import net.darkglass.iguttae.gameworld.actor.Actor;
import net.darkglass.iguttae.gameworld.character.Species;
import net.darkglass.iguttae.gameworld.character.body.BodyPart;
import net.darkglass.iguttae.gameworld.character.body.Measurement;
import net.darkglass.iguttae.environment.Environment;
import net.darkglass.iguttae.gameworld.map.Room;
import net.darkglass.iguttae.gameworld.map.Transition;
import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.expression.clause.DirectionClause;

import openfl.Assets;

import yaml.Yaml;
import yaml.util.ObjectMap;

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
     * Returns a working, good-as-new YamlLoader.
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
                            ?spwnSrc:String="assets/data/en-us/spawns.yaml",
                            ?speciesSrc:String="assets/data/en-us/species.yml"
                        ):Void
    {
        // this typing is bad and there's no elegant fix
        // if you look in the helper functions, strong casts are done in
        // there. Hey, it was that or give up on having a flexible YAML
        // structure. Hell forbid.

        // and now the species
        var speciesStr:String  = Assets.getText(speciesSrc);
        var speciesDat:Dynamic = Yaml.parse(speciesStr);
        this.loadSpecies(env, speciesDat);
    }

    private function loadSpecies(env:Environment, speciesDat:Array<ObjectMap<String, Dynamic>>):Void
    {
        for (entry in speciesDat)
        {
            // real indexes start at zero
            if (entry.get("index") >= 0)
            {
                // I'm a general now, whee!
                var swp:Species = new Species();

                // and we proceed
                swp.index = entry.get("index");
                swp.name  = entry.get("name");

                // some body parts
                swp.bodyParts.add(new BodyPart("skin",      entry.get("parts").get("desc").get("skin")));
                swp.bodyParts.add(new BodyPart("mouth",     entry.get("parts").get("desc").get("mouth")));
                swp.bodyParts.add(new BodyPart("legs",      entry.get("parts").get("desc").get("legs")));
                swp.bodyParts.add(new BodyPart("arms",      entry.get("parts").get("desc").get("arms")));
                swp.bodyParts.add(new BodyPart("hands",     entry.get("parts").get("desc").get("hands")));
                swp.bodyParts.add(new BodyPart("feet",      entry.get("parts").get("desc").get("feet")));
                swp.bodyParts.add(new BodyPart("sphincter", entry.get("parts").get("desc").get("sphincter")));

                // some optional body parts
                if (entry.get("parts").get("desc").get("tail") != null)
                {
                    swp.bodyParts.add(new BodyPart("sphincter", entry.get("parts").get("desc").get("sphincter")));
                }

                // measures
                swp.height.min = entry.get("measures").get("height").get("min");
                swp.height.max = entry.get("measures").get("height").get("max");

                swp.weight.min = entry.get("measures").get("weight").get("min");
                swp.weight.max = entry.get("measures").get("weight").get("max");

                swp.chest.min = entry.get("measures").get("chest").get("min");
                swp.chest.max = entry.get("measures").get("chest").get("max");

                swp.waist.min = entry.get("measures").get("waist").get("min");
                swp.waist.max = entry.get("measures").get("waist").get("max");


                swp.hips.min = entry.get("measures").get("hips").get("min");
                swp.hips.max = entry.get("measures").get("hips").get("max");

                swp.butt.min = entry.get("measures").get("butt").get("min");
                swp.butt.max = entry.get("measures").get("butt").get("max");

                // start measures
                swp.breasts.measure = entry.get("start").get("measures").get("breasts");
                swp.testes.measure  = entry.get("start").get("measures").get("balls");

                // pingus starts.
                var pingus:BodyPart = new BodyPart("penis", "penis");
                pingus.isPhallic    = true;
                pingus.pMultiplier  = entry.get("start").get("measures").get("erect");
                pingus.pLength      = entry.get("start").get("measures").get("penis").get("length");
                pingus.pWidth       = entry.get("start").get("measures").get("penis").get("width");
                swp.bodyParts.add(pingus);

                // capacities
                swp.stomach.capacity = entry.get("start").get("capacity").get("stomach");
                swp.bowels.capacity  = entry.get("start").get("capacity").get("bowels");
                swp.breasts.capacity = entry.get("start").get("capacity").get("breasts");
                swp.testes.capacity  = entry.get("start").get("capacity").get("testes");

                // gains
                swp.stomach.gains    = entry.get("start").get("gains").get("fat");
                swp.breasts.gains    = entry.get("start").get("gains").get("milk");
                swp.testes.gains     = entry.get("start").get("gains").get("spunk");

                // digestion damage
                swp.stomach.damage   = entry.get("start").get("digestion").get("damage");
                swp.breasts.damage   = entry.get("start").get("digestion").get("damage");
                swp.testes.damage    = entry.get("start").get("digestion").get("damage");

                // stretch time
                swp.stomach.stretchTime = entry.get("start").get("stretch").get("time").get("stomach");
                swp.bowels.stretchTime  = entry.get("start").get("stretch").get("time").get("bowels");
                swp.breasts.stretchTime = entry.get("start").get("stretch").get("time").get("breasts");
                swp.testes.stretchTime  = entry.get("start").get("stretch").get("time").get("testes");

                // stretch amount
                swp.stomach.stretchAmount = entry.get("start").get("stretch").get("amount").get("stomach");
                swp.bowels.stretchAmount  = entry.get("start").get("stretch").get("amount").get("bowels");
                swp.breasts.stretchAmount = entry.get("start").get("stretch").get("amount").get("breasts");
                swp.testes.stretchAmount  = entry.get("start").get("stretch").get("amount").get("testes");

                // das it, add it!
                env.species.add(swp);
            }
        }

        // should all be loaded, integrity check
        if (!env.species.checkIntegrity())
        {
            throw "HEY DUMMY YOU BOTCHED THE SPECIES LIST, FIX IT";
        }
    }
}