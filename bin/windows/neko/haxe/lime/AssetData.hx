package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("img/gameover.png", "img/gameover.png");
			type.set ("img/gameover.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/retry_button.png", "img/retry_button.png");
			type.set ("img/retry_button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/start.png", "img/start.png");
			type.set ("img/start.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/start_button.png", "img/start_button.png");
			type.set ("img/start_button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("fonts/GothaProReg.otf", "fonts/GothaProReg.otf");
			type.set ("fonts/GothaProReg.otf", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
