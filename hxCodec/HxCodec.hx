package hxCodec;

#if openfl
import openfl.events.Event;
import openfl.Lib;
#end
#if flixel
import flixel.FlxG;
#end

class HxCodec extends hxCodec.vlc.VlcBitmap
{
	public var readyCallback:Void->Void;
	public var finishCallback:Void->Void;

	/**
	 * Initializes the video (caching).
	 * 
	 * @param width 	WIP
	 * @param height 	WIP
	 * @param autoScale Remove
	 */
	public function new(width:Float = 320, height:Float = 240, autoScale:Bool = true)
	{
		super(width, height, autoScale);

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

		#if (openfl && flixel)
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
		#end
		#end
	}

	#if openfl
	function update(e:Event)
	{
		#if flixel
		if (FlxG.sound.muted || FlxG.sound.volume <= 0)
			volume = 0;
		else
			volume = FlxG.sound.volume + 0.4;
		#end
	}
	#end

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

		#if (openfl && lime && flixel)
		Lib.current.stage.removeEventListener(Event.ENTER_FRAME, update);
		#end

		dispose();

		#if flixel
		if (FlxG.game.contains(this))
		{
			FlxG.game.removeChild(this);

			if (finishCallback != null)
				finishCallback();
		}
		#end
	}

	/**
	 * The path of the videos.
	 * 
	 * @param url Example: `your/video/path.mp4`
	 * @param repeat Repeat the video.
	 */
	/*public override function play(?url:String, ?repeat:Int = -1)
		{
			super.play(checkFile(url));

			this.repeat = repeat;
	}*/
	public override function play(?source:String)
	{
		super.play(checkFile(source));
	}

	function checkFile(fileName:String):String
	{
		var pDir = "";

		if (fileName.indexOf(":") == -1) // Not a path
			pDir = "file:///" + #if sys Sys.getCwd() + #end "/";
		else if (fileName.indexOf("file://") == -1 || fileName.indexOf("http") == -1) // C:, D: etc? ..missing "file:///" ?
			pDir = "file:///";

		return pDir + fileName;
	}
}
