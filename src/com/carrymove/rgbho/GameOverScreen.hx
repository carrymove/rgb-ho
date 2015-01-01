package com.carrymove.rgbho;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import motion.Actuate;
import motion.easing.Quad;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author ildarkarymoff
 */
class GameOverScreen extends Screen
{
	var gameover:Bitmap;
	var gameoverContainer:Sprite;
	var retryBtn:Bitmap;
	var retryBtnContainer:Sprite;
	var retryBtnState:Int = 0;
	var frame:Int;
	
	public function new() 
	{
		super();
		
		gameover = new Bitmap(Assets.getBitmapData("img/gameover.png"));
		gameover.smoothing = true;
		gameover.x = -gameover.width / 2;
		gameover.y = -gameover.height / 2;
		gameoverContainer = new Sprite();
		gameoverContainer.addChild(gameover);
		gameoverContainer.x = 400;
		gameoverContainer.y = 200;
		gameoverContainer.scaleX = 0;
		gameoverContainer.scaleY = 0;
		addChild(gameoverContainer);
		
		retryBtn = new Bitmap(Assets.getBitmapData("img/retry_button.png"));
		retryBtn.smoothing = true;
		retryBtn.x = -retryBtn.width / 2;
		retryBtn.y = -retryBtn.height / 2;
		retryBtnContainer = new Sprite();
		retryBtnContainer.addChild(retryBtn);
		retryBtnContainer.x = 400;
		retryBtnContainer.y = 300;
		retryBtnContainer.useHandCursor = true;
		retryBtnContainer.buttonMode = true;
		retryBtnContainer.alpha = 0;
		addChild(retryBtnContainer);
		
		Actuate.tween(gameoverContainer, 0.5, {
			scaleX: 1.25,
			scaleY: 1.25
		}).ease(Quad.easeIn).onComplete(function() {
			Actuate.tween(gameoverContainer, 0.25, {
				scaleX: 1,
				scaleY: 1
			}).ease(Quad.easeOut).onComplete(function() {
				Actuate.tween(retryBtnContainer, 1, {
					alpha: 1
				}).ease(Quad.easeIn);
			});
		});
		
		retryBtnContainer.addEventListener(MouseEvent.CLICK, onClick);
		retryBtnContainer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		retryBtnContainer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}
	
	function onClick(e:MouseEvent):Void
	{
		dispatchEvent(new Event(GameEvent.RESTART));
	}
	
	function onMouseOver(e:MouseEvent):Void
	{
		retryBtnState = 1;
	}
	
	function onMouseOut(e:MouseEvent):Void
	{
		retryBtnState = 0;
	}
	
	override function onFrame(e:Event = null):Void 
	{
		super.onFrame(e);
		
		if (retryBtnState == 0) {
			frame++;
		
			var nowScale:Float = Math.abs(Math.cos(frame * 0.05)) * 0.25 + 1;
			
			retryBtnContainer.scaleX = nowScale;
			retryBtnContainer.scaleY = nowScale;
		}
	}
	
}