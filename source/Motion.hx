package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Motion extends FlxSprite
{
	public var passed:Bool;
	public var sprite:Int;

	override public function new(X:Float = 0, Y:Float = 0, s:Int)
	{
		super(X, Y);
		this.sprite = s;
		if (s == 0)
		{
			this.loadGraphic("assets/images/tree.png");
			this.scale.set(4, 4);
		}
		else if (s == 1)
		{
			this.makeGraphic(4, 4, FlxColor.GRAY);
		}
		else if (s == 2)
		{
			this.loadGraphic("assets/images/snow_jump.png");
			this.scale.set(4, 4);
		}
		passed = false;
	}
}
