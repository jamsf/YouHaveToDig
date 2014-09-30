package yhtg.scene;

import yhtg.utils.TileLoader;
import yhtg.scene.DirtChunkGenerator;

/**
 * ...
 * @author Jams
 */
class DirtChunkFactory
{
	public static function buildNextDirtChunk(x:Float, y:Float, grid:DirtGrid, depth:Int) : DirtChunk
	{
		if (depth < 200)
			return buildEasyDirtChunk(x, y, grid);
		else if (depth < 400)
			return buildMediumDirtChunk(x, y, grid);
		else if (depth < 600)
			return buildHardDirtChunk(x, y, grid);
		else if (depth < 800)
			return buildVeryHardDirtChunk(x, y, grid);
		else if (depth < 2000)
			return buildExtremeDirtChunk(x, y, grid);
		else
			return buildEuroExtremeDirtChunk(x, y, grid);
	}
	
	public static function buildEasyDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, DirtChunkGenerator.generateCaveMatrix(DirtChunk.CHUNK_SIZE, DirtChunk.CHUNK_SIZE, 2, 0.3, 0.1), grid);
	}
	
	public static function buildMediumDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, DirtChunkGenerator.generateCaveMatrix(DirtChunk.CHUNK_SIZE, DirtChunk.CHUNK_SIZE, 2, 0.4, 0.2), grid);
	}
	
	public static function buildHardDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, DirtChunkGenerator.generateCaveMatrix(DirtChunk.CHUNK_SIZE, DirtChunk.CHUNK_SIZE, 2, 0.5, 0.3), grid);
	}
	
	public static function buildVeryHardDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, DirtChunkGenerator.generateCaveMatrix(DirtChunk.CHUNK_SIZE, DirtChunk.CHUNK_SIZE, 2, 0.7, 0.5), grid);
	}
	
	public static function buildExtremeDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, DirtChunkGenerator.generateCaveMatrix(DirtChunk.CHUNK_SIZE, DirtChunk.CHUNK_SIZE, 2, 1.0, 0.6), grid);
	}
	
	public static function buildEuroExtremeDirtChunk(x:Float, y:Float, grid:DirtGrid) : DirtChunk
	{
		return new DirtChunk(x, y, DirtChunkGenerator.generateCaveMatrix(DirtChunk.CHUNK_SIZE, DirtChunk.CHUNK_SIZE, 2, 1.0, 1.0), grid);
	}
}