package com.carrymove.rgbho;
import motion.Actuate;
import motion.easing.Quad;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Matrix;

/**
 * ...
 * @author ildarkarymoff
 */
class StartScreen extends Screen
{
	var logo:Bitmap;
	var logoContainer:Sprite;
	var startBtn:Bitmap;
	var startBtnContainer:Sprite;
	var startBtnState = 0;
	var frame:Int;
	
	public function new() 
	{
		super();
		
		logo = new Bitmap(Assets.getBitmapData("img/start.png"));
		logo.smoothing = true;
		logo.x = -logo.width / 2;
		logo.y = -logo.height / 2;
		logoContainer = new Sprite();
		logoContainer.addChild(logo);
		logoContainer.x = 400;
		logoContainer.y = 100;
		logoContainer.scaleX = 0;
		logoContainer.scaleY = 0;
		addChild(logoContainer);
		
		startBtn = new Bitmap(Assets.getBitmapData("img/start_button.png"));
		startBtn.smoothing = true;
		startBtn.x = -startBtn.width / 2;
		startBtn.y = -startBtn.height / 2;
		startBtnContainer = new Sprite();
		startBtnContainer.addChild(startBtn);
		startBtnContainer.x = 400;
		startBtnContainer.y = 350;
		startBtnContainer.useHandCursor = true;
		startBtnContainer.buttonMode = true;
		startBtnContainer.alpha = 0;
		addChild(startBtnContainer);
		
		Actuate.tween(logoContainer, 0.5, {
			scaleX: 1.25,
			scaleY: 1.25
		}).ease(Quad.easeIn).onComplete(function() {
			Actuate.tween(logoContainer, 0.25, {
				scaleX: 1,
				scaleY: 1
			}).ease(Quad.easeOut).onComplete(function() {
				Actuate.tween(startBtnContainer, 1, {
					alpha: 1
				}).ease(Quad.easeIn);
			});
		});
		
		startBtnContainer.addEventListener(MouseEvent.CLICK, onClick);
		startBtnContainer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		startBtnContainer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}
	
	function onClick(e:MouseEvent):Void
	{
		dispatchEvent(new Event(GameEvent.GAMEPLAY_START));
	}
	
	function onMouseOver(e:MouseEvent):Void
	{
		startBtnState = 1;
	}
	
	function onMouseOut(e:MouseEvent):Void
	{
		startBtnState = 0;
	}
	
	override function onFrame(e:Event = null):Void 
	{
		super.onFrame(e);
		
		if (startBtnState == 0) {
			frame++;
		
			var nowScale:Float = Math.abs(Math.cos(frame * 0.05)) * 0.25 + 1;
			
			startBtnContainer.scaleX = nowScale;
			startBtnContainer.scaleY = nowScale;
		}
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		startBtnContainer.removeChild(startBtn);
		removeChild(startBtnContainer);
		
		startBtnContainer.removeEventListener(MouseEvent.CLICK, onClick);
		startBtnContainer.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		startBtnContainer.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}
	
}