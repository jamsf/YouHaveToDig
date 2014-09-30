package yhtg.effects;

import flixel.FlxSprite;
import yhtg.scene.Dirt.DirtType;

import yhtg.utils.AssetDataUtil;

/**
 * ...
 * @author Jams
 */
class DirtCracks extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetDataUtil.DIRT_CRACKS, true, 32, 32);
		animation.add("0", [0], 0, false);
		animation.add("1", [1], 0, false);
		animation.add("2", [2], 0, false);
		animation.add("3", [3], 0, false);
		animation.play("0");
	}
}