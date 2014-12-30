package com.carrymove.rgbho;
import openfl.display.Sprite;

/**
 * ...
 * @author ildarkarymoff
 */
class GameplayScreen extends Screen
{
	var level:Int = 1;
	var gridView:Sprite;
	var grid:Array<Unit>;
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
		for (i in 0 ... Std.int(Math.pow(2, level))) {
		for (j in 0 ... Std.int(Math.pow(2, level)))
			grid.push(new Unit(j * blockSize, i * blockSize, blockSize, blockSize, Std.int(Math.random() * 0xffffff)));
		}
		
		trace(grid.length);
	}
	
	function drawGrid():Void
	{	
		for (iy in 0 ... Std.int(Math.pow(2, level)))
		for (ix in 0 ... Std.int(Math.pow(2, level))) {
			addChild(grid[Std.int(ix + iy * 480 / blockSize )]);
		}
	}
	
}