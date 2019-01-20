import flash.display.Sprite;

class PlayCard extends Sprite {
	public var suit:String;
	public var rank:String;
	private var value:Int;
	public var ace:Bool = false;
	
	public function cardName(highAce:Bool = true):String {
		return this.rank + " of " + this.suit + "(" + this.cardValue(highAce) + ")";
	}
	
	public function cardValue(highAce:Bool = false) {
		var message:String = "";
		
		if (highAce && this.ace) {
			return 11;
		}
		
		return this.value;
	}
	
	public function makeCard(newSuit:String, newValue:Int) {
		this.suit = newSuit;
		this.value = newValue;
		
		switch (newValue) {
		case 1:
			this.rank = "Ace";
			this.ace = true;
		case 2:
			this.rank = "Deuce";
		case 3:
			this.rank = "Three";
		case 4:
			this.rank = "Four";
		case 5:
			this.rank = "Five";
		case 6:
			this.rank = "Six";
		case 7:
			this.rank = "Seven";
		case 8:
			this.rank = "Eight";
		case 9:
			this.rank = "Nine";
		case 10:
			this.rank = "Ten";
		case 11:
			this.rank = "Jack";
			this.value = 10;
		case 12:
			this.rank = "Queen";
			this.value = 10;
		case 13:
			this.rank = "King";
			this.value = 10;
		}
	}
	
	public function new() {
		super();
	}
}
