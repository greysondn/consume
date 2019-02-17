package net.darkglass.consume;

import flixel.FlxG;

class Registry
{
    //--------------------------------------------------------------------------
    // Singleton stuffs
    // -------------------------------------------------------------------------

    /**
     * Singleton instance of Registry
     */
    public static var instance(default, null):Registry = new Registry();
    
    /**
     * Private constructor for Registry
     */
    private function new()
    {
        // assemble gfxsets where I can access members
        this.gfxset_buttonEnabled  = [this.gfx_buttonNormal, this.gfx_buttonHover, this.gfx_buttonClick];
        this.gfxset_buttonDisabled = [this.gfx_buttonDisabled, this.gfx_buttonDisabled, this.gfx_buttonDisabled];
    }

    /**
     * Ostensibly creates a registry.
     * 
     * @return Registry the singleton of the registry
     */
    public static function create():Registry
    {
        return Registry.instance;
    }
    
    // -------------------------------------------------------------------------
    // Game metadata
    // -------------------------------------------------------------------------

    /**
     * Release string for title state
     */
    public var release:String = "v0.53pre2dev\nIn Development";

    /**
     * Version number, anywhere an int is needed
     */
    public var buildNumber:Int = 0; // genko's last was 20

    // classic save.sol name - "Consume"

    // -------------------------------------------------------------------------
    // New UI element paths etc
    // -------------------------------------------------------------------------

    /**
     * Normal graphics for button.
     * 
     * TODO: Load this on player preference.
     */
    public var gfx_buttonNormal:String = "assets/images/gui/classic/nineslice/window.png";

    /**
     * OnHover graphics for button
     * 
     * TODO: Load this on player preference
     */
    public var gfx_buttonHover:String = "assets/images/gui/classic/nineslice/window-hover.png";

    /**
     * OnClick Graphics for button
     * 
     * TODO: Load this on player preference
     */
    public var gfx_buttonClick:String     = "assets/images/gui/classic/nineslice/window-click.png";

    /**
     * Disabled graphics for button
     * 
     * TODO: Load this on player preference
     */
    public var gfx_buttonDisabled:String  = "assets/images/gui/classic/nineslice/window-disabled.png";

    /**
     * Graphics array for buttons that are enabled
     */
    public var gfxset_buttonEnabled:Array<String>; // assembled in constructor

    /**
     * Slice array for gfxset_buttonEnabled
     */
    public var gfxset_buttonEnabled_slice:Array<Array<Int>> = [[1, 1, 2, 2], [1, 1, 2, 2], [1, 1, 2, 2]];

    /**
     * Graphics array for buttons that are disabled
     */
    public var gfxset_buttonDisabled:Array<String>; // assembled in constructor

    /**
     * Slice array for gfxset_buttonDisabled
     */
    public var gfxset_buttonDisabled_slice:Array<Array<Int>> = [[1, 1, 2, 2], [1, 1, 2, 2], [1, 1, 2, 2]];

    /**
     * Background graphics for typical backgrounds
     */
    public var gfx_bgGeneral:String = "assets/images/gui/classic/nineslice/window.png";

    /**
     * Background graphics slice coords
     */
    public var gfx_bgGeneral_slice:Array<Int> = [1, 1, 2, 2];

    /**
     * Top bar BG Graphics
     */
    public var gfx_bgTopBar:String = "assets/images/gui/classic/nineslice/window.png";

    /**
     * Top bar graphics slice coords
     */
    public var gfx_bgTopBar_slice:Array<Int> = [1, 1, 2, 2];

    /**
     * Text area bg graphics
     */
    public var gfx_bgTextArea:String = "assets/images/gui/classic/nineslice/window.png";

    /**
     * Text area bg slice coords
     */
    public var gfx_bgTextArea_slice:Array<Int> = [1, 1, 2, 2];

    // -------------------------------------------------------------------------
    // Logography
    // -------------------------------------------------------------------------

    /**
     * Path to male logo with text
     * 
     * TODO: Should this be broken out for localization?
     */
    public var gfx_maleLogo:String = "assets/images/logo_male.png";

    public var gfx_femaleLogo:String = "assets/images/logo_female.png";

    /**
     * Virtual getter for logo. This returns a random logo!
     */
    public var logo(get, null):String;

    // getter
    function get_logo()
    {
        var ret:String = "";

        if(FlxG.random.bool())
        {
            ret = this.gfx_femaleLogo;
        }
        else
        {
            ret = this.gfx_maleLogo;
        }

        return ret;
    }

    // -------------------------------------------------------------------------
    // And all the rest
    // -------------------------------------------------------------------------

    /**
     * Whether or not user has arousal enabled.
     */
    public var arousalEnabled:Bool = true;

    /**
     * Whether or not user has scat enabled
     */
    public var scatEnabled:Bool = true;

    /**
     * Deprecated - Whether or not sex is allowed to happen. Use arousalEnabled instead!
     */
    public var allowSex(get, set):Bool;

