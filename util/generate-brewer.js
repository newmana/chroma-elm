chroma = require('chroma-js')
fs = require('fs');

function getColors(colorScheme) {
    const colors = chroma.brewer[colorScheme]
        .map(c => chroma(c).rgb())
        .map(rbg => `rgb255 ${rbg[0]} ${rbg[1]} ${rbg[2]}`);
    return `Nonempty.Nonempty (${colors[0]}) [ ${colors.slice(1).join(', ')} ]`
}

template = `module Chroma.Colors.Brewer exposing
    ( buGn, buPu, gnBu, orRd, puBu, puBuGn, puRd, rdPu, ylGn, ylGnBu, ylOrBr, ylOrRd
    , blues, greens, greys, oranges, purples, reds
    , brBG, piYG, pRGn, puOr, rdBu, rdGy, rdYlBu, rdYlGn, spectral
    , accent, dark2, paired, pastel1, pastel2, set1, set2, set3
    )

{-| [Colorbrewer 2.0 Colors](http://colorbrewer2.org/)


# Sequential Multi-hue Color Map

@docs buGn, buPu, gnBu, orRd, puBu, puBuGn, puRd, rdPu, ylGn, ylGnBu, ylOrBr, ylOrRd


# Sequential Single Color Map

@docs blues, greens, greys, oranges, purples, reds


# Diverging Color Ramp

@docs brBG, piYG, pRGn, puOr, rdBu, rdGy, rdYlBu, rdYlGn, spectral


# Qualitative Color Ramp

@docs accent, dark2, paired, pastel1, pastel2, set1, set2, set3

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty



-- Sequential Multi-Hue


{-| TBD
-}
buGn : Nonempty.Nonempty Color
buGn =
    ${getColors('BuGn')}


{-| TBD
-}
buPu : Nonempty.Nonempty Color
buPu =
    ${getColors('BuPu')}


{-| TBD
-}
gnBu : Nonempty.Nonempty Color
gnBu =
    ${getColors('GnBu')}


{-| TBD
-}
orRd : Nonempty.Nonempty Color
orRd =
    ${getColors('OrRd')}


{-| TBD
-}
puBu : Nonempty.Nonempty Color
puBu =
    ${getColors('PuBu')}


{-| TBD
-}
puBuGn : Nonempty.Nonempty Color
puBuGn =
    ${getColors('PuBuGn')}


{-| TBD
-}
puRd : Nonempty.Nonempty Color
puRd =
    ${getColors('PuRd')}


{-| TBD
-}
rdPu : Nonempty.Nonempty Color
rdPu =
    ${getColors('RdPu')}


{-| TBD
-}
ylGn : Nonempty.Nonempty Color
ylGn =
    ${getColors('YlGn')}


{-| TBD
-}
ylGnBu : Nonempty.Nonempty Color
ylGnBu =
    ${getColors('YlGnBu')}


{-| TBD
-}
ylOrBr : Nonempty.Nonempty Color
ylOrBr =
    ${getColors('YlOrBr')}


{-| TBD
-}
ylOrRd : Nonempty.Nonempty Color
ylOrRd =
    ${getColors('YlOrRd')}



-- Sequential - Single Hue


{-| TBD
-}
blues : Nonempty.Nonempty Color
blues =
    ${getColors('Blues')}


{-| TBD
-}
greens : Nonempty.Nonempty Color
greens =
    ${getColors('Greens')}


{-| TBD
-}
greys : Nonempty.Nonempty Color
greys =
    ${getColors('Greys')}


{-| TBD
-}
oranges : Nonempty.Nonempty Color
oranges =
    ${getColors('Oranges')}


{-| TBD
-}
purples : Nonempty.Nonempty Color
purples =
    ${getColors('Purples')}


{-| TBD
-}
reds : Nonempty.Nonempty Color
reds =
    ${getColors('Reds')}



-- Diverging
-- Change to 11 not 9 - First 3 done https://github.com/gka/chroma.js/blob/master/src/colors/colorbrewer.js


{-| TBD
-}
brBG : Nonempty.Nonempty Color
brBG =
    ${getColors('BrBG')}


{-| TBD
-}
piYG : Nonempty.Nonempty Color
piYG =
    ${getColors('PiYG')}


{-| TBD
-}
pRGn : Nonempty.Nonempty Color
pRGn =
    ${getColors('PRGn')}


{-| TBD
-}
puOr : Nonempty.Nonempty Color
puOr =
    ${getColors('PuOr')}


{-| TBD
-}
rdYlGn : Nonempty.Nonempty Color
rdYlGn =
    ${getColors('RdYlGn')}


{-| TBD
-}
rdBu : Nonempty.Nonempty Color
rdBu =
    ${getColors('RdBu')}


{-| TBD
-}
rdGy : Nonempty.Nonempty Color
rdGy =
    ${getColors('RdGy')}


{-| TBD
-}
rdYlBu : Nonempty.Nonempty Color
rdYlBu =
    ${getColors('RdYlBu')}


{-| TBD
-}
spectral : Nonempty.Nonempty Color
spectral =
    ${getColors('Spectral')}



-- Qualitative


{-| TBD
-}
accent : Nonempty.Nonempty Color
accent =
    ${getColors('Accent')}


{-| TBD
-}
dark2 : Nonempty.Nonempty Color
dark2 =
    ${getColors('Dark2')}


{-| TBD
-}
paired : Nonempty.Nonempty Color
paired =
    ${getColors('Paired')}


{-| TBD
-}
pastel1 : Nonempty.Nonempty Color
pastel1 =
    ${getColors('Pastel1')}


{-| TBD
-}
pastel2 : Nonempty.Nonempty Color
pastel2 =
    ${getColors('Pastel2')}


{-| TBD
-}
set1 : Nonempty.Nonempty Color
set1 =
    ${getColors('Set1')}


{-| TBD
-}
set2 : Nonempty.Nonempty Color
set2 =
    ${getColors('Set2')}


{-| TBD
-}
set3 : Nonempty.Nonempty Color
set3 =
    ${getColors('Set3')}
`

fs.writeFile('src/Chroma/Colors/Brewer.elm', template, function (err) {
    if (err) {
        return console.log(err);
    } else {
        console.log('src/Chroma/Colors/Brewer.elm');
    };
});

