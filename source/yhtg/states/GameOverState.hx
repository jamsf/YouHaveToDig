package yhtg.states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author Jams
 */
class GameOverState extends FlxState
{

	public function new(depth:Int) 
	{
		super();
		
		mDepth = depth;
	}
	
	override public function create():Void 
	{
		super.create();
		
		mGameOverText = new FlxText(FlxG.width * 0.5-100, FlxG.height * 0.25, 200);
		mGameOverText.text = "Game Over";
		mGameOverText.size = 36;
		mGameOverText.color = FlxColor.WHITE;
		mGameOverText.alignment = "center";
		mGameOverText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.RED, 2);
		
		mInfoText = new FlxText(FlxG.width * 0.5-100, FlxG.height * 0.5, 200);
		mInfoText.text = "You got " + Std.string(mDepth * 10)  + " feet deep";
		mInfoText.size = 24;
		mInfoText.color = FlxColor.WHITE;
		mInfoText.alignment = "center";
		mInfoText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.RED, 1);
		
		mRetryBtn = new FlxButton(FlxG.width * 0.5-50, FlxG.height * 0.75, "Retry", retryBtnCallback);
		mRetryBtn.setGraphicSize(200, 100);
		mRetryBtn.setSize(200, 100);
		
		add(mGameOverText);
		add(mInfoText);
		add(mRetryBtn);
	}
	
	private function retryBtnCallback():Void
	{
		FlxG.switchState(new WorldState());
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	private var mGameOverText : FlxText;
	private var mInfoText : FlxText;
	private var mRetryBtn : FlxButton;
	
	private var mDepth : Int;
}