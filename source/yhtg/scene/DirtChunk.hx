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

	public function new(startX:Float, startY:Float, gridArr:Array<Array<Int>>, grid:DirtGrid) 
	{ 
		mDirtArray = new Array<Array<Dirt>>();
		generateGrid(startX, startY, gridArr);
		
		mTilemap = new FlxTilemap();
		mTilemap.setPosition(startX, startY	);
		mTilemap.heightInTiles = CHUNK_SIZE;
		mTilemap.widthInTiles = CHUNK_SIZE;
		mTilemap.loadMap(DirtChunkGenerator.convertMatrixToString(gridArr), AssetDataUtil.TEST_TILES, Dirt.DIRT_SIZE, Dirt.DIRT_SIZE);
		
		grid.DirtChunkGroup.add(mTilemap);
	}
	
	public function moveOnDirt(gridX:Int, gridY:Int):Bool
	{
		var dirt : Dirt = mDirtArray[gridY][gridX];
		var ableToDig : Bool = dirt.digDirt();
		if (ableToDig)
		{
			mTilemap.setTile(gridX, gridY, 0);
			return true;
		}
		return false;
	}
	
	private function generateGrid(startX:Float, startY:Float, gridArr:Array<Array<Int>>)
	{
		for (y in 0...CHUNK_SIZE)
		{
			mDirtArray.push(new Array<Dirt>());
			for (x in 0...CHUNK_SIZE)
			{
				var dirt : Dirt = new Dirt(startX + (x * Dirt.DIRT_SIZE), startY + (y * Dirt.DIRT_SIZE), gridArr[y][x]);
				mDirtArray[y].push(dirt);
			}
		}
	}
	
	public function destroy():Void
	{
		
	}
	
	private var mDirtArray:Array<Array<Dirt>>;
	private var mTilemap:FlxTilemap;
	
	public inline static var CHUNK_SIZE : Int = 15;
}