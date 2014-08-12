package yhtg.scene;

import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Jams
 */
class DirtTileGrid extends FlxTilemap
{

	public function new() 
	{
		super();
		
	}
	
	public function dig(gridX:Int, gridY:Int):Bool
	{
		this.
		var chunk : DirtChunk = mDirtChunks[Math.floor(gridY / (DirtChunk.CHUNK_SIZE))];
		var chunkX : Int = gridX % DirtChunk.CHUNK_SIZE;
		var chunkY : Int = gridY % DirtChunk.CHUNK_SIZE;
		return chunk.moveOnDirt(chunkX, chunkY);
	}
	
	public function addGrid():Void
	{
		mDirtChunks.push(DirtChunkFactory.buildEasyDirtChunk(mAnchorX, mAnchorY, this));
		mAnchorY += Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE;
		
		mDirtChunks.pop().destroy();
	}
	
	private var mAnchorX : Float;
	private var mAnchorY : Float;
	private var mDirtChunks : Array<DirtChunk>;
}