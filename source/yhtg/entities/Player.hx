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

enum Facing
{
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
	
	public var MaxDepth(get, never) : Int;
	public function get_MaxDepth() : Int { return mMaxDepth; }
	
	public function new(X:Float=0, Y:Float=0, grid:DirtGrid) 
	{
		super(X, Y);
		loadGraphic(AssetDataUtil.PLAYER_SPRMAP, true, 32, 32);
		animation.add("idleLeft", [0], 0, false);
		animation.add("idleRight", [1], 0, false);
		animation.add("digLeft", [2], 0, false);
		animation.add("digRight", [3], 0, false);
		animation.add("digDownLeft", [4], 0, false);
		animation.add("digDownRight", [5], 0, false);
		animation.add("digUpLeft", [6], 0, false);
		animation.add("digUpRight", [7], 0, false);
		animation.play("idleLeft");
		
		mGridX = 7;
		mGridY = -1;
		mMaxDepth = 0;
		mNextChunkDepth = DirtChunk.CHUNK_SIZE;
		
		mDirtGrid = grid;
		mMoving = false;
		mFacing = LEFT;
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
			if (mGridY == -1)
				return;
			if (mDirtGrid.dig(mGridX, mGridY - 1))
			{
				mGridY--;
				FlxTween.tween(this, { y:(y - Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
				mMoving = true;
			}
			if (mFacing == RIGHT) animation.play("digUpRight");
			else animation.play("digUpLeft");
		// else do animation
		case DOWN:
			if (mDirtGrid.dig(mGridX, mGridY + 1))
			{
				mGridY++;
				FlxTween.tween(this, { y:(y + Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
				mMoving = true;
				mMaxDepth = mMaxDepth > mGridY ? mMaxDepth : mGridY;
				if (mMaxDepth >= mNextChunkDepth)
				{
					mDirtGrid.addChunk(mMaxDepth);
					mNextChunkDepth += DirtChunk.CHUNK_SIZE;
				}
			}
			if (mFacing == RIGHT) animation.play("digDownRight");
			else animation.play("digDownLeft");
			
		case LEFT:
			if (mGridY == -1 || (mGridX > 0 && mDirtGrid.dig(mGridX - 1, mGridY)))
			{
				mGridX--;
				FlxTween.tween(this, { x:(x - Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
				mMoving = true;
				mFacing = LEFT;
			}
			animation.play("digLeft");
			
		case RIGHT:
			if (mGridY == -1 || (mGridX < DirtChunk.CHUNK_SIZE-1 && mDirtGrid.dig(mGridX + 1, mGridY)))
			{
				mGridX++;
				FlxTween.tween(this, { x:(x + Dirt.DIRT_SIZE) }, 0.05, { ease:FlxEase.quadIn, complete:endMovementCallback } );
				mMoving = true;
				mFacing = RIGHT;
			}
			animation.play("digRight");
		}
		
	}
	
	private function endMovementCallback(tween:FlxTween):Void
	{
		mMoving = false;
	}
	
	private var mMaxDepth : Int;
	private var mNextChunkDepth : Int;
	
	private var mGridX : Int;
	private var mGridY : Int;
	private var mMoving : Bool;
	
	private var mFacing : Facing;
	
	private var mDirtGrid : DirtGrid;
}