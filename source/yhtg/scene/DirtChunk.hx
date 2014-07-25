package yhtg.scene;

import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Jams
 */
class DirtChunk
{

	public function new(startX:Float, startY:Float, gridStr:Array<Int>) 
	{
		_dirtArray = new Array<Dirt>();
		_dirtTileGroup = new FlxGroup();
		generateGrid(startX, startY, gridStr);
		
		FlxG.state.add(_dirtTileGroup);
	}
	
	public function moveOnDirt(gridX:Int, gridY:Int):Bool
	{
		var dirt : Dirt = _dirtArray[(gridY * CHUNK_SIZE) + gridX];
		
		return dirt.digDirt();
	}
	
	private function generateGrid(startX:Float, startY:Float, gridStr : Array<Int>)
	{
		for (y in 0...CHUNK_SIZE)
		{
			for (x in 0...CHUNK_SIZE)
			{
				var dirt : Dirt = new Dirt(startX + (x * Dirt.DIRT_SIZE), startY + (y * Dirt.DIRT_SIZE), gridStr[(y * CHUNK_SIZE) + x]);
				_dirtArray.push(dirt);
				_dirtTileGroup.add(dirt);
				//FlxG.state.add(dirt);
			}
		}
	}
	
	private var _dirtTileGroup:FlxGroup;
	
	private var _dirtArray:Array<Dirt>;
	
	public inline static var CHUNK_SIZE : Int = 24;
}