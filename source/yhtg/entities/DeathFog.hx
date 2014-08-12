package yhtg.entities;

import flixel.FlxSprite;

import yhtg.scene.Dirt;
import yhtg.scene.DirtChunk;
import yhtg.utils.AssetDataUtil;

/**
 * ...
 * @author Jams
 */
class DeathFog extends FlxSprite
{

	public function new(X:Float, Y:Float, initVel:Float) 
	{
		super(X, Y);
		loadGraphic(AssetDataUtil.EFFECT_PARTICLE, false);
		setGraphicSize(Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE, Dirt.DIRT_SIZE);
		setSize(Dirt.DIRT_SIZE * DirtChunk.CHUNK_SIZE, Dirt.DIRT_SIZE);
		color = 0xFF3333;
		
		this.velocity.set(0, initVel);
	}
}