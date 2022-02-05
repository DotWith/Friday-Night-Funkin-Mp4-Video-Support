package hxCodec;

#if openfl
import openfl.events.Event;
import openfl.Lib;
#end
#if flixel
import flixel.FlxG;
#end

class HxCodec extends hxCodec.cpp.VlcBitmap
{
	/**
	 * As soon as the video has loaded.
	 */
	public var readyCallback:Void->Void;

	/**
	 * Used immediately when the video reaches last frame.
	 */
	public var finishCallback:Void->Void;

	/**
	 * Initializes the video (caching).
	 * 
	 * @param width 	The initial width position of the video.
	 * @param height 	The initial height position of the video.
	 */
	public function new(?width:Float = 0, ?height:Float = 0)
	{
		super(width, height);

		onVideoReady = onVLCVideoReady;
		onComplete = skip;
		onError = onVLCError;

		#if flixel
		FlxG.addChildBelowMouse(this);
		#end

		#if lime
		var window = lime.app.Application.current.window;

		window.onFocusOut.add(() -> pause());
		window.onFocusIn.add(() -> resume());
		#end

		#if openfl
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
		#end
	}

	function update(e)
	{
		#if flixel
		if (FlxG.sound.muted || FlxG.sound.volume <= 0)
			volume = 0;
		else
			volume = FlxG.sound.volume + 0.4;
		#end
	}

	function onVLCVideoReady()
	{
		trace("[VLC] Video loaded!");

		if (readyCallback != null)
			readyCallback();
	}

	function onVLCError(error:Dynamic)
	{
		trace('[VLC] Error: $error');
	}

	/**
	 * When the video is playing. It can be skipped.
	 */
	public function skip():Void
	{
		if (!isPlaying)
			return;

		#if openfl
		Lib.current.stage.removeEventListener(Event.ENTER_FRAME, update);
		#end

		dispose();

		#if openfl
		if (Lib.current.contains(this))
		{
			Lib.current.removeChild(this);

			if (finishCallback != null)
				finishCallback();
		}
		#end
	}

	/**
	 * The path of the videos.
	 * 
	 * @param url 		Example: `your/video/path.mp4`
	 * @param repeat 	Repeat the video.
	 */
	public override function play(?source:String)
	{
		super.play(checkFile(source));
	}

	/**
	 * Receives the file path. Doesn't work on HTML5.
	 * 
	 * @param fileName 	The path of the video.
	 * @return 			Example `file:///C:/The/Path/To/The/Game/assets/videos/video.mp4`
	 */
	@:noCompletion
	function checkFile(fileName:String):String
	{
		var pDir = "";

		if (fileName.indexOf(":") == -1) // Not a path
			pDir = "file:///" + Sys.getCwd() + "/";
		else if (fileName.indexOf("file://") == -1 || fileName.indexOf("http") == -1) // C:, D: etc? ..missing "file:///" ?
			pDir = "file:///";

		return pDir + fileName;
	}
}
