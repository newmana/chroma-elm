module Chroma.Colors.Brewer exposing
    ( accent
    , blues
    , brBG
    , buGn
    , buPu
    , dark2
    , gnBu
    , greens
    , greys
    , orRd
    , oranges
    , pRGn
    , paired
    , pastel1
    , pastel2
    , piYG
    , puBu
    , puBuGn
    , puOr
    , puRd
    , purples
    , rdBu
    , rdGy
    , rdPu
    , rdYlBu
    , rdYlGn
    , reds
    , set1
    , set2
    , set3
    , spectral
    , ylGn
    , ylGnBu
    , ylOrBr
    , ylOrRd
    )

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty



-- Sequential


orRd : Nonempty.Nonempty Color
orRd =
    Nonempty.Nonempty (rgb255 255 247 236) [ rgb255 254 232 200, rgb255 253 212 158, rgb255 253 187 132, rgb255 252 141 89, rgb255 239 101 72, rgb255 215 48 31, rgb255 179 0 0, rgb255 127 0 0 ]


puBu : Nonempty.Nonempty Color
puBu =
    Nonempty.Nonempty (rgb255 255 247 251) [ rgb255 236 231 242, rgb255 208 209 230, rgb255 166 189 219, rgb255 116 169 207, rgb255 54 144 192, rgb255 5 112 176, rgb255 4 90 141, rgb255 2 56 88 ]


buPu : Nonempty.Nonempty Color
buPu =
    Nonempty.Nonempty (rgb255 247 252 253) [ rgb255 224 236 244, rgb255 191 211 230, rgb255 158 188 218, rgb255 140 150 198, rgb255 140 107 177, rgb255 136 65 157, rgb255 129 15 124, rgb255 77 0 75 ]


oranges : Nonempty.Nonempty Color
oranges =
    Nonempty.Nonempty (rgb255 255 245 235) [ rgb255 254 230 206, rgb255 253 208 162, rgb255 253 174 107, rgb255 253 141 60, rgb255 241 105 19, rgb255 217 72 1, rgb255 166 54 3, rgb255 127 39 4 ]


buGn : Nonempty.Nonempty Color
buGn =
    Nonempty.Nonempty (rgb255 247 252 253) [ rgb255 229 245 249, rgb255 204 236 230, rgb255 153 216 201, rgb255 102 194 164, rgb255 65 174 118, rgb255 35 139 69, rgb255 0 109 44, rgb255 0 68 27 ]


ylOrBr : Nonempty.Nonempty Color
ylOrBr =
    Nonempty.Nonempty (rgb255 255 255 229) [ rgb255 255 247 188, rgb255 254 227 145, rgb255 254 196 79, rgb255 254 153 41, rgb255 236 112 20, rgb255 204 76 2, rgb255 153 52 4, rgb255 102 37 6 ]


ylGn : Nonempty.Nonempty Color
ylGn =
    Nonempty.Nonempty (rgb255 255 255 229) [ rgb255 247 252 185, rgb255 217 240 163, rgb255 173 221 142, rgb255 120 198 121, rgb255 65 171 93, rgb255 35 132 67, rgb255 0 104 55, rgb255 0 69 41 ]


reds : Nonempty.Nonempty Color
reds =
    Nonempty.Nonempty (rgb255 255 245 240) [ rgb255 254 224 210, rgb255 252 187 161, rgb255 252 146 114, rgb255 251 106 74, rgb255 239 59 44, rgb255 203 24 29, rgb255 165 15 21, rgb255 103 0 13 ]


rdPu : Nonempty.Nonempty Color
rdPu =
    Nonempty.Nonempty (rgb255 255 247 243) [ rgb255 253 224 221, rgb255 252 197 192, rgb255 250 159 181, rgb255 247 104 161, rgb255 221 52 151, rgb255 174 1 126, rgb255 122 1 119, rgb255 73 0 106 ]


greens : Nonempty.Nonempty Color
greens =
    Nonempty.Nonempty (rgb255 247 252 245) [ rgb255 229 245 224, rgb255 199 233 192, rgb255 161 217 155, rgb255 116 196 118, rgb255 65 171 93, rgb255 35 139 69, rgb255 0 109 44, rgb255 0 68 27 ]


