# chroma-elm
A native version of [Chroma.js](https://gka.github.io/chroma.js) that allows you to:
 * use W3C X11 color names.   
 * create color scales, 
 * use different color spaces such as CMYK, HSLA, LAB, LCH and RGB, 
 * modify colors using interpolate, set/get alpha, lighten/darken, saturate/desaturate, 
 * use existing color maps such as Brewer, Cividis, Turbo, Sinebow, Parula, Virdis, Plasma, Magma and Inferno, and

There is [an example site](https://newmana.github.io/chroma-elm/) showing how to use the library.

[Changelog](https://github.com/newmana/chroma-elm/blob/master/CHANGELOG.md)

# Development
- ```yarn install```
- ```yarn run make```
- ```yarn run test```

## Documentation
- ```yarn run local-doc```

## Publish to GitHub
- ```yarn run doc```

# Links

How to release Elm package:
```
elm bump
git add elm.json
git commit -m "2.0.0 - description of changes"
git tag 2.0.0
git push origin master 2.0.0
elm publish
``` 
- https://medium.com/@Max_Goldstein/how-to-publish-an-elm-package-3053b771e545

Beautiful Colormaps:
- https://matplotlib.org/cmocean/

Idiomatic Guide to Releasing Elm:
- https://github.com/dillonkearns/idiomatic-elm-package-guide

# Thanks

Many thanks to Indicatrix (https://indicatrix.io) for supporting this project.