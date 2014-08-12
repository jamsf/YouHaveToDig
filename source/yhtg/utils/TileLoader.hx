package yhtg.utils;

import openfl.Assets;

/**
 * ...
 * @author Jams
 */
class TileLoader
{

	public function new() 
	{
	}
	
	public static function loadTiles():Void
	{
		mTileIntArrs = new Array< Array<Int> >();
		
		var fullTileStr : String = Assets.getText(AssetDataUtil.TILES_DATA);
		var tileStrings : Array<String> = fullTileStr.split(".\n");
		
		for ( str in tileStrings)
		{
			str = StringTools.replace(str, "\n", "");
			str = StringTools.trim(str);
			
			var arr : Array<Int> = new Array<Int>();
			for (s in str.split(","))
			{
				arr.push(Std.parseInt(s));
			}
			
			mTileIntArrs.push(arr);
		}
	}
	
	public static function getRandomTileset():Array<Int>
	{
		return mTileIntArrs[Math.round(Math.random() * (mTileIntArrs.length - 1))];
	}
	
	private static var mTileIntArrs : Array< Array<Int> >;
}