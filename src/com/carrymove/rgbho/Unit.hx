package com.carrymove.rgbho;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author ildarkarymoff
 */
class Unit extends Sprite
{
	public var w:Float;
	public var h:Float;
	public var color:UInt;
	public var state:Int = 0;
	
	public function new(x:Float, y:Float, w:Float, h:Float, color:UInt) 
	{
		super();
		
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.color = color;
		
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		draw();
	}
	
	function onMouseOver(e:MouseEvent):Void
	{
		state = 1;
		draw();
	}
	
	function onMouseOut(e:MouseEvent):Void
	{
		state = 0;
		draw();
	}
	
	function onMouseDown(e:MouseEvent):Void
	{
		state = 2;
		draw();
	}
	
	function onMouseUp(e:MouseEvent):Void
	{
		state = 0;
		draw();
		
		var game:GameplayScreen = cast(parent, GameplayScreen);
		cast(game, GameplayScreen);
		if (game.needColor == color) {
			parent.dispatchEvent(new Event(GameEvent.LEVEL_CLEAR));
		} else {
			parent.dispatchEvent(new Event(GameEvent.GAME_OVER));
		}
	}
	
	function draw():Void
	{
		graphics.clear();
		graphics.beginFill(color);
		switch (state) 
		{
			case 0:
				graphics.drawRect(0, 0, w, h);
			case 1:
				graphics.lineStyle(5, 0xffffff, 0.25);
				graphics.drawRect(0, 0, w, h);
			case 2:
				graphics.drawRect(w / 10, h / 10, w - (w / 10) * 2, h - (h / 10) * 2);
		}
		graphics.endFill();
	}
	
}