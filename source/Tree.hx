package;

import flixel.FlxSprite;

class Tree extends FlxSprite
{
	public var passed:Bool;

	override public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		this.loadGraphic("assets/images/tree.png");
		passed = false;
	}
}
