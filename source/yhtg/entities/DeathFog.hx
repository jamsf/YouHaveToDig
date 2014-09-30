package yhtg.entities;

import flixel.FlxSprite;
import flixel.FlxG;
import openfl.display.BlendMode;

import yhtg.scene.Dirt;
import yhtg.scene.DirtChunk;
import yhtg.utils.AssetDataUtil;

/**
 * ...
 * @author Jams
 */
class DeathFog extends FlxSprite
{
	
	public function new(X:Float, Y:Float, initVel:Float) 
	{
		super(X, Y);
		loadGraphic(AssetDataUtil.DEATHFOG, false, 540, 760);
		setSize(540, 280);
		origin.set(0, this.height);
		velocity.set(0, initVel);
		mNextSpeedChange = 200;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (y >= mNextSpeedChange)
		{
			mNextSpeedChange += 400;
			velocity.set(0, velocity.y + 5);
		}
	}
	
	private var mNextSpeedChange : Int;
}