ylGnBu : Nonempty.Nonempty Color
ylGnBu =
    Nonempty.Nonempty (rgb255 255 255 217) [ rgb255 237 248 177, rgb255 199 233 180, rgb255 127 205 187, rgb255 65 182 196, rgb255 29 145 192, rgb255 34 94 168, rgb255 37 52 148, rgb255 8 29 88 ]


purples : Nonempty.Nonempty Color
purples =
    Nonempty.Nonempty (rgb255 252 251 253) [ rgb255 239 237 245, rgb255 218 218 235, rgb255 188 189 220, rgb255 158 154 200, rgb255 128 125 186, rgb255 106 81 163, rgb255 84 39 143, rgb255 63 0 125 ]


gnBu : Nonempty.Nonempty Color
gnBu =
    Nonempty.Nonempty (rgb255 247 252 240) [ rgb255 224 243 219, rgb255 204 235 197, rgb255 168 221 181, rgb255 123 204 196, rgb255 78 179 211, rgb255 43 140 190, rgb255 8 104 172, rgb255 8 64 129 ]


greys : Nonempty.Nonempty Color
greys =
    Nonempty.Nonempty (rgb255 255 255 255) [ rgb255 240 240 240, rgb255 217 217 217, rgb255 189 189 189, rgb255 150 150 150, rgb255 115 115 115, rgb255 82 82 82, rgb255 37 37 37, rgb255 0 0 0 ]


ylOrRd : Nonempty.Nonempty Color
ylOrRd =
    Nonempty.Nonempty (rgb255 255 255 204) [ rgb255 255 237 160, rgb255 254 217 118, rgb255 254 178 76, rgb255 253 141 60, rgb255 252 78 42, rgb255 227 26 28, rgb255 189 0 38, rgb255 128 0 38 ]


puRd : Nonempty.Nonempty Color
puRd =
    Nonempty.Nonempty (rgb255 247 244 249) [ rgb255 231 225 239, rgb255 212 185 218, rgb255 201 148 199, rgb255 223 101 176, rgb255 231 41 138, rgb255 206 18 86, rgb255 152 0 67, rgb255 103 0 31 ]


blues : Nonempty.Nonempty Color
blues =
    Nonempty.Nonempty (rgb255 247 251 255) [ rgb255 222 235 247, rgb255 198 219 239, rgb255 158 202 225, rgb255 107 174 214, rgb255 66 146 198, rgb255 33 113 181, rgb255 8 81 156, rgb255 8 48 107 ]


puBuGn : Nonempty.Nonempty Color
puBuGn =
    Nonempty.Nonempty (rgb255 255 247 251) [ rgb255 236 226 240, rgb255 208 209 230, rgb255 166 189 219, rgb255 103 169 207, rgb255 54 144 192, rgb255 2 129 138, rgb255 1 108 89, rgb255 1 70 54 ]



-- Diverging


spectral : Nonempty.Nonempty Color
spectral =
    Nonempty.Nonempty (rgb255 213 62 79) [ rgb255 244 109 67, rgb255 253 174 97, rgb255 254 224 139, rgb255 255 255 191, rgb255 230 245 152, rgb255 171 221 164, rgb255 102 194 165, rgb255 50 136 189 ]


rdYlGn : Nonempty.Nonempty Color
rdYlGn =
    Nonempty.Nonempty (rgb255 215 48 39) [ rgb255 244 109 67, rgb255 253 174 97, rgb255 254 224 139, rgb255 255 255 191, rgb255 217 239 139, rgb255 166 217 106, rgb255 102 189 99, rgb255 26 152 80 ]


rdBu : Nonempty.Nonempty Color
rdBu =
    Nonempty.Nonempty (rgb255 178 24 43) [ rgb255 214 96 77, rgb255 244 165 130, rgb255 253 219 199, rgb255 247 247 247, rgb255 209 229 240, rgb255 146 197 222, rgb255 67 147 195, rgb255 33 102 172 ]


piYG : Nonempty.Nonempty Color
piYG =
    Nonempty.Nonempty (rgb255 197 27 125) [ rgb255 222 119 174, rgb255 241 182 218, rgb255 253 224 239, rgb255 247 247 247, rgb255 230 245 208, rgb255 184 225 134, rgb255 127 188 65, rgb255 77 146 33 ]


pRGn : Nonempty.Nonempty Color
pRGn =
    Nonempty.Nonempty (rgb255 118 42 131) [ rgb255 153 112 171, rgb255 194 165 207, rgb255 231 212 232, rgb255 247 247 247, rgb255 217 240 211, rgb255 166 219 160, rgb255 90 174 97, rgb255 27 120 55 ]


