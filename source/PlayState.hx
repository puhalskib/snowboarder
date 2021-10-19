package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	static inline var MAX_VERTICAL_BOARDER_SPEED:Int = 250;
	static inline var VERTICAL_FRICTION:Float = 0.92;
	static inline var OVERSTEER_FRICTION_ACCEL:Int = 2000;

	static inline var MAX_VERTICAL_MOTION:Int = 500;
	static inline var NUDGE_CENTER_VERTICAL:Int = 5;

	static inline var MOTION_CHANCE:Float = 0.1;

	var BOARDER_ACCELERATION:Int = 500;

	var _verticalMotion:Int;

	var _boarder:FlxSprite;
	var _motionPixel:FlxSprite;
	var _motions:FlxTypedGroup<Motion>;
	var rand:FlxRandom;

	var _playerControl:Bool;

	var _trees:FlxTypedGroup<Tree>;

	var _score:Int;
	var _scoreText:FlxText;
	var _distance:Int;
	var _distanceText:FlxText;

	var _deathSound:FlxSound;

	var _jumper:FlxSprite;
	var _shadow:FlxSprite;

	override public function create()
	{
		super.create();

		FlxG.cameras.bgColor = FlxColor.WHITE;

		// create the snowboarder
		// var tex1 = FlxAtlasFrames.fromTexturePackerJson("assets/board.png", "assets/board.json");
		_boarder = new FlxSprite();
		_boarder.loadGraphic("assets/images/board.png", true, 32, 32);
		_boarder.animation.add("0", [0], 0);
		_boarder.animation.add("1", [1], 0);
		_boarder.animation.add("2", [2], 0);
		_boarder.animation.add("3", [3], 0);
		_boarder.animation.add("4", [4], 0);
		_boarder.animation.play("0");
		_boarder.screenCenter();
		_boarder.y = 32;
		_boarder.scale.set(3, 3);
		_boarder.maxVelocity.y = MAX_VERTICAL_BOARDER_SPEED;

		// whenever sprite is facing RIGHT, do NOT flip the sprite's graphic
		_boarder.setFacingFlip(FlxObject.RIGHT, false, false);

		// whenever sprite is facing LEFT, flip the graphic horizontally
		_boarder.setFacingFlip(FlxObject.LEFT, true, false);

		rand = new FlxRandom();

		_motions = new FlxTypedGroup<Motion>();

		_verticalMotion = MAX_VERTICAL_MOTION;
		// _verticalMotion = Math.floor(MAX_VERTICAL_MOTION / 2);

		_playerControl = true;

		_score = 0;
		_scoreText = new FlxText(0, 0);
		_scoreText.text = "Score: " + _score;
		_scoreText.color = FlxColor.BLACK;
		_scoreText.size = 32;

		_distance = 0;
		_distanceText = new FlxText(FlxG.width - 300, 0, 300, "m", 32);
		_distanceText.alignment = "right";
		_distanceText.text = _distance + "m";
		_distanceText.color = FlxColor.BLACK;

		// death sound
		_deathSound = FlxG.sound.load("assets/sounds/hit.wav");
		_deathSound.persist = true;

		_shadow = new FlxSprite(_boarder.x, _boarder.y, "assets/images/shadow.png");
		_jumper = new FlxSprite(_boarder.x, _boarder.y, "assets/images/board_jump.png");

		add(_boarder);
		add(_motions);
		add(_scoreText);
		add(_distanceText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// collision
		FlxG.overlap(_boarder, _motions, collideTree);

		if (_playerControl)
		{
			// vertical boarder movement
			_boarder.acceleration.y = 0;
			if (FlxG.keys.anyPressed([DOWN, S]))
			{
				_boarder.acceleration.y = BOARDER_ACCELERATION;
			}
			else if (FlxG.keys.anyPressed([UP, W]))
			{
				_boarder.acceleration.y = -BOARDER_ACCELERATION;
			}
			else
			{
				if (_boarder.velocity.y > 0)
				{
					_boarder.velocity.y = _boarder.velocity.y * VERTICAL_FRICTION;
				}
				else
				{
					_boarder.velocity.y = _boarder.velocity.y * VERTICAL_FRICTION;
				}

				// nudge boarder to the center y value
				if (_boarder.y > (FlxG.height / 2) && !(FlxG.keys.anyPressed([UP, W])))
				{
					_boarder.acceleration.y -= NUDGE_CENTER_VERTICAL * (_boarder.y - (FlxG.height / 2));
				}
				else if (!(FlxG.keys.anyPressed([DOWN, S])))
				{
					// nudge if on top half of screen
					_boarder.acceleration.y += (NUDGE_CENTER_VERTICAL / 2) * ((FlxG.height / 2) - _boarder.y);
				}

				// if boarder vertical velocity is near 0, just make it zero
				if (Math.abs(_boarder.velocity.y) < 4)
				{
					_boarder.velocity.y = 0;
				}
			}

			// horizontal velocity check
			if (_boarder.velocity.x < 0)
			{
				_boarder.facing = FlxObject.LEFT;
			}
			else
			{
				_boarder.facing = FlxObject.RIGHT;
			}

			// horizontal boarder movement
			_boarder.acceleration.x = 0;
			if (FlxG.keys.anyPressed([LEFT, A]))
			{
				_boarder.acceleration.x = -BOARDER_ACCELERATION;
			}
			else if (FlxG.keys.anyPressed([RIGHT, D]))
			{
				_boarder.acceleration.x = BOARDER_ACCELERATION;
			}

			final absVelocity:Float = Math.abs(_boarder.velocity.x);
			if (absVelocity < 40)
			{
				_boarder.animation.play("0");
			}
			else if (absVelocity < 100)
			{
				_boarder.animation.play("1");
			}
			else if (absVelocity < 200)
			{
				_boarder.animation.play("2");
			}
			else if (absVelocity < 300)
			{
				_boarder.animation.play("3");
			}
			else
			{
				_boarder.animation.play("4");
			}

			// slow acceleration when velocity is too high
			if (absVelocity > 150)
			{
				_boarder.acceleration.x = _boarder.acceleration.x / 2;
			}

			// oversteer
			if (FlxG.keys.pressed.SHIFT)
			{
				if (FlxG.keys.anyPressed([LEFT, A]) && _boarder.velocity.x > -100)
				{
					_boarder.acceleration.x = _boarder.acceleration.x * 5;
					_boarder.acceleration.y = -OVERSTEER_FRICTION_ACCEL;
					if (_boarder.velocity.x < 0)
					{
						_boarder.animation.play("2");
					}
					else if (_boarder.velocity.x < 40)
					{
						_boarder.animation.play("1");
						_boarder.facing = FlxObject.LEFT;
					}
					else if (_boarder.velocity.x < 100)
					{
						_boarder.animation.play("0");
						_boarder.facing = FlxObject.LEFT;
					}
					else if (_boarder.velocity.x < 200)
					{
						_boarder.animation.play("1");
					}
					else if (_boarder.velocity.x < 300)
					{
						_boarder.animation.play("2");
					}
					else
					{
						_boarder.animation.play("3");
					}
				}
				if (FlxG.keys.anyPressed([RIGHT, D]) && _boarder.velocity.x < 100)
				{
					_boarder.acceleration.x = _boarder.acceleration.x * 5;
					_boarder.acceleration.y = -OVERSTEER_FRICTION_ACCEL;
					if (_boarder.velocity.x > 0)
					{
						_boarder.animation.play("2");
					}
					else if (_boarder.velocity.x > -40)
					{
						_boarder.animation.play("1");
						_boarder.facing = FlxObject.RIGHT;
					}
					else if (_boarder.velocity.x > -100)
					{
						_boarder.animation.play("0");
						_boarder.facing = FlxObject.RIGHT;
					}
					else if (_boarder.velocity.x > -200)
					{
						_boarder.animation.play("1");
					}
					else if (_boarder.velocity.x > -300)
					{
						_boarder.animation.play("2");
					}
					else
					{
						_boarder.animation.play("3");
					}
				}

				/*
					// slow down motion
					for (m in _motions)
					{
						m.acceleration.y = 100;
					}
					for (t in _trees)
					{
						t.acceleration.y = 100;
					}
				 */
				if (FlxG.keys.anyPressed([LEFT, RIGHT, D, A]))
				{
					_verticalMotion = Math.floor(_verticalMotion * 0.97);
				}
			}
			else
			{
				// speed up motion back to what it was before
				// slow down motion
				_verticalMotion += 10;
				if (_verticalMotion > MAX_VERTICAL_MOTION)
				{
					_verticalMotion = MAX_VERTICAL_MOTION;
				}
			}
		}

		// reset the motion
		for (m in _motions)
		{
			m.velocity.y = -_verticalMotion;
			if (m.y < -100)
			{
				// destroy motion pixel if outside the window
				_motions.remove(m);
				m.destroy();
			}
		}

		if (_jumper.exists)
		{
			if (_jumper.y > _shadow.y + 50)
			{
				_boarder.velocity.y = _shadow.velocity.y;
				_boarder.velocity.x = _shadow.velocity.x;
				_boarder.x = _shadow.x;
				_boarder.y = _shadow.y;

				_jumper.exists = false;
				_shadow.exists = false;
				_boarder.exists = true;
			}
		}
		// spawn motion sprites
		var randx = rand.float(0.0, 1.0);
		var chance = MOTION_CHANCE;
		if (randx < chance)
		{
			var i:Int;
			if (randx < chance / 2)
			{
				i = 0;
			}
			else if (randx < chance / 8 * 5)
			{
				i = 2;
			}
			else
			{
				i = 1;
			}
			_motions.add(new Motion(rand.float(0.0, 1.0) * FlxG.width, FlxG.height + 100, i));
		}

		// near miss
		for (t in _motions)
		{
			if (t.sprite == 0 && _boarder.exists)
			{
				if (!t.passed && t.y < _boarder.y)
				{
					t.passed = true;
					if (FlxMath.distanceBetween(t, _boarder) < 130)
					{
						var text = new NearMiss(_boarder.x, _boarder.y);
						_score += 3;
						add(text);
					}
				}
			}
		}

		// out of bounds check
		if (_boarder.x < 0 || _boarder.x > FlxG.width)
		{
			_boarder.screenCenter();
			_boarder.velocity.x = 0;
			_boarder.velocity.y = 0;
		}

		// distance update
		_distance += Math.floor(_verticalMotion * 0.01);
		_distanceText.text = Math.floor(_distance * 0.1) + "m";

		// score update
		_scoreText.text = "Score: " + (_score + Math.floor(_distance * 0.001));
	}

	function collideTree(boarder:FlxSprite, tree:Motion):Void
	{
		if (tree.sprite == 1)
		{
			return;
		}
		else if (tree.sprite == 2)
		{
			_shadow.exists = true;
			_shadow = new FlxSprite(boarder.x, boarder.y, "assets/images/shadow.png");
			_shadow.velocity.x = boarder.velocity.x;
			_shadow.velocity.y = boarder.velocity.y;
			add(_shadow);

			_jumper.exists = true;
			_jumper = new FlxSprite(boarder.x, boarder.y, "assets/images/board_jump.png");
			_jumper.scale.set(3, 3);
			_jumper.velocity.x = boarder.velocity.x;
			_jumper.velocity.y = boarder.velocity.y;
			_jumper.velocity.y -= 800;
			_jumper.acceleration.y = 1100;
			add(_jumper);

			boarder.exists = false;
			return;
		}
		tree.y = tree.y + 128;
		tree.flipY = true;
		_verticalMotion = 0;
		boarder.velocity.x = 0;
		boarder.velocity.y = 0;
		boarder.acceleration.x = 0;
		boarder.acceleration.y = 0;
		boarder.alpha = 0;
		_playerControl = false;
		for (m in _motions)
		{
			m.velocity.y = 0;
		}

		// spawn death sprite
		var tempDeath = new FlxSprite(boarder.x, boarder.y, "assets/images/board_fall.png");
		tempDeath.scale.set(3, 3);
		tempDeath.velocity.x = 15 * (boarder.x - tree.x);
		tempDeath.velocity.y = -500;
		tempDeath.acceleration.y = 2000;
		add(tempDeath);

		// play death sound
		_deathSound.play(true);

		// restart
		var rtext = new FlxText();
		rtext.text = "Final Score: " + _score + "\n Play Again?";
		rtext.color = FlxColor.BLACK;
		rtext.size = 40;
		rtext.screenCenter();
		add(rtext);

		var rbtn = new FlxButton(FlxG.width / 2, FlxG.height / 2 + 250, "restart", restart);
		rbtn.onDown.sound = FlxG.sound.load("assets/sounds/select.wav");
		add(rbtn);
	}

	function restart():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}
}
