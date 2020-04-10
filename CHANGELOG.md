# Changelog
All notable changes to this project will be documented in this file.

## [16.0.4] - 2020-04-11
### Changed
- Added elm-review and elm-coverage. 

## [16.0.0] - 2019-09-06
### Fixed
- Add Head/Tail to Limits API. 

## [15.0.0] - 2019-09-05
### Fixed
- Luminance API was incorrect order of paramters. 

## [14.0.0] - 2019-09-04
### Changed
- Moved utility code out of W3CX11 and into Ops.Numeric. 

## [13.3.0] - 2019-09-04
### Changed
- Fix blend documentation 

## [13.2.0] - 2019-09-03
### Added
- Head/Tail Limits 

## [13.1.0] - 2019-09-02
### Added
- Cmocean color map 

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

## [1.0.0] - 2019-01-24
### Added
- Creating a rather ropey initial API Scale.getColor.
- Supports domain and correctLightness (buggy when used with domain).
