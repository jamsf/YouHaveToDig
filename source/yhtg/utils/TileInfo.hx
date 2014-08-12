package yhtg.utils;

/**
 * ...
 * @author Jams
 */
class TileInfo
{
	public var StringFormat(get, never):String;
	public function get_StringFormat():String { return mStringFormat; }
	
	public var IntArrayFormat(get, never):Array<Int>;
	public function get_IntArrayFormat():Array<Int> { return mIntArrayFormat; }
	
	public function new(str:String, intArr:Array<Int>) 
	{
		mStringFormat = str;
		mIntArrayFormat = intArr;
	}
	
	private var mStringFormat : String;
	private var mIntArrayFormat : Array<Int>;
}