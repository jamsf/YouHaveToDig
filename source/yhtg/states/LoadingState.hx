package yhtg.states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

import yhtg.utils.TileLoader;

/**
 * ...
 * @author Jams
 */
class LoadingState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		// some text for the bar
		mLoadingText = new FlxText(0, 0, FlxG.width, "Loading...");
		mLoadingText.setFormat(null, 28, 0xffffff, "center", FlxTextBorderStyle.OUTLINE, 0x000000);
		this.add(mLoadingText);
	}
	
	override public function update():Void 
	{
		super.update();
		
		TileLoader.loadTiles();
		
		FlxG.switchState(new WorldState());
	}
	
	private var mLoadingText : FlxText;
}