package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:sizei193802y4:typey5:SOUNDy2:idy25:assets%2Fsounds%2Fhit.wavy9:pathGroupaR4y25:assets%2Fsounds%2Fhit.mp3hy7:preloadtgoR0i18527R1y5:MUSICR3R6R5aR4R6hgoR0i10532R1R2R3y28:assets%2Fsounds%2Fselect.wavR5aR9hR7tgoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txtR0zR1y4:TEXTR3R11R7tgoR10y31:assets%2Fimages%2Fsnow_jump.pngR0i5884R1y5:IMAGER3R13R7tgoR10y27:assets%2Fimages%2Fboard.pngR0i588R1R14R3R15R7tgoR10y28:assets%2Fimages%2Fshadow.pngR0i650R1R14R3R16R7tgoR10y32:assets%2Fimages%2Fboard_jump.pngR0i718R1R14R3R17R7tgoR10y31:assets%2Fimages%2Fboard_guy.tpsR0i8393R1R12R3R18R7tgoR10y26:assets%2Fimages%2Ftree.pngR0i1984R1R14R3R19R7tgoR10y31:assets%2Fimages%2Fmenu_icon.pngR0i4342R1R14R3R20R7tgoR10y28:assets%2Fimages%2Fboard.jsonR0i1307R1R12R3R21R7tgoR10y32:assets%2Fimages%2Fboard_guy3.pngR0i747R1R14R3R22R7tgoR10y32:assets%2Fimages%2Fboard_guy4.pngR0i736R1R14R3R23R7tgoR10y32:assets%2Fimages%2Fboard_fall.pngR0i663R1R14R3R24R7tgoR10y32:assets%2Fimages%2Fboard_guy5.pngR0i688R1R14R3R25R7tgoR10y32:assets%2Fimages%2Fboard_guy2.pngR0i726R1R14R3R26R7tgoR10y31:assets%2Fimages%2Fboard_guy.pngR0i675R1R14R3R27R7tgoR0i1671021R1R8R3y32:assets%2Fmusic%2Falpina_blue.oggR5aR28y32:assets%2Fmusic%2Falpina_blue.mp3hR7tgoR0i3480237R1R8R3R29R5aR28R29hgoR0i2114R1R8R3y26:flixel%2Fsounds%2Fbeep.mp3R5aR30y26:flixel%2Fsounds%2Fbeep.ogghR7tgoR0i39706R1R8R3y28:flixel%2Fsounds%2Fflixel.mp3R5aR32y28:flixel%2Fsounds%2Fflixel.ogghR7tgoR0i5794R1R2R3R31R5aR30R31hgoR0i33629R1R2R3R33R5aR32R33hgoR0i15744R1y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR3y30:flixel%2Ffonts%2Fnokiafc22.ttfR7tgoR0i29724R1R34R35y36:__ASSET__flixel_fonts_monsterrat_ttfR3y31:flixel%2Ffonts%2Fmonsterrat.ttfR7tgoR10y33:flixel%2Fimages%2Fui%2Fbutton.pngR0i519R1R14R3R40R7tgoR10y36:flixel%2Fimages%2Flogo%2Fdefault.pngR0i3280R1R14R3R41R7tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hit_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hit_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_select_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_snow_jump_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shadow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_jump_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_guy_tps extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tree_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_guy3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_guy4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_fall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_guy5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_guy2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_board_guy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_alpina_blue_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_alpina_blue_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/sounds/hit.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_hit_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hit.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_hit_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/select.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_select_wav extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/snow_jump.png") @:noCompletion #if display private #end class __ASSET__assets_images_snow_jump_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_png extends lime.graphics.Image {}
@:keep @:image("assets/images/shadow.png") @:noCompletion #if display private #end class __ASSET__assets_images_shadow_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board_jump.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_jump_png extends lime.graphics.Image {}
@:keep @:file("assets/images/board_guy.tps") @:noCompletion #if display private #end class __ASSET__assets_images_board_guy_tps extends haxe.io.Bytes {}
@:keep @:image("assets/images/tree.png") @:noCompletion #if display private #end class __ASSET__assets_images_tree_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu_icon.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_icon_png extends lime.graphics.Image {}
@:keep @:file("assets/images/board.json") @:noCompletion #if display private #end class __ASSET__assets_images_board_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/board_guy3.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_guy3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board_guy4.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_guy4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board_fall.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_fall_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board_guy5.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_guy5_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board_guy2.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_guy2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/board_guy.png") @:noCompletion #if display private #end class __ASSET__assets_images_board_guy_png extends lime.graphics.Image {}
@:keep @:file("assets/music/alpina_blue.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_alpina_blue_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/alpina_blue.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_alpina_blue_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/ben/haxelib/flixel/4,10,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/ben/haxelib/flixel/4,10,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/ben/haxelib/flixel/4,10,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/home/ben/haxelib/flixel/4,10,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/home/ben/haxelib/flixel/4,10,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/home/ben/haxelib/flixel/4,10,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
