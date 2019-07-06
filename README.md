# chroma-elm
Clone of [Chroma.js](https://gka.github.io/chroma.js)

[Example Site](https://newmana.github.io/chroma-elm/)

[Changelog](https://github.com/newmana/chroma-elm/blob/master/CHANGELOG.md)

# Development
- ```yarn install```
- ```yarn run elm make```
- ```yarn run elm-test```

## Documentation
- ```yarn run parcel examples/index.html```

## Publish to GitHub
- ```yarn run parcel build examples/index.html --out-dir docs --public-url /chroma-elm```

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