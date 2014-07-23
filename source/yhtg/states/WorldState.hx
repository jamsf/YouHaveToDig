package yhtg.states;
import flixel.FlxState;

import yhtg.entities.Player;
import yhtg.scene.DirtGrid;

/**
 * ...
 * @author Jams
 */
class WorldState extends FlxState
{

	public function new() 
	{
		
	}
	
	override public function create():Void 
	{
		super.create();
		
		
	}
	
	private var _dirtGrids : Array<DirtGrid>();
	private var _player : Player;
}