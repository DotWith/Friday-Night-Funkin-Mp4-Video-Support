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

	@:native("LibVLC::setPath")
	public function setPath(path:String):Void;

	@:native("LibVLC::openMedia")
	public function openMedia(path:String):Void;

	@:native("LibVLC::play")
	@:overload(function():Void
	{
	})
	public function play(path:String):Void;

	@:native("LibVLC::playInWindow")
	@:overload(function():Void
	{
	})
	public function playInWindow(path:String):Void;

	@:native("LibVLC::stop")
	public function stop():Void;

	@:native("LibVLC::pause")
	public function pause():Void;

	@:native("LibVLC::resume")
	public function resume():Void;

	@:native("LibVLC::togglePause")
	public function togglePause():Void;

	@:native("LibVLC::fullscreen")
	public function setWindowFullscreen(fullscreen:Bool):Void;

	@:native("LibVLC::showMainWindow")
	public function showMainWindow(show:Bool):Void;

	@:native("LibVLC::getLength")
	public function getLength():Float;

	@:native("LibVLC::getDuration")
	public function getDuration():Float;

	@:native("LibVLC::getWidth")
	public function getWidth():Int;

	@:native("LibVLC::getHeight")
	public function getHeight():Int;

	@:native("LibVLC::getMeta")
	public function getMeta(meta:Dynamic):String;

	@:native("LibVLC::isPlaying")
	public function isPlaying():Bool;

	@:native("LibVLC::isSeekable")
	public function isSeekable():Bool;

	@:native("LibVLC::setVolume")
	public function setVolume(volume:Float):Void;

	@:native("LibVLC::getVolume")
	public function getVolume():Float;

	@:native("LibVLC::getTime")
	public function getTime():Int;

	@:native("LibVLC::setTime")
	public function setTime(time:Int):Void;

	@:native("LibVLC::getPosition")
	public function getPosition():Float;

	@:native("LibVLC::setPosition")
	public function setPosition(pos:Float):Void;

	@:native("LibVLC::useHWacceleration")
	public function useHWacceleration(hwAcc:Bool):Void;

	@:native("LibVLC::getLastError")
	public function getLastError():String;

	@:native("LibVLC::getRepeat")
	public function getRepeat():Int;

	@:native("LibVLC::setRepeat")
	public function setRepeat(repeat:Int = 1):Void;

	#if cpp
	@:native("LibVLC::getPixelData")
	public function getPixelData():Pointer<UInt8>;
	#end

	@:native("LibVLC::getFPS")
	public function getFPS():Float;

	@:native("LibVLC::flags")
	public var flags:Array<Int>;
}
