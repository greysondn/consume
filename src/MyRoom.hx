import flash.utils.Object;
import flash.Lib;

class MyRoom {

	public var name:String; //Room name
	public var allowWait:Bool; //Can the player wait in this room (button 4)
	
	public var isPublic:Bool; //Is the room public or private?
	
	public var roomNPC:Int; //List of NPCs in the room. Interaction is controlled through the three 'special' buttons below
	
	/* Special button flags, each button can have one of the following flags on it
	 * 0 - Nothing
	 * 1 - Hunt, passive/active (Allows the player to hunt for prey. passive/active = club/park probably)
	 * 2 - Shop, [shop invintory]
	 * 3 - Talk, NPC (Chat with an NPC, should be an ID from roomNPCs. Eating NPCs will be handled here now)
	 * 4 - Work, Time (Player works for time)
	 * 5 - Toilet
	 * 6 - Sleep
	 * 
	 */
	
	public var specialButtons:Array<Dynamic>;
	
	public function new(newRoom:Array<Dynamic>) {
		var globals:Object = Lib.current.getChildByName("GlobalVars");
		var exits:Array<Dynamic> = globals.exits;
		
		this.name = newRoom[0];
		this.specialButtons = newRoom[9];
		this.allowWait = newRoom[10];
		this.isPublic = newRoom[11];
		if (newRoom[12] != null) {
			this.roomNPC = newRoom[12];
		} else {
			this.roomNPC = -1;
		}
		this.desc = newRoom[13];
	}
	
}