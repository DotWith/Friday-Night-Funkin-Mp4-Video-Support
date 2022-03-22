# HxCodec
Native video support for OpenFL.

You should check out our [TODO list](https://github.com/brightfyregit/Friday-Night-Funkin-Mp4-Video-Support/projects/1)

## Credits
- [PolybiusProxy](https://github.com/polybiusproxy) and [BrightFyre](https://github.com/brightfyregit) - Creator of HxCodec.
- [datee](https://github.com/datee) - Creator of HaxeVLC.
- [GWebDev](https://github.com/GrowtopiaFli) - Inspiring me to do this.
- [CryBit](https://github.com/CryBitDev) - fixing HxCodec.
- The "contributors".

## What is HxCodec
(WIP)

HxCodec allows you to put MP4 videos in your project.

## Installation
`haxelib git hxcodec https://github.com/DotWith/Friday-Night-Funkin-Mp4-Video-Support.git haxelib-test`

## Path
In your xml path file, add this code.
```xml
<haxelib name="hxcodec">
```

## Examples
Play a video
```hx
import hxcodec.HxCodec;
```
```hx
var video = new HxCodec();
video.play("your/video/path.mp4");
```