     /**
      * Deprecated - Whether or not scat is allowed to happen. Use scatEnabled instead!
      */
     public var allowScat(get, set):Bool;

    /**
     * Combat Difficulty
     */
    public var difficulty:Float = 1;
    
    // public var perkCostMultiplier:Int = 13;
        
    // public var gymFee:Int = 20; //Cost to use the gym, futureproofing
    
    //Player min and max values
    // public var maxHeight:Int = 120; //Max player height, in inches: 10'
    // public var minHeight:Int = 24; //Min player height, in inches: 2'
    // public var minChest:Int = 12;
    // public var maxChest:Int = 60;
    // public var minWaist:Int = 8;
    // public var maxWaist:Int = 60;
    // public var minHips:Int = 10;
    // public var maxHips:Int = 70;
    
    //Blackjack
    // public var betAmount:Float = 0; //Blackjack bet amount
    // public var betTarget:String = ""; //Blackjack bet target
    
    // -------------------------------------------------------------------------
    // Random NPC properties
    // -------------------------------------------------------------------------

    /**
     * deprecated! use breastsEnabled instead!
     */
    public var allowBreasts(get, set):Bool;

    /**
     * Whether or not random NPCs can have breasts
     */
    public var breastsEnabled:Bool = true;

    function set_allowBreasts(newState:Bool)
    {
        FlxG.log.warn("Call made to set_allowBreasts!");
        return this.breastsEnabled = newState;
    }

    function get_allowBreasts()
    {
        FlxG.log.warn("Call made to get_allowBreasts!");
        return this.breastsEnabled;
    }

    /**
     * Deprecated! Use vaginaEnabled instead!
     */
    public var allowVagina(get, set):Bool;

    /**
     * Whether or not random NPCs can have a vagina.
     */
    public var vaginaEnabled:Bool = true;

    function set_allowVagina(newState:Bool)
    {
        FlxG.log.warn("Call made to set_allowVagina!");
        return this.vaginaEnabled = newState;
    }

    function get_allowVagina()
    {
        FlxG.log.warn("Call made to get_allowVagina!");
        return this.vaginaEnabled;
    }

    /**
     * Deprecated! Use penisEnabled instead!
     */
    public var allowPenis(get, set):Bool;

    /**
     * Whether or not random NPCs can have a penis. 
     */
    public var penisEnabled:Bool = true;

    function set_allowPenis(newState:Bool)
    {
        FlxG.log.warn("Call made to set_allowPenis!");
        return this.penisEnabled = newState;
    }

    function get_allowPenis()
    {
        FlxG.log.warn("Call made to get_allowPenis!");
        return this.penisEnabled;
    }

    /**
     * Deprecated! Use "ballsEnabled" instead!
     */
    public var allowBalls(get, set):Bool;

    /**
     * Whether or not random NPCs can have testicles.
     */
    public var ballsEnabled:Bool = true;

    function set_allowBalls(newState:Bool)
    {
        FlxG.log.warn("Call made to set_allowBalls!");
        return this.ballsEnabled = newState;
    }

    function get_allowBalls()
    {
        FlxG.log.warn("Call made to get_allowBalls!");
        return this.ballsEnabled;
    }

    /**
     * Whether or not random NPCs can be cuntboys.
     * 
     * Originally globals.allowedGenders[5][1]
     */
    public var cuntboyEnabled:Bool = true;

    /**
     * Whether or not random NPCs can be dickgirls.
     * 
     * Originally globals.allowedGenders[3][1]
     */
    public var dickgirlEnabled:Bool = true;

    
    /**
     * Whether or not random NPCs can be dolls.
     * 
     * Originally globals.allowedGenders[4][1]
     */
    public var dollEnabled:Bool = true;

    /**
     * Whether or not random NPCs can be females.
     * 
     * Originally globals.allowedGenders[0][1]
     */
    public var femaleEnabled:Bool = true;

    /**
     * Whether or not random NPCs can be herms.
     * 
     * Originally globals.allowedGenders[2][1]
     */
    public var hermEnabled:Bool = true;

    /**
     * Whether or not random NPCs can be males.
     * 
     * Originally globals.allowedGenders[1][1]
     */
    public var maleEnabled:Bool = true;

    /**
     * Whether or not random NPCs can be neuters.
     * 
     * Originally globals.allowedGenders[6][1]
     */
    public var neuterEnabled:Bool = true;

    // -------------------------------------------------------------------------
    // Not NPC stuff
    // -------------------------------------------------------------------------

    function set_allowSex(newState:Bool)
    {
        FlxG.log.warn("Call made to set_allowSex!");
        return this.arousalEnabled = newState;
    }

    function get_allowSex()
    {
        FlxG.log.warn("Call made to get_allowSex!");
        return this.arousalEnabled;
    }

    function set_allowScat(newState:Bool)
    {
        FlxG.log.warn("Call made to set_allowScat!");
        return this.scatEnabled = newState;
    }

    function get_allowScat()
    {
        FlxG.log.warn("Call made to get_allowScat!");
        return this.scatEnabled;
    }
}