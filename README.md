# firetype

## Goals

*firetype* is an Open Source Actionscript 3 library that parses OpenType fonts, converts the contained vector glyphs into polygon shapes and renders them using Stage3D via the GPU.

One of the examples for a similar technology would be [Scaleform](http://gameware.autodesk.com/scaleform) which is used in many big-budget productions to render hardware accelerated text and UI elements.

*firetype* aims to make similar functionality available for Actionscript 3 developers using Stage3D.

## How To Use *firetype*

### Table of Contents

* [Preliminaries](#preliminaries)
* [How Do I Display Text With *firetype*?](#how-do-i-display-text-with-firetype)
* [How Do I Apply Formatting to Texts?](#how-do-i-apply-formatting-to-texts)

### Preliminaries

As with any Stage3D project, you will need to set up a couple of things first. Basically, *firetype* expects the following things in order to run:

1. A [`Context3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3D.html) object.
1. A [`Matrix3D`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/geom/Matrix3D.html) object containing a view/projection matrix.

You can get a quick overview of a basic document class using *firetype* by looking at [the code of the first firetype tutorial](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

### How Do I Display Text With *firetype*?

These are the basic steps needed to display text using *firetype*. You can find an implementation of this tutorial at [FiretypeTutorial1.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial1.as).

Create a `HardwareText` object and pass it the `Context3D` object in the constructor.

```ActionScript
_hardwareText = new HardwareText(_context3d);
```

You can assign a `String` via the `text` property.

```ActionScript
_hardwareText.text = "Hello World!\nThis text is being rendered using firetype!";
```

You can set the position of the `HardwareText` object via the `x` and `y` properties. You can set the scale of the `HardwareText` with the `scaleX` and `scaleY` properties.

```ActionScript
_hardwareText.scaleX = _hardwareText.scaleY = 0.02;
_hardwareText.x = -320;
```

**Note:** *firetype* makes no assumptions about the scale you want to render the text in. It renders the characters with their original measurements, as they are stored in the font file. Because of this, a character is usually 500-1500 units tall. You will probably need to either scale down the `HardwareText` via the `scaleX` and `scaleY` properties or zoom out via the view/projection matrix.

In order to be rendered properly, the `HardwareText` object needs a projection matrix.

```ActionScript
_hardwareText.calculateTransformations(viewProjection, true);
```

The second parameter needs to be `true` to signal the `HardwareText` that it needs to recalculate it's transformations based on the matrix passed to it.

This function needs to be called everytime the view or projection changes.

Finally, we can render the text via the `HardwareCharacterCache` object stored in the `HardwareText`.

```ActionScript
_hardwareText.cache.render();
```

Running this code should result in an image similar to this:

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial1_result.png)

### How Do I Apply Formatting to Texts?

You can apply different colors, sizes or alignments to sections of text by using the `<format>` tag. The `<format>` accepts several attributes. The basic attributes are
* `color`
* `scale`
* `shearX`
* `shearY`
* `textAlign`
	
The values of attributes have to be put either into single or double quotation marks.

You can find an implementation of this tutorial at [FiretypeTutorial2.as](https://github.com/MaxDidIt/firetype/blob/master/src/test/flash/de/maxdidit/hardware/font/FiretypeTutorial2.as).

You can change the text color with the **color** attribute. The value is either passed as a RGB or ARGB hexadecimal number.
```ActionScript
_hardwareText.text = "You can <format color='0xFF6611'>change the text color</format> with the <format color='0xFF0000'>color</format> attribute.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result2.png)

You can scale sections of a text with the **scale** attribute. The value is expected to be a floating point number.
```ActionScript
_hardwareText.text = "You can <format scale='0.66'>scale sections of a text</format> with the <format color='0xFF0000'>scale</format> attribute.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result1.png)

You can slant a portion of text with the **shearX** attribute. You can slant individual characters along the Y axis with the **shearY** attributes. Both attributes expect floating point numbers as values.
```ActionScript
_hardwareText.text = "You can <format shearX='0.3'>slant a portion of a text</format> with the <format color='0xFF0000'>shearX</format> attribute.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result3.png)

```ActionScript
_hardwareText.text = "<format textAlign='" + TextAlign.RIGHT + "'>You can set the text alignment with the <format color='0xFF0000'>textAlign</format> attribute. You should use the constants of the TextAlign class as values for the attribute.\n</format>";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result5.png)

### How Do I Control the Level of Detail of Characters?

![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision400.png)
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision200.png)
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision100.png)
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/precision50.png)

```ActionScript
_hardwareText.text = "You can make characters appear\n<format scale='1.5' vertexDistance='3000'>edged</format> (vertexDistance='3000') or\n<format scale='1.5' vertexDistance='50'>smooth</format> (vertexDistance='50') with the <format color='0xFF0000'>vertexDistance</format> attribute. Lower vertexDistance values will have an impact on performance.";
```
![The text rendered with firetype.](http://www.max-did-it.com/projects/firetype/tutorial2_result4.png)