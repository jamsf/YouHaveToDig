package yhtg.scene;

import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Jams
 */
class DirtChunk
{

	public function new(startX:Float, startY:Float, gridStr:Array<Int>, grid:DirtGrid) 
	{
		mDirtArray = new Array<Dirt>();
		mDirtTileGroup = new FlxGroup();
		generateGrid(startX, startY, gridStr);
		
		grid.DirtChunkGroup.add(mDirtTileGroup);
	}
	
	public function moveOnDirt(gridX:Int, gridY:Int):Bool
	{
		var dirt : Dirt = mDirtArray[(gridY * CHUNK_SIZE) + gridX];
		
		return dirt.digDirt();
	}
	
	private function generateGrid(startX:Float, startY:Float, gridStr : Array<Int>)
	{
		for (y in 0...CHUNK_SIZE)
		{
			for (x in 0...CHUNK_SIZE)
			{
				var dirt : Dirt = new Dirt(startX + (x * Dirt.DIRT_SIZE), startY + (y * Dirt.DIRT_SIZE), gridStr[(y * CHUNK_SIZE) + x]);
				mDirtArray.push(dirt);
				mDirtTileGroup.add(dirt);
				//FlxG.state.add(dirt);
			}
		}
	}
	
	private var mDirtTileGroup:FlxGroup;
	
	private var mDirtArray:Array<Dirt>;
	
	public inline static var CHUNK_SIZE : Int = 24;
}