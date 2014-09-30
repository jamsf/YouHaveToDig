package yhtg.entities;

import flixel.FlxSprite;
import flixel.FlxG;

import yhtg.utils.AssetDataUtil;

/**
 * ...
 * @author Jams
 */
class Cloud extends FlxSprite
{

	public function new(startX:Float=0, startY:Float=0, vel:Float=0) 
	{
		super(startX, startY, AssetDataUtil.CLOUD);
		setSize(150, 75);
		velocity.set(vel, 0);
	}
	
	override public function update():Void 
	{
		super.update();
		if (velocity.x > 0 && x > FlxG.width)
		{
			x = -width;
		}
		else if (velocity.x < 0 && x < -width)
		{
			x = FlxG.width + width;
		}
	}
}