package net.darkglass.consume;

class Registry
{
    /**
     * Singleton instance of Registry
     */
    public static var instance(default, null):Registry = new Registry();
    
    /**
     * Private constructor for Registry
     */
    private function new()
    {
        // pass for now
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

    /**
     * The name of the save data file stored on the player's system. Flash will append '.sol' to the file when it saves.
     * 
     * Not allowing flash to store data locally will prevent saves from being created, check if there's a way to check on that and display an error to the user
     * Saving while in Privite Browsing will cause this file to be deleted when the user closes the window. There's nothing we can do about that.
     */
    // public var gameSaveName:String = "Consume";

	//The following values are saved
	// public var debugMode:Bool = false;
	// public var allowSex:Bool = true;
	// public var textSize:Int = 17;
	// public var allowScat:Bool = true;
	// public var allowedGenders:Array<Dynamic> = [["male", true], ["female", true], ["herm", true], ["dickgirl", true], ["doll", true], ["cuntboy", true], ["neuter", true]];
	// public var currentRoomID:Int;
	// public var difficulty:Float = 1;

	//This value tells the game if the save data is going to be missing values so we don't look for them. Saves with a buldNumer lower then 11 are not compatable with this game engine at all.
	// public var buildNumber:Int = 20;
	// public var minBuildNumber:Int = 20; //If the saved build number is below this number, don't allow players to load that file. Otherwise the game will attempt to update the file
	
	// public var perkCostMultiplier:Int = 13;
	
	//Changes the number that displays in the corner of the play field
	// public var buildVersion:String = "0.53.pre";
	
	//Global vars holding temp data
	// public var backTo:String;
	// public var conversationStep:Int;
	// public var sellItem:Int;
	// public var secretPress:UInt;
	// public var lastRoom:Int = -1;
	// public var prevKey:String = "";
	
	//Arrays of data, rooms, exits, npcs and items, populated with a call to main.inilitize
	// public var welcomeMessage:Array<String> = new Array();
	// public var perks:Array<MyPerk>;
	// public var rooms:Array<Dynamic>;
	// public var exits:Array<Dynamic>;
	// public var keys:Array<Dynamic>;
	// public var food:Array<MyItem_Food>;
	// public var weapons:Array<MyItem_Weapon>;
	// public var armor:Array<MyItem_Armor>;
	// public var rings:Array<MyItem_Ring>;
	
	// public var shopLists:Array<Dynamic>;
	
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
	
	//Random NPC gender control
	// public var allowBreasts:Bool = true;
	// public var allowVagina:Bool = true;
	// public var allowPenis:Bool = true;
	// public var allowBalls:Bool = true;
}