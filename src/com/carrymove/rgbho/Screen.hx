package com.carrymove.rgbho;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.utils.Dictionary;

/**
 * ...
 * @author ildarkarymoff
 */
class Screen extends Sprite
{
	
	public function new() 
	{
		super();
		addEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	public function destroy():Void
	{
		// Clearing graphics and removing all event listeners here...
		removeEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	function onFrame(e:Event = null):Void
	{
		// Rendering graphics here...
	}
	
}