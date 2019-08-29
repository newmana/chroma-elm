# Changelog
All notable changes to this project will be documented in this file.

## [11.0.3] - 2019-08-29
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
