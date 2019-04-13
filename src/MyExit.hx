class MyExit {
	public var hidden:Bool; //Exit is hidden until the player clicks on it
	public var timeOpen:Int = -1; //player.hour time the exit opens
	public var timeClose:Int = -1; //player.hour time the exit closes
	public var travelTime:Int; //How long it take the player to travel to the next room
	public var doorWidth:Int; //How wide is the door, possible use when players get really massive?
	public var doorHeight:Int; //How tall is the door
	// public var exitClosed:Bool; //Is the exit connect to another room?
	public var hiddenQuestID:Int;
	// public var keyID:Int = -1; //Is the door locked?	
}