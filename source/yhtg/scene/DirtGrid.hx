package yhtg.scene;

import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Jams
 */
class DirtGrid
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
		var dirt : Dirt = _dirtArray[(gridY * GRID_SIZE) + gridX - 1];
		
		return dirt.digDirt();
	}
	
	private function generateGrid(startX:Float, startY:Float, gridStr : Array<Int>)
	{
		for (i in 0...GRID_SIZE)
		{
			for (j in 0...GRID_SIZE)
			{
				var dirt : Dirt = new Dirt(startX + (i * Dirt.DIRT_SIZE), startY + (j * Dirt.DIRT_SIZE), gridStr[(i * GRID_SIZE) + j]);
				_dirtArray.push(dirt);
				_dirtTileGroup.add(dirt);
			}
		}
	}
	
	private var _dirtTileGroup:FlxGroup;
	
	private var _dirtArray:Array<Dirt>;
	
	public inline static var GRID_SIZE : Int = 24;
}