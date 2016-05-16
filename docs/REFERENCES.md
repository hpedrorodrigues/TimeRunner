## References

[build.settings](https://docs.coronalabs.com/guide/distribution/buildSettings/index.html)

[config.lua](https://docs.coronalabs.com/guide/basics/configSettings/index.html)

[Composer](https://docs.coronalabs.com/daily/guide/system/composer/index.html)

[Swipe objects](https://coronalabs.com/blog/2014/09/16/tutorial-swiping-an-object-to-fixed-points/)

Images

- [Wallpaper Zone](http://wallpaper.zone/night-background-images)
- [Wallpaper Zone](https://www.google.com.br/search?q=runner+time+cartoon+background&espv=2&biw=1280&bih=650&source=lnms&tbm=isch&sa=X&ved=0ahUKEwin4rPkzN3MAhVGQCYKHdEAAvAQ_AUIBigB#tbm=isch&tbs=rimg%3ACeiw0kkxF9OfIjjXa_1pFWuIEp9d5IMgni2AiPeo3lSGBTYGEZ5i2WK48CVDDN1KTaST3K9gOhOQXz0q9eTTkgx0D0yoSCddr-kVa4gSnEfSTUpheNxIwKhIJ13kgyCeLYCIR9SRiQgn14f8qEgk96jeVIYFNgRFLHyl2egdxUioSCYRnmLZYrjwJERoAxlW9ayhxKhIJUMM3UpNpJPcRbGoIU6CPrMkqEgkr2A6E5BfPShFf7MjFRPlAJioSCb15NOSDHQPTEf7j_1H4gNDNZ&q=time%20cartoon%20background&imgrc=K9gOhOQXz0oPAM%3A)

Sounds

- [1](http://free-loops.com/8595-lyrical-battle.html)
- [2](http://www.freesound.org/)
- [3](https://www.youtube.com/watch?v=_GRW6N8N5bs)
- [4](http://freemusicarchive.org/music/BoxCat_Games/)
- [5](http://www.playonloop.com/2015-music-loops/time-attack/)

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