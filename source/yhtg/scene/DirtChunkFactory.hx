package yhtg.scene;

import yhtg.utils.TileLoader;

/**
 * ...
 * @author Jams
 */
class DirtChunkFactory
{
	
	public static function buildEasyDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, TileLoader.getRandomTileset(), grid);
	}
		
	//private static var easyList : Array< Array<Int> > = [ DirtChunkFactory.a, DirtChunkFactory.c ]; 
}