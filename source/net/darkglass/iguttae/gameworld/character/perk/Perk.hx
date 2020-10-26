package net.darkglass.iguttae.gameworld.character.perk;

import net.darkglass.iguttae.gameworld.character.Character;

/**
 * Class defining the basis for perks, mostly listeners and whatnot.
 */
class Perk
{
    public static var nextInstance:Int = 1;

    public var owner:Character = null;

    public var uuid:String        = "";
    public var shortName:String   = "";
    public var displayName:String = "";
    public var description:String = "";
    public var buyable:Bool       = false;
    public var multilevel:Bool    = false;
    public var instanceStr:String = "";

    /**
     * Create a new perk. Override please.
     */
    public function new()
    {
        // mostly pass, except interate this things instance str
        this.instanceStr  = "perk_" + nextInstance;
        Perk.nextInstance = Perk.nextInstance + 1;
    }

    /**
     * Function to run on addition to a target.
     * 
     * The default just registers the target.
     * 
     * @param target target it's been added to
     */
    public function onAdd(target:Character):Void
    {
        this.owner = target;

        switch (this.shortName)
        {
            case "afem":
                // always female
            case "aherm":
                // always herm
            case "amale":
                // always male
            case "av":
                // anal vore
            case "bellyb":
                // belly bash
            case "bgbls":
                // big balls
            case "bgbst":
                // big breasts
            case "bgcok":
                // big cock
            case "bigbly":
                // big belly
            case "bv":
                // breast vore
            case "clctr":
                // collector
            case "comps":
                // compressable
            case "cv":
                // cock vore
            case "dbg1":
                // huge
            case "fstm":
                // fast metabolism
            case "hpr":
                // hyper
            case "httr":
                // heavy hitter
            case "inbal":
                // internal balls
            case "ineat":
                // inedible
            case "mscl":
                // big muscles
            case "mtn":
                // the mountain
            case "mulbo":
                // multiboob
            case "mulcoc":
                // multicock
            case "narmor":
                // natural armor
            case "nchubby":
                // naturally chubby
            case "nskinny":
                // naturally skinny
            case "pit":
                // bottomless pit
            case "taur":
                // taur
            case "ub":
                // unbirth
        }
    }

    /**
     * Function to run on removal from target
     * 
     * @return Void
     */
    public function onRemove():Void
    {
        this.owner = null;
    }

    // -------------------------------------------------------------------------
    // functions for specific perks/etc
    // -------------------------------------------------------------------------

    /**
     * Compressable < onMoveBlock >
     * 
     * You can cram your body through any opening, no matter how small.
     * 
     * @return String "true" 
     */
    private function compressable():String
    {
        // DOOR:YES

        return "true";
    }

    /**
     * Inedible < onChangeEdible >
     * 
     * You cannot be eaten.
     * 
     * @return String "false"
     */
    private function inedible():String
    {
        // EATEN:NO

        // TODO: make owner inedible here
        return "false";
    }

    /**
     * Naturally Skinny < onFatBurn >
     * 
     * Burn fat at an increased rate.
     * 
     * @return String "";
     */
    private function naturallySkinny():String
    {
        // FAT:-10

        // TODO: Implement

        return "";
    }

    /**
     * Naturally Chubby < onDigest >
     * 
     * Gain more fat from food.
     * 
     * @return String ""
     */
    private function naturallyChubby():String
    {
        // FAT:*2

        // TODO: Implement

        return "";
    }

    /**
     * Natural Armor    < onChangeFat >
     * 
     * Gain 10 armor as long as you have at least 100 fat.
     * 
     * @return String ""
     */
    private function naturalArmor():String
    {
        // IF(FAT>100)|ARMOR:+10

        // TODO: Implement

        return "";
    }

    /**
     * Belly Bash < onChangeFat >
     * 
     * Gain a bash attack with your stomach as long as it contains at least
     * 100 mass of prey.
     * 
     * @return String ""
     */
    private function bellyBash():String
    {
        // IF(STOMACH>100)|BASH:10

        // todo: Implement

        return "";
    }

    /**
     * Heavy Hitter <  >
     * 
     * Deal more damage in combat with melee attacks.
     * 
     * @return String ""
     */
    private function heavyHitter():String
    {
        // ATTACK:+10

        // TODO:Implement

        return "";
    }

    /**
     * Fast Metabolism  < onDigest >
     * 
     * Heal faster while you have prey in your stomach.
     * 
     * @return String ""
     */
    private function fastMetabolism():String
    {
        // DIGESTHEAL:+10

        // todo: implement

        return "";
    }

    /**
     * Collector <  >
     * 
     * More likely to find items on defeated (or eaten) foes.
     * 
     * @return String ""
     */
    private function collector():String
    {
        // ITEMCHANCE:+10

        // TODO:Implement

        return "";
    }

    /**
     * Big Belly <  >
     * 
     * Even when empty, your belly is bigger than most.
     * 
     * @return String ""
     */
    private function bigBelly():String
    {
        // BELLYSIZE:+100

        // TODO:Implement

        return "";
    }

