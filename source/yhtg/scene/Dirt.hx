package yhtg.scene;

import flixel.FlxSprite;
import flixel.FlxG;
import yhtg.effects.DirtCracks;

import yhtg.scene.Dirt.DirtType;
import yhtg.utils.AssetDataUtil;

enum DirtType
{
	EMPTY;
	NORMAL;
	HARD;
	SOLID;
	IMPASSABLE;
}

/**
 * ...
 * @author Jams
 */
class Dirt
{
	public function new(X:Float, Y:Float, dirtType:Int) 
	{
		x = X;
		y = Y;
		
		switch(dirtType)
		{
			case 1:
				_dirtType = EMPTY;
				_health = 0;
				_maxHealth = 0;
			case 2:
				_dirtType = NORMAL;
				_health = 1;
				_maxHealth = 1;
			case 3:
				_dirtType = HARD;
				_health = 3;
				_maxHealth = 3;
			case 4: 
				_dirtType = SOLID;
				_health = 8;
				_maxHealth = 8;
		}
	}
	
	public function digDirt():Bool
	{
		--_health;
		if (_health < 1)
		{
			if (_cracks != null)
			{
				FlxG.state.remove(_cracks);
				_cracks = null;
			}
			return true;
		}
		else
		{
			updateCrack();
		}
		return false;
	}
	
	private function updateCrack():Void
	{
		if (_cracks == null)
		{
			_cracks = new DirtCracks(x, y);
			FlxG.state.add(_cracks);
		}
			
		if (_dirtType == HARD)
			_cracks.animation.play(HARD_CRACKS[_health - 1]);
		else if (_dirtType == SOLID)
			_cracks.animation.play(SOLID_CRACKS[_health - 1] );
	}
	
	private var x : Float;
	private var y : Float;
	private var _dirtType : DirtType;
	private var _health : Int;
	private var _maxHealth : Int;
	
	private var _cracks : DirtCracks;
	
	private static var HARD_CRACKS : Array<String> = ["3", "1"];
	private static var SOLID_CRACKS : Array<String> = ["3", "3", "2", "2", "1", "1", "0", "0"];
	
	public inline static var DIRT_SIZE : Int = 32;
}