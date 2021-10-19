package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MainMenu extends FlxState
{
	var playbtn:FlxButton;

	override public function create()
	{
		var bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		add(bg);

		playbtn = new FlxButton(FlxG.width / 5 * 3, FlxG.height / 2, "Play Game", playgame);
		playbtn.onDown.sound = FlxG.sound.load("assets/sounds/select.wav");
		add(playbtn);

		var icon = new FlxSprite();
		icon.loadGraphic("assets/images/menu_icon.png");
		icon.scale.set(6, 6);
		icon.x = Math.floor(FlxG.width / 4);
		icon.y = Math.floor(FlxG.height / 2);
		add(icon);

		// play music
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic("assets/music/alpina_blue.ogg", 1, true);
		}
	}

	function playgame():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}
}
