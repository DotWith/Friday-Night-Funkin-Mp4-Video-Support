/*
 * MIT License
 *
 * Copyright (c) 2021 PolybiusProxy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package hxcodec;

import flash.events.Event;

#if flixel
import flixel.FlxG;
#end

class HxCodec extends hxcodec.cpp.VlcBitmap
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

		addEventListener(Event.ENTER_FRAME, update);
	}

	function update(_)
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

		removeEventListener(Event.ENTER_FRAME, update);

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
	 * @return 			Example `file:///C:/your/video/path.mp4`
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
