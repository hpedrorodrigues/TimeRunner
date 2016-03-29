## References

[build.settings](https://docs.coronalabs.com/guide/distribution/buildSettings/index.html)

[config.lua](https://docs.coronalabs.com/guide/basics/configSettings/index.html)

[Composer](https://docs.coronalabs.com/daily/guide/system/composer/index.html)

[Swipe objects](https://coronalabs.com/blog/2014/09/16/tutorial-swiping-an-object-to-fixed-points/)

Images

- [1](http://www.hdwallpaperscool.com/running-hd-wallpapers/)
- [2](http://www.iconarchive.com/show/100-flat-2-icons-by-graphicloads/information-icon.html)
- [3](http://imgur.com/gallery/TkW97)
- [4](http://spritefx.blogspot.com.br/2013/04/sprite-animals.html)

Sounds

- [1](http://free-loops.com/8595-lyrical-battle.html)
- [2](http://www.freesound.org/)

[Sprites](https://docs.coronalabs.com/api/library/graphics/newImageSheet.html)

```
x - Number. x-location of the frame in the texture.
y - Number. y-location of the frame in the texture.
width - Number. Width of the frame (if cropping, specify cropped width here).
height - Number. Height of the frame (if cropping, specify cropped height here).
sourceWidth - Number. Width of the original uncropped frame. Default: same as width (required parameter).
sourceHeight - Number. Height of the original uncropped frame. Default: same as height (required parameter).
sourceX - Number. The x-origin of the crop rect relative to the uncropped image. Default: 0.
sourceY - Number. The y-origin of the crop rect relative to the uncropped image. Default: 0.
border - Number. The amount of pixels around each individual frame. This is necessary for scaling image sheets
    without getting blending artifacts around the edges. Default: 0.
sheetContentWidth / sheetContentHeight - These values tell Corona the size of the original 1x image sheet.
    For example, if you're developing for both iPad and iPad Retina, and you're using an image sheet of
    1000×1000 for the regular iPad, you should specify 1000 for both of these values and then design your
    Retina image sheet at 2000×2000. For more information on this topic, see the Project Configuration guide.
```