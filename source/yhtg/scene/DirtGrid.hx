package yhtg.scene;

import yhtg.entities.Player;

/**
 * Dirt Grid controls the entirety of the Dirt grid
 * @author Jams
 */
class DirtGrid
{
	public function new(x:Float, y:Float) 
	{
		mDirtChunks = new Array<DirtChunk>();
		mAnchorX = x;
		mAnchorY = y;
		
		addGrid();
		addGrid();
	}
	
	public function dig(gridX:Int, gridY:Int):Bool
	{
		var chunk : DirtChunk = mDirtChunks[Math.floor(gridY / (DirtChunk.CHUNK_SIZE))];
		var chunkX : Int = gridX % DirtChunk.CHUNK_SIZE;
		var chunkY : Int = gridY % DirtChunk.CHUNK_SIZE;
		return chunk.moveOnDirt(chunkX, chunkY);
	}
	
	public function addGrid():Void
	{
		mDirtChunks.push(DirtChunkFactory.buildEasyDirtChunk(mAnchorX, mAnchorY));
		mAnchorY += Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE;
	}
	
	private var mAnchorX : Float;
	private var mAnchorY : Float;
	private var mDirtChunks : Array<DirtChunk>;
}