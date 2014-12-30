package com.carrymove.rgbho;
import openfl.display.Sprite;

/**
 * ...
 * @author ildarkarymoff
 */
class GameplayScreen extends Screen
{
	var level:Int = 2;
	var gridView:Sprite;
	var grid:Array<UInt>;
	var blockSize:Float;
	
	public function new() 
	{
		super();
		
		gridView = new Sprite();
		gridView.x = 0;
		gridView.y = 0;
		addChild(gridView);
		
		fillGrid();
		drawGrid();
	}
	
	function fillGrid():Void
	{
		blockSize = 480 / Math.pow(2, level);
		
		grid = [];
		for (i in 0 ... Std.int(Math.pow(Math.pow(2, level), 2))) {
		for (j in 0 ... Std.int(Math.pow(Math.pow(2, level), 2)))
			grid[Std.int(j + i * blockSize)] = Std.int(Math.random() * 0xffffff);
		}
	}
	
	function drawGrid():Void
	{	
		gridView.graphics.clear();
		
		for (iy in 0 ... Std.int(Math.pow(2, level)))
		for (ix in 0 ... Std.int(Math.pow(2, level))) {
			gridView.graphics.beginFill(grid[Std.int(ix + iy * blockSize)]);
			gridView.graphics.drawRect(ix * blockSize, iy * blockSize, blockSize, blockSize);
			gridView.graphics.endFill();
		}
	}
	
}