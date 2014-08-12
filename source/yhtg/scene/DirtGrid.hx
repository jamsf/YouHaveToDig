package yhtg.scene;

import flixel.group.FlxGroup;
import flixel.FlxG;

import yhtg.entities.Player; 

/**
 * Dirt Grid controls the entirety of the Dirt grid
 * @author Jams
 */
class DirtGrid
{
	public var DirtChunkGroup(get, never):FlxGroup;
	public function get_DirtChunkGroup():FlxGroup { return mDirtChunkGroup; }
	
	public function new(x:Float, y:Float) 
	{
		mDirtChunkGroup = new FlxGroup();
		mDirtChunks = new Array<DirtChunk>();
		mAnchorX = x;
		mAnchorY = y;
		
		FlxG.state.add(mDirtChunkGroup);
		
		addChunk();
		addChunk();
	}
	
	public function dig(gridX:Int, gridY:Int):Bool
	{
		var chunk : DirtChunk = mDirtChunks[Math.floor(gridY / (DirtChunk.CHUNK_SIZE))];
		var chunkX : Int = gridX % DirtChunk.CHUNK_SIZE;
		var chunkY : Int = gridY % DirtChunk.CHUNK_SIZE;
		return chunk.moveOnDirt(chunkX, chunkY);
	}
	
	public function addChunk():Void
	{
		mDirtChunks.push(DirtChunkFactory.buildEasyDirtChunk(mAnchorX, mAnchorY, this));
		mAnchorY += Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE;
		
		var removeIndex : Int = mDirtChunks.length - 2;
		if (removeIndex > 0)
			destroyChunk(removeIndex);
	}
	
	public function destroyChunk(index:Int):Void
	{
		mDirtChunks[index].destroy();
	}
	
	private var mAnchorX : Float;
	private var mAnchorY : Float;
	private var mDirtChunks : Array<DirtChunk>;
	private var mDirtChunkGroup : FlxGroup;
}