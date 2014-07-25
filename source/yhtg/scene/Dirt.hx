package yhtg.scene;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import yhtg.scene.Dirt.DirtType;

import yhtg.utils.AssetDataUtil;

enum DirtType
{
	EMPTY;
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
	
	public function new(X:Float, Y:Float, dirtType:Int) 
	{
		super(X, Y);
		loadGraphic(AssetDataUtil.EFFECT_PARTICLE, false);
		setGraphicSize(DIRT_SIZE, DIRT_SIZE);
		
		switch(dirtType)
		{
			case 1:
				_dirtType = EMPTY;
				color = 0xEEEEEE;
				_health = 0;
			case 2:
				_dirtType = NORMAL;
				color = 0x00FF00;
				_health = 1;
			case 3:
				_dirtType = HARD;
				color = 0x88FF88;
				_health = 2;
			case 4:
				_dirtType = SOLID;
				color = 0xCCCCCC;
				_health = 9999;
		}
		alpha = 0.25;
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
	
	public inline static var DIRT_SIZE : Int = 24;
}