    /**
     * The Mountian <  >
     * 
     * When rendered immobile you cannot be attacked.
     * 
     * @return String ""
     */
    private function theMountain():String
    {
        // IF(IMMOBLE)|ATTACK:NO

        // TODO:Implement

        return "";
    }

    /**
     * Bottomless Pit <  >
     * 
     * You are always hungry and can continue to consume prey even when immoble.
     * 
     * @return String ""
     */
    private function bottomlessPit():String
    {
        // IF(IMMOBLE)|EAT:YES

        // TODO:Implement

        return "";
    }

    /**
     * Big Breasts <  >
     * 
     * Your breasts are larger than most.
     * 
     * @return String ""
     */
    private function bigBreasts():String
    {
        // BREASTSIZE:+4

        // TODO:Implement

        return "";
    }

    /**
     * Big Cock <  >
     * 
     * Your penis is bigger than most.
     * 
     * @return String ""
     */
    private function bigCock():String
    {
        // PENISLENGTH:+6 PENISWIDTH:+2

        // TODO:Implement

        return "";
    }

    /**
     * Big Balls <  >
     * 
     * Your balls are larger than most.
     * 
     * @return String ""
     */
    private function bigBalls():String
    {
        // BALLSIZE:+4

        // TODO:Implement

        return "";
    }

    /**
     * Hyper <  >
     * 
     * Your everything is bigger than most.
     * 
     * @return String ""
     */
    private function hyper():String
    {
        // BELLYSIZE:+200 BREASTSIZE:+6 PENISLENGTH:+6 PENISWIDTH:+4 BALLSIZE:+8

        // TODO:Implement

        return "";
    }

    /**
     * Internal Balls <  >
     * 
     * You make cum, despite not having hanging balls.
     * 
     * @return String ""
     */
    private function internalBalls():String
    {
        // CUM:YES

        // TODO:Implement

        return "";
    }


    /**
     * Multiboob <  >
     * 
     * You have an additional pair of breasts.
     * 
     * @return String ""
     */
    private function multiboob():String
    {
        // BREASTS:+2

        // TODO:Implement

        return "";
    }

    /**
     * Multicock <  >
     * 
     * You have an additional cock.
     * 
     * @return String ""
     */
    private function multicock():String
    {
        // PENIS:+1

        // TODO:Implement

        return "";
    }

    /**
     * Big Muscles <  >
     * 
     * Your muscles are naturally big.
     * 
     * @return String ""
     */
    private function bigMuscles():String
    {
        // MUSCLES:+5

        // TODO:Implement

        return "";
    }

    /**
     * Always Female < onChangeGender >
     * 
     * You will always be referred to in the femmine, reguardless of genitalia.
     * 
     * @return String ""
     */
    private function alwaysFemale():String
    {
        // GENDER:Female

        // TODO:Implement

        return "";
    }

    /**
     * Always Male < onChangeGender >
     * 
     * You will always be referred to in the masculane, reguardless of
     * genitalia.
     * 
     * @return String ""
     */
    private function alwaysMale():String
    {
        // GENDER:Male

        // TODO:Implement

        return "";
    }

    /**
     * Always Herm < onChangeGender >
     * 
     * You will always be referred to in the hermaphroditic, reguardless of
     * genitalia.
     * 
     * @return String ""
     */
    private function alwaysHerm():String
    {
        // GENDER:Herm

        // TODO:Implement

        return "";
    }

    /**
     * Taur <  >
     * 
     * You have the elongated lower half of a taur. Not Implamented.
     * 
     * @return String ""
     */
    private function taur():String
    {
        // TAUR WEIGHT:+100 STOMACHCAP:+100 IMMOBILE:-100

        // TODO:Implement

        return "";
    }

    /**
     * DEBUG1 -- Huge <  >
     * 
     * For debugging only; hugeness -- Warning may cause problems, enable at own
     * risk
     * 
     * @return String ""
     */
    private function huge():String
    {
        // BREASTSIZE:+24 BELLYSIZE:+65000 BALLSIZE:+24 PENISLENGTH:+50 PENISWIDTH:+45

        // TODO:Implement

        return "";
    }

    /**
     * Cock Vore <  >
     * 
     * Consume prey using your cock and turn them into cum.
     * 
     * @return String ""
     */
    private function cockVore():String
    {
        // COCKVORE

        // TODO:Implement

        return "";
    }

    /**
     * Breast Vore <  >
     * 
     * Consume prey using your breasts and turn them into milk.
     * 
     * @return String ""
     */
    private function breastVore():String
    {
        // BREASTVORE

        // TODO:Implement

        return "";
    }

    /**
     * Anal Vore <  >
     * 
     * Consume prey using your butt, then digest them.
     * 
     * @return String ""
     */
    private function analVore():String
    {
        // ANALVORE

        // TODO:Implement

        return "";
    }

    /**
     * Unbirth <  >
     * 
     * Consume prey using your vagina, then absorb them.
     * 
     * @return String ""
     */
    private function unbirth():String
    {
        // UNBIRTH

        // TODO:Implement

        return "";
    }
}