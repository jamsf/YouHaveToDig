package yhtg.scene;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import yhtg.scene.Dirt.DirtType;

import yhtg.utils.AssetDataUtil;

enum DirtType
{
	NORMAL;
	HARD;
	SOLID;
}

/**
 * ...
 * @author Jams
 */
class Dirt extends FlxSprite
{
	// TODO:
	//	- Keep reference of surrounding dirts
	//  - create better dirt sprites based on surrounding dirt states
	
	public function new(X:Float, Y:Float, dirtType:DirtType) 
	{
		super(X, Y);
		loadGraphic(AssetDataUtil.EFFECT_PARTICLE, false, DIRT_SIZE, DIRT_SIZE);
		setSize(16, 16);
		_dirtType = dirtType;
		
		switch(_dirtType)
		{
			case NORMAL:
				color = 0x00FF00;
				_health = 1;
			case HARD:
				color = 0x88FF88;
				_health = 2;
			case SOLID:
				color = 0xCCCCCC;
				_health = 9999;
		}
	}
	
	public function digDirt():Bool
	{
		--_health;
		if (_health < 1)
			return true;
		return false;
	}
	
	private var _dirtType : DirtType;
	private var _health : Int;
	
	public inline static var DIRT_SIZE : Int = 16;
}