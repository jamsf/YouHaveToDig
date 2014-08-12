package yhtg.scene;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

import yhtg.utils.AssetDataUtil;

/**
 * ...
 * @author Jams
 */
class DirtChunk
{

	public function new(startX:Float, startY:Float, gridArr:Array<Int>, grid:DirtGrid) 
	{ 
		mDirtArray = new Array<Dirt>();
		generateGrid(startX, startY, gridArr);
		
		mTilemap = new FlxTilemap();
		mTilemap.setPosition(startX, startY	);
		mTilemap.heightInTiles = CHUNK_SIZE;
		mTilemap.widthInTiles = CHUNK_SIZE;
		mTilemap.loadMap(gridArr, AssetDataUtil.TEST_TILES, Dirt.DIRT_SIZE, Dirt.DIRT_SIZE);
		
		grid.DirtChunkGroup.add(mTilemap);
	}
	
	public function moveOnDirt(gridX:Int, gridY:Int):Bool
	{
		var dirt : Dirt = mDirtArray[(gridY * CHUNK_SIZE) + gridX];
		var ableToDig : Bool = dirt.digDirt();
		if (ableToDig)
		{
			mTilemap.setTile(gridX, gridY, 0);
			return true;
		}
		return false;
	}
	
	private function generateGrid(startX:Float, startY:Float, gridStr : Array<Int>)
	{
		for (y in 0...CHUNK_SIZE)
		{
			for (x in 0...CHUNK_SIZE)
			{
				var dirt : Dirt = new Dirt(startX + (x * Dirt.DIRT_SIZE), startY + (y * Dirt.DIRT_SIZE), gridStr[(y * CHUNK_SIZE) + x]);
				mDirtArray.push(dirt);
			}
		}
	}
	
	public function destroy():Void
	{
		
	}
	
	private var mDirtArray:Array<Dirt>;
	private var mTilemap:FlxTilemap;
	
	public inline static var CHUNK_SIZE : Int = 15;
}