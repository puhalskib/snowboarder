package;

import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class NearMiss extends FlxText
{
	private static inline var VARIANCE:Float = 50;

	override public function new(X:Float = 0, Y:Float = 0)
	{
		var rand = new FlxRandom();
		super(rand.float(-VARIANCE, VARIANCE) + X, rand.float(-VARIANCE, VARIANCE) + Y - 40);
		this.text = "Near Miss!\n  +3";
		this.size = 16;
		this.color = FlxColor.BLACK;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		this.alpha -= 0.02;
		this.y -= 70 * elapsed;
	}
}
