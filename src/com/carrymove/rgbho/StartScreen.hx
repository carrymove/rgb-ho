package com.carrymove.rgbho;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author ildarkarymoff
 */
class StartScreen extends Screen
{

	public function new() 
	{
		super();
		
		graphics.beginFill(0xffffff);
		graphics.drawRect(0, 0, 800, 480);
		graphics.endFill();
		
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	function onClick(e:MouseEvent):Void
	{
		dispatchEvent(new Event(GameEvent.GAMEPLAY_START));
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeEventListener(MouseEvent.CLICK, onClick);
	}
	
	override function onFrame(e:Event = null):Void 
	{
		super.onFrame(e);
	}
	
}