package yhtg.states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera.FlxCameraFollowStyle;

import yhtg.entities.Player;
import yhtg.scene.Dirt;
import yhtg.scene.DirtChunk;
import yhtg.scene.DirtGrid;
import yhtg.scene.DirtChunkFactory;

/**
 * ...
 * @author Jams
 */
class WorldState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		var anchorX : Float = FlxG.width * 0.5 - (Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE * 0.5);
		var anchorY : Float  = FlxG.height * 0.5;
		mDirtGrid = new DirtGrid(anchorX, anchorY);
		mPlayer = new Player(anchorX, anchorY - Dirt.DIRT_SIZE, mDirtGrid);
		
		add(mPlayer);
		
		//Camera tracker
		FlxG.camera.follow(mPlayer, FlxCameraFollowStyle.TOPDOWN ,null, 0);
		FlxG.camera.followLerp = 25.0;
	}
	
	override public function update():Void 
	{
		super.update();
		
		checkInput();
	}
	
	
	private function checkInput():Void
	{
#if (flash || desktop)
		if (FlxG.keys.justPressed.UP)
		{
			mPlayer.playerMovement(Direction.UP);
		}
		else if (FlxG.keys.justPressed.DOWN)
		{
			mPlayer.playerMovement(Direction.DOWN);
		}
		else if (FlxG.keys.justPressed.LEFT)
		{
			mPlayer.playerMovement(Direction.LEFT);
		}
		else if (FlxG.keys.justPressed.RIGHT)
		{
			mPlayer.playerMovement(Direction.RIGHT);
		}
#elseif mobile
		if (FlxG.touches.list.length == 1)
		{
			var touch : FlxTouch = FlxG.touches.list[0];
			
			var deltaX : Float = Math.abs(touch.screenX - x + (width * 0.5));
			var deltaY : Float = Math.abs(touch.screenY - y + (height * 0.5));
			
			var angle : Float = Math.atan2(deltaX, deltaY) * (180 / Math.PI);
			
			if (angle > 45 && angle < 135)
			{
				// UP
				mPlayer.playerMovement(Direction.UP);
			}
			else if (angle > -135 && angle < -45)
			{
				// DOWN
				mPlayer.playerMovement(Direction.DOWN);
			}
			else if (angle >= 135 || angle <= -135)
			{
				// LEFT
				mPlayer.playerMovement(Direction.LEFT);
			}
			else if (angle <= 45 && angle >= -45)
			{
				// RIGHT
				mPlayer.playerMovement(Direction.RIGHT);
			}
		}
#end
	}
	
	private var mDirtGrid : DirtGrid;
	private var mPlayer : Player;
	
}