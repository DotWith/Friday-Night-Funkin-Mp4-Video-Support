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

package hxcodec.cpp;

#if cpp
import cpp.Pointer;
import cpp.UInt8;
#end

/**
 * ...
 * @author Tommy S
 */
@:buildXml("<include name='${haxelib:hxcodec}/build_files/windows.xml'/>")
@:include("LibVLC.h")
@:unreflective
@:keep
@:native("LibVLC*")
extern class LibVLC
{
	@:native("LibVLC::create")
	public static function create():LibVLC;

	@:native("setPath")
	public function setPath(path:String):Void;

	@:native("openMedia")
	public function openMedia(path:String):Void;

	@:native("play")
	@:overload(function():Void
	{
	})
	public function play(path:String):Void;

	@:native("playInWindow")
	@:overload(function():Void
	{
	})
	public function playInWindow(path:String):Void;

	@:native("stop")
	public function stop():Void;

	@:native("pause")
	public function pause():Void;

	@:native("resume")
	public function resume():Void;

	@:native("togglePause")
	public function togglePause():Void;

	@:native("fullscreen")
	public function setWindowFullscreen(fullscreen:Bool):Void;

	@:native("showMainWindow")
	public function showMainWindow(show:Bool):Void;

	@:native("getLength")
	public function getLength():Float;

	@:native("getDuration")
	public function getDuration():Float;

	@:native("getWidth")
	public function getWidth():Int;

	@:native("getHeight")
	public function getHeight():Int;

	@:native("getMeta")
	public function getMeta(meta:Dynamic):String;

	@:native("isPlaying")
	public function isPlaying():Bool;

	@:native("isSeekable")
	public function isSeekable():Bool;

	@:native("setVolume")
	public function setVolume(volume:Float):Void;

	@:native("getVolume")
	public function getVolume():Float;

	@:native("getTime")
	public function getTime():Int;

	@:native("setTime")
	public function setTime(time:Int):Void;

	@:native("getPosition")
	public function getPosition():Float;

	@:native("setPosition")
	public function setPosition(pos:Float):Void;

	@:native("useHWacceleration")
	public function useHWacceleration(hwAcc:Bool):Void;

	@:native("getLastError")
	public function getLastError():String;

	@:native("getRepeat")
	public function getRepeat():Int;

	@:native("setRepeat")
	public function setRepeat(repeat:Int = 1):Void;

	#if cpp
	@:native("getPixelData")
	public function getPixelData():Pointer<UInt8>;
	#end

	@:native("getFPS")
	public function getFPS():Float;

	@:native("flags")
	public var flags:Array<Int>;
}
