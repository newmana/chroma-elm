# chroma-elm
A native version of [Chroma.js](https://gka.github.io/chroma.js) that allows you to:
 * use W3C X11 color names,
 * cluster data points using algorithms: CkMeans, equal, head/tail, Jenks, logarithmic or quantile,   
 * create color scales, 
 * use different color spaces such as CMYK, HSLA, LAB, LCH and RGB, 
 * modify colors using interpolate, set/get alpha, lighten/darken, saturate/desaturate,
 * compare colors using WCAG contrast, 
 * use existing color maps such as Brewer, cmocean, Material, Cividis, Turbo, Sinebow, Parula, Virdis, Plasma, Magma and Inferno.

There is [an example site](https://newmana.github.io/chroma-elm/) showing how to use the library.

[Changelog](https://github.com/newmana/chroma-elm/blob/master/CHANGELOG.md)

## Development
- `yarn install`
- `yarn run make`
- `yarn run test`
- `yarn run review`
- `yarn run coverage`
- `yarn run full` (test && review)

# Test Coverage
[Coverage Report](https://newmana.github.io/chroma-elm/coverage.html)

### Benchmarks
- `yarn run benchmarks`

101 Data Points, Limits on an Apple M1, Chrome 96.0:

```text
| Algorithm     | Runs/Second   |
| ------------- | ------------- |
| CkMeans       | 846           |
| Equal         | 48,311        |
| HeadTail      | 32,197        |
| Jenks         | 108           |
| Logarithmic   | 48,017        |
| Quantile      | 40,905        |
```

### Documentation
- `yarn run local-doc`

### Publish to GitHub
- `yarn run doc`

## Links
                
### Elm
- [Elm Documentation Previewer](https://elm-doc-preview.netlify.com/)
- [How to publish an Elm package](https://medium.com/@Max_Goldstein/how-to-publish-an-elm-package-3053b771e545)
  ```shell
  elm bump
  git add elm.json
  git commit -m "2.0.0 - description of changes"
  git tag 2.0.0
  git push origin main 2.0.0
  elm publish
  ```
- [Idiomatic Guide to Releasing Elm](https://github.com/dillonkearns/idiomatic-elm-package-guide)

### Color Maps
- [Beautiful Colormaps](https://matplotlib.org/cmocean/)
- [Turbo, An Improved Rainbow Colormap for Visualization](https://ai.googleblog.com/2019/08/turbo-improved-rainbow-colormap-for.html)

## Thanks

Many thanks to [Indicatrix](https://indicatrix.io) for supporting this project.