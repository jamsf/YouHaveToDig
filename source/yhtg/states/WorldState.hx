package yhtg.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.touch.FlxTouch;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

import yhtg.entities.Cloud;
import yhtg.entities.DeathFog;
import yhtg.entities.Sun;
import yhtg.entities.Player;
import yhtg.scene.Dirt;
import yhtg.scene.DirtChunk;
import yhtg.scene.DirtGrid;
import yhtg.scene.DirtChunkFactory;
import yhtg.utils.AssetDataUtil;

enum GameState
{
	OPEN;
	INTRO;
	GAME;
	RESULTS;
}

/**
 * ...
 * @author Jams
 */
class WorldState extends FlxState
{

	public function new() 
	{
		super();
		_started = false;
	}
	
	override public function create():Void 
	{
		super.create();
		
		_state = OPEN;
		
		//Camera tracker
		_cameraTarget = new FlxObject(FlxG.width * 0.5, FlxG.height * 0.5);
		FlxG.camera.setPosition(0, 0);
		FlxG.camera.follow(_cameraTarget, FlxCameraFollowStyle.LOCKON ,null, 0);
		FlxG.camera.followLerp = 0.1;
		
		// Draw Sky
		var bgCanvas : FlxSprite = new FlxSprite();
		bgCanvas.makeGraphic(FlxG.width, SKY_DISTANCE, FlxColor.TRANSPARENT, true);
		_bg = FlxSpriteUtil.drawRect(bgCanvas, 0, 0, FlxG.width, FlxG.height, 0xFF33CCFF);
		add(_bg);
		
		// Draw Sun and random clouds
		_sun = new Sun(FlxG.camera.x + (FlxG.width * 0.5) - 100, FlxG.camera.y + (FlxG.height * 0.5) - 100);
		add(_sun);
		
		var rand : FlxRandom = new FlxRandom();
		_clouds = new FlxGroup();
		for (i in 0...rand.int(8, 10))
		{
			_clouds.add(new Cloud(rand.float(0, FlxG.width), rand.float(0, SKY_DISTANCE * 0.5), rand.float(20, 40) * rand.int(-1, 1, [0]) ));
		}
		add(_clouds);
		
		var anchorX : Float = FlxG.width * 0.5 - (Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE * 0.5);
		var anchorY : Float  = FlxG.height * 0.5 + SKY_DISTANCE;
		_dirtGrid = new DirtGrid(anchorX, anchorY);
		_player = new Player(anchorX + (Dirt.DIRT_SIZE * 7), anchorY - Dirt.DIRT_SIZE, _dirtGrid);
		add(_player);
		
		_touchReleased = true;
	}
	
	override public function update():Void 
	{	
		super.update();
		
		checkInput();
		debugTouch();
		switch(_state)
		{
		case OPEN:
			_bg.y = _cameraTarget.y - (FlxG.height * 0.5);
		case INTRO:
			_bg.y = _cameraTarget.y - (FlxG.height * 0.5);
			_titlebg.alpha = _titlebg.alpha == 0 ? 1 : 0;
		case GAME:
			_titlebg.alpha = _titlebg.alpha == 0 ? 1 : 0;
			checkForDeath();
			_cameraTarget.y = _player.y;
		default:
		}
	}
	
	private function checkForDeath():Void
	{
		if (_deathFog.y + 540 - _player.height > _player.y)
			FlxG.switchState(new GameOverState(_player.MaxDepth));
	}
	
	private function beginIntro():Void
	{
		_state = INTRO;
		_bg.color = 0xFFFF0000;
		add(_bg);
		_sun.color = 0xFF000000;
		for (cloud in _clouds)
		{
			cast(cloud, FlxSprite).color = 0xFF006400;
			cast(cloud, FlxSprite).velocity.set(0, 0);
		}
		_title = new FlxSprite(0, _player.y - 120, AssetDataUtil.TITLE0);
		_titlebg = new FlxSprite(0, _player.y - 120, AssetDataUtil.TITLE1);
		add(_title);
		add(_titlebg);
		
		// Play music?
		FlxTween.tween(_cameraTarget, { y:_player.y }, 3.0, { ease:FlxEase.cubeInOut, complete:introFinishCallback } );
	}
	
