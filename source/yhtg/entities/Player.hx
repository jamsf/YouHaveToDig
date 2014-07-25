package yhtg.entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.input.touch.FlxTouch;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

import yhtg.scene.DirtChunk;
import yhtg.scene.DirtGrid;
import yhtg.scene.Dirt;
import yhtg.utils.AssetDataUtil;

enum Direction
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}

/**
 * ...
 * @author Jams
 */
class Player extends FlxSprite
{
	public var GridX(get, never) : Int;
	public function get_GridX() : Int { return mGridX; }
	
	public var GridY(get, never) : Int;
	public function get_GridY() : Int { return mGridY; }
	
	public function new(X:Float=0, Y:Float=0, grid:DirtGrid) 
	{
		super(X, Y);
		trace(X + "," + Y);
		
		mGridX = 0;
		mGridY = -1;
		
		mDirtGrid = grid;
		mMoving = false;
		this.loadGraphic(AssetDataUtil.EFFECT_PARTICLE, false);
		setGraphicSize(Dirt.DIRT_SIZE, Dirt.DIRT_SIZE);
		color = 0xFF0000;
		
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	public function playerMovement(dir:Direction):Void
	{
		if (mMoving)
			return;
		switch(dir)
		{
			case UP:
				if (mDirtGrid.dig(mGridX, mGridY - 1))
				{
					mGridY--;
					FlxTween.tween(this, { y:(y - Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
					mMoving = true;
				}
				// else do animation
			case DOWN:
				if (mDirtGrid.dig(mGridX, mGridY + 1))
				{
					mGridY++;
					FlxTween.tween(this, { y:(y + Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
					mMoving = true;
				}
				
			case LEFT:
				if (mDirtGrid.dig(mGridX - 1, mGridY))
				{
					mGridX--;
					FlxTween.tween(this, { x:(x - Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
					mMoving = true;
				}
				
			case RIGHT:
				if (mDirtGrid.dig(mGridX + 1, mGridY))
				{
					mGridX++;
					FlxTween.tween(this, { x:(x + Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
					mMoving = true;
				}
				
		}
	}
	
	private function endMovementCallback(tween:FlxTween):Void
	{
		mMoving = false;
	}
	
	private var mGridX : Int;
	private var mGridY : Int;
	private var mMoving : Bool;
	
	private var mDirtGrid : DirtGrid;
}