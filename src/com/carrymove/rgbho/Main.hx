package com.carrymove.rgbho;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

/**
 * ...
 * @author ildarkarymoff
 */

class Main extends Sprite 
{
	var inited:Bool;
	var screen:Screen;
	var currentLevel:Int = 1;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		screen = new StartScreen();
		screen.addEventListener(GameEvent.GAMEPLAY_START, onGameplayStart);
		addChild(screen);
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */
	
	function onGameplayStart(e:Event):Void
	{
		screen.removeEventListener(GameEvent.GAMEPLAY_START, onGameplayStart);
		removeChild(screen);
		screen.destroy();
		screen = new GameplayScreen(currentLevel);
		screen.addEventListener(GameEvent.LEVEL_CLEAR, onLevelClear);
		addChild(screen);
	}
	
	function onGameOver(e:Event):Void
	{
		screen.removeEventListener(GameEvent.GAME_OVER, onGameOver);
		removeChild(screen);
		screen.destroy();
	}
	
	function onLevelClear(e:Event):Void
	{
		screen.removeEventListener(GameEvent.LEVEL_CLEAR, onLevelClear);
		removeChild(screen);
		screen.destroy();
		currentLevel++;
		screen = new GameplayScreen(currentLevel);
		screen.addEventListener(GameEvent.LEVEL_CLEAR, onLevelClear);
		addChild(screen);
	}

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