	private function introFinishCallback(Tween:FlxTween):Void
	{
		startGame();
	}
	
	private function startGame():Void
	{
		_state = GAME;
		var anchorX : Float = FlxG.width * 0.5 - (Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE * 0.5);
		var anchorY : Float  = FlxG.height * 0.5 + SKY_DISTANCE;
		FlxG.camera.followLerp = 5.0;
		_deathFog = new DeathFog(anchorX, anchorY - (Dirt.DIRT_SIZE * 16) - 560, 80);
		add(_deathFog);
		
		_controlOutline = new FlxSprite(FlxG.camera.x, FlxG.camera.y, AssetDataUtil.CONTROL_OUTLINE);
		_controlOutline.scrollFactor.set(0, 0);
		add(_controlOutline);
	}
	
	private function deathCallback(Object1:FlxObject, Object2:FlxObject):Void
	{
		FlxG.switchState(new GameOverState(_player.MaxDepth));
	}
	
	private function checkInput():Void
	{
#if (flash || desktop)
		if (_state == GAME)
		{
			if (FlxG.keys.justPressed.UP)
			{
				_player.playerMovement(Direction.UP);
			}
			else if (FlxG.keys.justPressed.DOWN)
			{
				_player.playerMovement(Direction.DOWN);
			}
			else if (FlxG.keys.justPressed.LEFT)
			{
				_player.playerMovement(Direction.LEFT);
			}
			else if (FlxG.keys.justPressed.RIGHT)
			{
				_player.playerMovement(Direction.RIGHT);
			}
		}
		
		if (FlxG.keys.justPressed.R)
		{
			FlxG.switchState(new WorldState());
		}
#elseif mobile
		if (_touchReleased && FlxG.touches.list.length > 0)
		{
			_touchReleased = false;
			var touch : FlxTouch = FlxG.touches.justStarted()[0];
			if (touch == null)
				return;
			
			switch(_state)
			{
			case OPEN:
				if (_sun.overlapsPoint(touch.toPoint()))
					beginIntro();
			case GAME:
				if (touch.screenY > FlxG.height * 0.75)
					_player.playerMovement(Direction.DOWN);
				else if (touch.screenX < FlxG.width * 0.5)
					_player.playerMovement(Direction.LEFT);
				else
					_player.playerMovement(Direction.RIGHT);
			default:
				// Do nothing
			}
		}
		else if (FlxG.touches.list.length == 0)
		{
			_touchReleased = true;
		}
#end
	}
	
	private function debugTouch():Void
	{
		if (!FlxG.mouse.justPressed)
			return;
		
		switch(_state)
		{
		case OPEN:
			if (_sun.overlapsPoint(FlxG.mouse.toPoint()))
				beginIntro();
		case GAME:
			if (FlxG.mouse.screenY > FlxG.height * 0.75)
				_player.playerMovement(Direction.DOWN);
			else if (FlxG.mouse.screenX < FlxG.width * 0.5)
				_player.playerMovement(Direction.LEFT);
			else
				_player.playerMovement(Direction.RIGHT);
		default:
			// Do nothing
		}
	}
	private var _state : GameState;
	private var _cameraTarget : FlxObject;
	private var _dirtGrid : DirtGrid;
	private var _controlOutline : FlxSprite;
	
	private var _bg : FlxSprite;
	private var _sun : Sun;
	private var _title : FlxSprite;
	private var _titlebg : FlxSprite;
	private var _clouds : FlxGroup;
	private var _player : Player;
	private var _deathFog : DeathFog;
	private var _touchReleased:Bool;
	private var _started:Bool;
	
	private inline static var SKY_DISTANCE : Int = 3000;
}