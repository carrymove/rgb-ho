package com.carrymove.rgbho;
import motion.Actuate;
import motion.easing.Quad;
import openfl.display.SimpleButton;
import openfl.events.Event;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormatAlign;

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
	public var needColor:UInt;
	var colorView:TextField;
	var colorViewFormat:TextFormat;
	var statsView:TextField;
	var manualView:TextField;
	var statsViewFormat:TextFormat;
	var hintButton:SimpleButton;
	var bonusView:Sprite;
	
	public function new() 
	{
		super();
		
		gridView = new Sprite();
		gridView.x = 0;
		gridView.y = 0;
		addChild(gridView);
		
		colorViewFormat = new TextFormat("Gotham Pro", 36);
		colorViewFormat.align = TextFormatAlign.LEFT;
		
		colorView = new TextField();
		colorView.defaultTextFormat = colorViewFormat;
		colorView.selectable = false;
		colorView.width = 280;
		colorView.x = 500;
		colorView.y = 10;
		colorView.text = "#FFFFFF";
		addChild(colorView);
		
		statsViewFormat = new TextFormat("Gotham Pro", 14);
		
		manualView = new TextField();
		manualView.defaultTextFormat = statsViewFormat;
		manualView.selectable = false;
		manualView.width = 280;
		manualView.multiline = true;
		manualView.wordWrap = true;
		manualView.y = 60;
		manualView.x = 500;
		manualView.text = "Select the block with HEX color specified above. Avoid mistakes, otherwise the game will start again.";
		addChild(manualView);
		
		statsView = new TextField();
		statsView.defaultTextFormat = statsViewFormat;
		statsView.selectable = false;
		statsView.width = 280;
		statsView.multiline = true;
		statsView.wordWrap = true;
		statsView.y = 150;
		statsView.x = 500;
		statsView.text = "Level: " + level;
		addChild(statsView);
		
		bonusView = new Sprite();
		bonusView.x = 500;
		bonusView.y = 200;
		bonusView.alpha = 0;
		addChild(bonusView);
		
		fillGrid();
		drawGrid();
		
		addEventListener(GameEvent.LEVEL_CLEAR, onLevelClear);
	}
	
	function showHint():Void
	{
		Actuate.tween(bonusView, 2, {
			alpha: 1
		}).ease(Quad.easeInOut).delay(10);
	}
	
	function hideHint():Void
	{
		bonusView.alpha = 0;
	}
	
	function onLevelClear(e:Event):Void
	{
		level++;
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
		
		needColor = grid[Std.int(Math.random() * grid.length)].color;
		colorViewFormat.color = needColor;
		colorView.defaultTextFormat = colorViewFormat;
		colorView.text = "#" + StringTools.hex(needColor);
		statsView.text = "Level: " + level;
	}
	
	function drawGrid():Void
	{	
		hideHint();
		
		bonusView.graphics.clear();
		bonusView.graphics.beginFill(needColor);
		bonusView.graphics.drawRect(0, 0, 260, 260);
		bonusView.graphics.endFill();
		
		for (iy in 0 ... Std.int(Math.pow(2, level)))
		for (ix in 0 ... Std.int(Math.pow(2, level))) {
			addChild(grid[Std.int(ix + iy * 480 / blockSize )]);
		}
		
		showHint();
	}
	
}