rdYlBu : Nonempty.Nonempty Color
rdYlBu =
    Nonempty.Nonempty (rgb255 215 48 39) [ rgb255 244 109 67, rgb255 253 174 97, rgb255 254 224 144, rgb255 255 255 191, rgb255 224 243 248, rgb255 171 217 233, rgb255 116 173 209, rgb255 69 117 180 ]


brBG : Nonempty.Nonempty Color
brBG =
    Nonempty.Nonempty (rgb255 140 81 10) [ rgb255 191 129 45, rgb255 223 194 125, rgb255 246 232 195, rgb255 245 245 245, rgb255 199 234 229, rgb255 128 205 193, rgb255 53 151 143, rgb255 1 102 94 ]


rdGy : Nonempty.Nonempty Color
rdGy =
    Nonempty.Nonempty (rgb255 178 24 43) [ rgb255 214 96 77, rgb255 244 165 130, rgb255 253 219 199, rgb255 255 255 255, rgb255 224 224 224, rgb255 186 186 186, rgb255 135 135 135, rgb255 77 77 77 ]


puOr : Nonempty.Nonempty Color
puOr =
    Nonempty.Nonempty (rgb255 179 88 6) [ rgb255 224 130 20, rgb255 253 184 99, rgb255 254 224 182, rgb255 247 247 247, rgb255 216 218 235, rgb255 178 171 210, rgb255 128 115 172, rgb255 84 39 136 ]



-- Qualitative


set2 : Nonempty.Nonempty Color
set2 =
    Nonempty.Nonempty (rgb255 102 194 165) [ rgb255 252 141 98, rgb255 141 160 203, rgb255 231 138 195, rgb255 166 216 84, rgb255 255 217 47, rgb255 229 196 148, rgb255 179 179 179 ]


accent : Nonempty.Nonempty Color
accent =
    Nonempty.Nonempty (rgb255 127 201 127) [ rgb255 190 174 212, rgb255 253 192 134, rgb255 255 255 153, rgb255 56 108 176, rgb255 240 2 127, rgb255 191 91 23, rgb255 102 102 102 ]


set1 : Nonempty.Nonempty Color
set1 =
    Nonempty.Nonempty (rgb255 228 26 28) [ rgb255 55 126 184, rgb255 77 175 74, rgb255 152 78 163, rgb255 255 127 0, rgb255 255 255 51, rgb255 166 86 40, rgb255 247 129 191, rgb255 153 153 153 ]


set3 : Nonempty.Nonempty Color
set3 =
    Nonempty.Nonempty (rgb255 141 211 199) [ rgb255 255 255 179, rgb255 190 186 218, rgb255 251 128 114, rgb255 128 177 211, rgb255 253 180 98, rgb255 179 222 105, rgb255 252 205 229, rgb255 217 217 217, rgb255 188 128 189, rgb255 204 235 197, rgb255 255 237 111 ]


dark2 : Nonempty.Nonempty Color
dark2 =
    Nonempty.Nonempty (rgb255 27 158 119) [ rgb255 217 95 2, rgb255 117 112 179, rgb255 231 41 138, rgb255 102 166 30, rgb255 230 171 2, rgb255 166 118 29, rgb255 102 102 102 ]


paired : Nonempty.Nonempty Color
paired =
    Nonempty.Nonempty (rgb255 166 206 227) [ rgb255 31 120 180, rgb255 178 223 138, rgb255 51 160 44, rgb255 251 154 153, rgb255 227 26 28, rgb255 253 191 111, rgb255 255 127 0, rgb255 202 178 214, rgb255 106 61 154, rgb255 255 255 153, rgb255 177 89 40 ]


pastel2 : Nonempty.Nonempty Color
pastel2 =
    Nonempty.Nonempty (rgb255 179 226 205) [ rgb255 253 205 172, rgb255 203 213 232, rgb255 244 202 228, rgb255 230 245 201, rgb255 255 242 174, rgb255 241 226 204, rgb255 204 204 204 ]


pastel1 : Nonempty.Nonempty Color
pastel1 =
    Nonempty.Nonempty (rgb255 251 180 174) [ rgb255 179 205 227, rgb255 204 235 197, rgb255 222 203 228, rgb255 254 217 166, rgb255 255 255 204, rgb255 229 216 189, rgb255 253 218 236, rgb255 242 242 242 ]
