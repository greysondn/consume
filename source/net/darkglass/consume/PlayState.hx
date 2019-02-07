package net.darkglass.consume;

import flixel.FlxG;
import flixel.FlxState;

import net.darkglass.consume.TitleState;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// go ahead and load TitleState, we're not playing yet
		FlxG.switchState(new TitleState());
	}
}
