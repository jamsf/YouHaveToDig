package yhtg.entities;

import flixel.FlxSprite;

import yhtg.utils.AssetDataUtil;

/**
 * ...
 * @author Jams
 */
class Sun extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, AssetDataUtil.SUN);
	}
	
}