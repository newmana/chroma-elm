module Chroma.Colors.Inferno exposing (inferno)

{-| Inferno color scale.

![Inferno](https://raw.githubusercontent.com/newmana/chroma-elm/master/images/inferno4.png)


# Color Scale

@docs inferno

-}

import Color exposing (Color, rgb)
import List.Nonempty as Nonempty


{-| TBD
-}
inferno : Nonempty.Nonempty Color
inferno =
    Nonempty.Nonempty (rgb 0.001462 0.000466 0.013866)
        [ rgb 0.002267 0.00127 0.01857
        , rgb 0.003299 0.002249 0.024239
        , rgb 0.004547 0.003392 0.030909
        , rgb 0.006006 0.004692 0.038558
        , rgb 0.007676 0.006136 0.046836
        , rgb 0.009561 0.007713 0.055143
        , rgb 0.011663 0.009417 0.06346
        , rgb 0.013995 0.011225 0.071862
        , rgb 0.016561 0.013136 0.080282
        , rgb 0.019373 0.015133 0.088767
        , rgb 0.022447 0.017199 0.097327
        , rgb 0.025793 0.019331 0.10593
        , rgb 0.029432 0.021503 0.114621
        , rgb 0.033385 0.023702 0.123397
        , rgb 0.037668 0.025921 0.132232
        , rgb 0.042253 0.028139 0.141141
        , rgb 0.046915 0.030324 0.150164
        , rgb 0.051644 0.032474 0.159254
        , rgb 0.056449 0.034569 0.168414
        , rgb 0.06134 0.03659 0.177642
        , rgb 0.066331 0.038504 0.186962
        , rgb 0.071429 0.040294 0.196354
        , rgb 0.076637 0.041905 0.205799
        , rgb 0.081962 0.043328 0.215289
        , rgb 0.087411 0.044556 0.224813
        , rgb 0.09299 0.045583 0.234358
        , rgb 0.098702 0.046402 0.243904
        , rgb 0.104551 0.047008 0.25343
        , rgb 0.110536 0.047399 0.262912
        , rgb 0.116656 0.047574 0.272321
        , rgb 0.122908 0.047536 0.281624
        , rgb 0.129285 0.047293 0.290788
        , rgb 0.135778 0.046856 0.299776
        , rgb 0.142378 0.046242 0.308553
        , rgb 0.149073 0.045468 0.317085
        , rgb 0.15585 0.044559 0.325338
        , rgb 0.162689 0.043554 0.333277
        , rgb 0.169575 0.042489 0.340874
        , rgb 0.176493 0.041402 0.348111
        , rgb 0.183429 0.040329 0.354971
        , rgb 0.190367 0.039309 0.361447
        , rgb 0.197297 0.0384 0.367535
        , rgb 0.204209 0.037632 0.373238
        , rgb 0.211095 0.03703 0.378563
        , rgb 0.217949 0.036615 0.383522
        , rgb 0.224763 0.036405 0.388129
        , rgb 0.231538 0.036405 0.3924
        , rgb 0.238273 0.036621 0.396353
        , rgb 0.244967 0.037055 0.400007
        , rgb 0.25162 0.037705 0.403378
        , rgb 0.258234 0.038571 0.406485
        , rgb 0.26481 0.039647 0.409345
        , rgb 0.271347 0.040922 0.411976
        , rgb 0.27785 0.042353 0.414392
        , rgb 0.284321 0.043933 0.416608
        , rgb 0.290763 0.045644 0.418637
        , rgb 0.297178 0.04747 0.420491
        , rgb 0.303568 0.049396 0.422182
        , rgb 0.309935 0.051407 0.423721
        , rgb 0.316282 0.05349 0.425116
        , rgb 0.32261 0.055634 0.426377
        , rgb 0.328921 0.057827 0.427511
        , rgb 0.335217 0.06006 0.428524
        , rgb 0.3415 0.062325 0.429425
        , rgb 0.347771 0.064616 0.430217
        , rgb 0.354032 0.066925 0.430906
        , rgb 0.360284 0.069247 0.431497
        , rgb 0.366529 0.071579 0.431994
        , rgb 0.372768 0.073915 0.4324
        , rgb 0.379001 0.076253 0.432719
        , rgb 0.385228 0.078591 0.432955
        , rgb 0.391453 0.080927 0.433109
        , rgb 0.397674 0.083257 0.433183
        , rgb 0.403894 0.08558 0.433179
        , rgb 0.410113 0.087896 0.433098
        , rgb 0.416331 0.090203 0.432943
        , rgb 0.422549 0.092501 0.432714
        , rgb 0.428768 0.09479 0.432412
        , rgb 0.434987 0.097069 0.432039
        , rgb 0.441207 0.099338 0.431594
        , rgb 0.447428 0.101597 0.43108
        , rgb 0.453651 0.103848 0.430498
        , rgb 0.459875 0.106089 0.429846
        , rgb 0.4661 0.108322 0.429125
        , rgb 0.472328 0.110547 0.428334
        , rgb 0.478558 0.112764 0.427475
        , rgb 0.484789 0.114974 0.426548
        , rgb 0.491022 0.117179 0.425552
        , rgb 0.497257 0.119379 0.424488
        , rgb 0.503493 0.121575 0.423356
        , rgb 0.50973 0.123769 0.422156
        , rgb 0.515967 0.12596 0.420887
        , rgb 0.522206 0.12815 0.419549
        , rgb 0.528444 0.130341 0.418142
        , rgb 0.534683 0.132534 0.416667
        , rgb 0.54092 0.134729 0.415123
        , rgb 0.547157 0.136929 0.413511
        , rgb 0.553392 0.139134 0.411829
        , rgb 0.559624 0.141346 0.410078
        , rgb 0.565854 0.143567 0.408258
        , rgb 0.572081 0.145797 0.406369
        , rgb 0.578304 0.148039 0.404411
        , rgb 0.584521 0.150294 0.402385
        , rgb 0.590734 0.152563 0.40029
        , rgb 0.59694 0.154848 0.398125
        , rgb 0.603139 0.157151 0.395891
        , rgb 0.60933 0.159474 0.393589
        , rgb 0.615513 0.161817 0.391219
        , rgb 0.621685 0.164184 0.388781
        , rgb 0.627847 0.166575 0.386276
        , rgb 0.633998 0.168992 0.383704
        , rgb 0.640135 0.171438 0.381065
        , rgb 0.64626 0.173914 0.378359
        , rgb 0.652369 0.176421 0.375586
        , rgb 0.658463 0.178962 0.372748
        , rgb 0.66454 0.181539 0.369846
        , rgb 0.670599 0.184153 0.366879
        , rgb 0.676638 0.186807 0.363849
        , rgb 0.682656 0.189501 0.360757
        , rgb 0.688653 0.192239 0.357603
        , rgb 0.694627 0.195021 0.354388
        , rgb 0.700576 0.197851 0.351113
        , rgb 0.7065 0.200728 0.347777
        , rgb 0.712396 0.203656 0.344383
        , rgb 0.718264 0.206636 0.340931
        , rgb 0.724103 0.20967 0.337424
        , rgb 0.729909 0.212759 0.333861
        , rgb 0.735683 0.215906 0.330245
        , rgb 0.741423 0.219112 0.326576
        , rgb 0.747127 0.222378 0.322856
        , rgb 0.752794 0.225706 0.319085
        , rgb 0.758422 0.229097 0.315266
        , rgb 0.76401 0.232554 0.311399
        , rgb 0.769556 0.236077 0.307485
        , rgb 0.775059 0.239667 0.303526
        , rgb 0.780517 0.243327 0.299523
        , rgb 0.785929 0.247056 0.295477
        , rgb 0.791293 0.250856 0.29139
        , rgb 0.796607 0.254728 0.287264
        , rgb 0.801871 0.258674 0.283099
        , rgb 0.807082 0.262692 0.278898
        , rgb 0.812239 0.266786 0.274661
        , rgb 0.817341 0.270954 0.27039
        , rgb 0.822386 0.275197 0.266085
        , rgb 0.827372 0.279517 0.26175
        , rgb 0.832299 0.283913 0.257383
        , rgb 0.837165 0.288385 0.252988
        , rgb 0.841969 0.292933 0.248564
        , rgb 0.846709 0.297559 0.244113
        , rgb 0.851384 0.30226 0.239636
        , rgb 0.855992 0.307038 0.235133
        , rgb 0.860533 0.311892 0.230606
        , rgb 0.865006 0.316822 0.226055
        , rgb 0.869409 0.321827 0.221482
        , rgb 0.873741 0.326906 0.216886
        , rgb 0.878001 0.33206 0.212268
        , rgb 0.882188 0.337287 0.207628
        , rgb 0.886302 0.342586 0.202968
        , rgb 0.890341 0.347957 0.198286
        , rgb 0.894305 0.353399 0.193584
        , rgb 0.898192 0.358911 0.18886
        , rgb 0.902003 0.364492 0.184116
        , rgb 0.905735 0.37014 0.17935
        , rgb 0.90939 0.375856 0.174563
        , rgb 0.912966 0.381636 0.169755
        , rgb 0.916462 0.387481 0.164924
        , rgb 0.919879 0.393389 0.16007
        , rgb 0.923215 0.399359 0.155193
        , rgb 0.92647 0.405389 0.150292
        , rgb 0.929644 0.411479 0.145367
        , rgb 0.932737 0.417627 0.140417
        , rgb 0.935747 0.423831 0.13544
        , rgb 0.938675 0.430091 0.130438
        , rgb 0.941521 0.436405 0.125409
        , rgb 0.944285 0.442772 0.120354
        , rgb 0.946965 0.449191 0.115272
        , rgb 0.949562 0.45566 0.110164
        , rgb 0.952075 0.462178 0.105031
        , rgb 0.954506 0.468744 0.099874
        , rgb 0.956852 0.475356 0.094695
        , rgb 0.959114 0.482014 0.089499
        , rgb 0.961293 0.488716 0.084289
        , rgb 0.963387 0.495462 0.079073
        , rgb 0.965397 0.502249 0.073859
        , rgb 0.967322 0.509078 0.068659
        , rgb 0.969163 0.515946 0.063488
        , rgb 0.970919 0.522853 0.058367
        , rgb 0.97259 0.529798 0.053324
        , rgb 0.974176 0.53678 0.048392
        , rgb 0.975677 0.543798 0.043618
        , rgb 0.977092 0.55085 0.03905
        , rgb 0.978422 0.557937 0.034931
        , rgb 0.979666 0.565057 0.031409
        , rgb 0.980824 0.572209 0.028508
        , rgb 0.981895 0.579392 0.02625
        , rgb 0.982881 0.586606 0.024661
        , rgb 0.983779 0.593849 0.02377
        , rgb 0.984591 0.601122 0.023606
        , rgb 0.985315 0.608422 0.024202
        , rgb 0.985952 0.61575 0.025592
        , rgb 0.986502 0.623105 0.027814
        , rgb 0.986964 0.630485 0.030908
        , rgb 0.987337 0.63789 0.034916
        , rgb 0.987622 0.64532 0.039886
        , rgb 0.987819 0.652773 0.045581
        , rgb 0.987926 0.66025 0.05175
        , rgb 0.987945 0.667748 0.058329
        , rgb 0.987874 0.675267 0.065257
        , rgb 0.987714 0.682807 0.072489
        , rgb 0.987464 0.690366 0.07999
        , rgb 0.987124 0.697944 0.087731
        , rgb 0.986694 0.70554 0.095694
        , rgb 0.986175 0.713153 0.103863
        , rgb 0.985566 0.720782 0.112229
        , rgb 0.984865 0.728427 0.120785
        , rgb 0.984075 0.736087 0.129527
        , rgb 0.983196 0.743758 0.138453
        , rgb 0.982228 0.751442 0.147565
        , rgb 0.981173 0.759135 0.156863
        , rgb 0.980032 0.766837 0.166353
        , rgb 0.978806 0.774545 0.176037
        , rgb 0.977497 0.782258 0.185923
        , rgb 0.976108 0.789974 0.196018
        , rgb 0.974638 0.797692 0.206332
        , rgb 0.973088 0.805409 0.216877
        , rgb 0.971468 0.813122 0.227658
        , rgb 0.969783 0.820825 0.238686
        , rgb 0.968041 0.828515 0.249972
        , rgb 0.966243 0.836191 0.261534
        , rgb 0.964394 0.843848 0.273391
        , rgb 0.962517 0.851476 0.285546
        , rgb 0.960626 0.859069 0.29801
        , rgb 0.95872 0.866624 0.31082
        , rgb 0.956834 0.874129 0.323974
        , rgb 0.954997 0.881569 0.337475
        , rgb 0.953215 0.888942 0.351369
        , rgb 0.951546 0.896226 0.365627
        , rgb 0.950018 0.903409 0.380271
        , rgb 0.948683 0.910473 0.395289
        , rgb 0.947594 0.917399 0.410665
        , rgb 0.946809 0.924168 0.426373
        , rgb 0.946392 0.930761 0.442367
        , rgb 0.946403 0.937159 0.458592
        , rgb 0.946903 0.943348 0.47497
        , rgb 0.947937 0.949318 0.491426
        , rgb 0.949545 0.955063 0.50786
        , rgb 0.95174 0.960587 0.524203
        , rgb 0.954529 0.965896 0.540361
        , rgb 0.957896 0.971003 0.556275
        , rgb 0.961812 0.975924 0.571925
        , rgb 0.966249 0.980678 0.587206
        , rgb 0.971162 0.985282 0.602154
        , rgb 0.976511 0.989753 0.61676
        , rgb 0.982257 0.994109 0.631017
        , rgb 0.988362 0.998364 0.644924
        ]
