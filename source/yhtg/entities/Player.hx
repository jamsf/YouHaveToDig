package yhtg.entities;

import flixel.FlxSprite;
import flixel.FlxG;



/**
 * ...
 * @author Jams
 */
class Player extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, ?SimpleGraphic);
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		debugControls();
		
	}
	
	private function debugControls():Void
	{
		if (FlxG.keys.justPressed.UP)
		{
			
		}
		else if (FlxG.keys.justPressed.DOWN)
		{
			
		}
		else if (FlxG.keys.justPressed.LEFT)
		{
			
		}
		else if (FlxG.keys.justPressed.RIGHT)
		{
			
		}
	}
}