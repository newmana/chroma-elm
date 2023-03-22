# Changelog
All notable changes to this project will be documented in this file.

## [18.0.3](https://github.com/newmana/chroma-elm/compare/18.0.0...18.0.3) - 2020-11-12
### Fixed
- Missing/wrong color definitions for Brewer.

## [18.0.0] - 2020-05-06
### Fixed
- Performance improvements for CkMeans and Jenks clustering.

## [17.2.0] - 2020-05-05
### Added
- Material palette. 

## [17.0.0] - 2020-05-04
### Added
- Jenks clustering. 

## [16.0.4] - 2020-04-11
### Added
- elm-review and elm-coverage. 

## [16.0.0] - 2019-09-06
### Fixed
- Head/Tail was missing from the Limits module. 

## [15.0.0] - 2019-09-05
### Fixed
- Luminance parameters were out of order. 

## [14.0.0] - 2019-09-04
### Changed
- Moved utility code out of W3CX11 and into Ops.Numeric. 

## [13.3.0] - 2019-09-04
### Fixed
- Blend documentation. 

## [13.2.0] - 2019-09-03
### Added
- Head/Tail clustering. 

## [13.1.0] - 2019-09-02
### Added
- Cmocean color map. 

## [13.0.0] - 2019-09-01
### Added
- ToCss - For rgb and rgba values.
- Contrast - use WCAG calculating the difference in Luminance of two colors.
- Add Blend
- scaleF, domainF and colorsF - accepts a function Float -> ExtColor
### Fixed
- toRgba255 - Clamp to produce maximum 255 values.
### Changed
- Moved functions operating on Color to top level module.

## [12.0.0] - 2019-08-29
### Added
- Parula, Sinebow, Turbo and Cividis color maps.
- scaleF, domainF and colorsF - accepts a function Float -> ExtColor

## [11.0.0] - 2019-08-17
### Fixed
- Order of limits function in Chroma.
- Description of package.

## [10.0.0] - 2019-08-01
### Added
- Limits - CkMean, Equal, Logarithmic and Quantile.
- Luminance.
- Average and Mix.
### Fixed
- CMKY interpolation.
### Changed
- Alpha now part of the name of color spaces that support it.  

## [9.0.0] - 2019-07-06
### Added
- Added full HSLA support. 

## [8.0.0] - 2019-07-03
### Added
- Added color operations: colors and colorsWith.
- Add interpolation for LCH.

## [7.0.0] - 2019-07-03
### Added
- Added color operations: get/set alpha, lighten/darken and saturate/desature.
- LCH Support (and converters).

## [6.0.0] - 2019-06-27
### Added
- Example template.
- Plasma color map.

### Fixed
- ToCymk corrected names/values of record.
- Cleaned up color types.

## 1.0.0 - 2019-01-24
### Added
- Creating a rather ropey initial API Scale.getColor.
- Supports domain and correctLightness (buggy when used with domain).

[18.0.0]: https://github.com/newmana/chroma-elm/compare/17.2.0...18.0.0
[17.2.0]: https://github.com/newmana/chroma-elm/compare/17.0.0...17.2.0
[17.0.0]: https://github.com/newmana/chroma-elm/compare/16.0.4...17.0.0
[16.0.4]: https://github.com/newmana/chroma-elm/compare/16.0.0...16.0.4
[16.0.0]: https://github.com/newmana/chroma-elm/compare/15.0.0...16.0.0
[15.0.0]: https://github.com/newmana/chroma-elm/compare/14.0.0...15.0.0
[14.0.0]: https://github.com/newmana/chroma-elm/compare/13.3.0...14.0.0
[13.3.0]: https://github.com/newmana/chroma-elm/compare/13.2.0...13.3.0
[13.2.0]: https://github.com/newmana/chroma-elm/compare/13.1.0...13.2.0
[13.1.0]: https://github.com/newmana/chroma-elm/compare/13.0.0...13.1.0
[13.0.0]: https://github.com/newmana/chroma-elm/compare/12.0.0...13.0.0
[12.0.0]: https://github.com/newmana/chroma-elm/compare/11.0.0...12.0.0
[11.0.0]: https://github.com/newmana/chroma-elm/compare/10.0.0...11.0.0
[10.0.0]: https://github.com/newmana/chroma-elm/compare/9.0.0...10.0.0
[9.0.0]: https://github.com/newmana/chroma-elm/compare/8.0.0...9.0.0
[8.0.0]: https://github.com/newmana/chroma-elm/compare/7.0.0...8.0.0
[7.0.0]: https://github.com/newmana/chroma-elm/compare/6.0.0...7.0.0
[6.0.0]: https://github.com/newmana/chroma-elm/compare/1.0.0...6.0.0
