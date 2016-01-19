> pi
[1] 3.141593
> v <- c(40,2,83,28,58)
> f <- factor(c("A","C","C","B","C"))
> v
[1] 40  2 83 28 58
> f
[1] A C C B C
Levels: A B C
> split(v, f)
$A
[1] 40

$B
[1] 28

$C
[1]  2 83 58

> unstack(data.frame(x,v))
Error in data.frame(x, v) : 
  arguments imply differing number of rows: 208, 5
> unstack(data.frame(v,f))
$A
[1] 40

$B
[1] 28

$C
[1]  2 83 58

> ?unstack
> library(MASS)
> split(Cars93$MPG.city, Cars93$Manufacturer)
$Acura
[1] 25 18

$Audi
[1] 20 19

$BMW
[1] 22

$Buick
[1] 22 19 16 19

$Cadillac
[1] 16 16

$Chevrolet
[1] 25 25 19 21 18 15 17 17

$Chrylser
[1] 20

$Chrysler
[1] 23 20

$Dodge
[1] 29 23 22 17 21 18

$Eagle
[1] 29 20

$Ford
[1] 31 23 22 22 24 15 21 18

$Geo
[1] 46 30

$Honda
[1] 24 42 24

$Hyundai
[1] 29 22 26 20

$Infiniti
[1] 17

$Lexus
[1] 18 18

$Lincoln
[1] 17 18

$Mazda
[1] 29 28 26 18 17

$`Mercedes-Benz`
[1] 20 19

$Mercury
[1] 23 19

$Mitsubishi
[1] 29 18

$Nissan
[1] 29 24 17 21

$Oldsmobile
[1] 24 23 18 19

$Plymouth
[1] 23

$Pontiac
[1] 31 23 19 19 19

$Saab
[1] 20

$Saturn
[1] 28

$Subaru
[1] 33 25 23

$Suzuki
[1] 39

$Toyota
[1] 32 25 22 18

$Volkswagen
[1] 25 17 21 18

$Volvo
[1] 21 20

> split(Cars93$MPG.city, Cars93$Origin)
$USA
 [1] 22 19 16 19 16 16 25 25 19 21 18 15 17 17 20 23 20 29 23 22 17 21 18 29 20 31 23 22 22
[30] 24 15 21 18 17 18 23 19 24 23 18 19 23 31 23 19 19 19 28

$`non-USA`
 [1] 25 18 20 19 22 46 30 24 42 24 29 22 26 20 17 18 18 29 28 26 18 17 20 19 29 18 29 24 17
[30] 21 20 33 25 23 39 32 25 22 18 25 17 21 18 21 20

> Cars93$MPG.city
 [1] 25 18 20 19 22 22 19 16 19 16 16 25 25 19 21 18 15 17 17 20 23 20 29 23 22 17 21 18 29
[30] 20 31 23 22 22 24 15 21 18 46 30 24 42 24 29 22 26 20 17 18 18 17 18 29 28 26 18 17 20
[59] 19 23 19 29 18 29 24 17 21 24 23 18 19 23 31 23 19 19 19 20 28 33 25 23 39 32 25 22 18
[88] 25 17 21 18 21 20
> str(Cars93)
'data.frame':	93 obs. of  27 variables:
 $ Manufacturer      : Factor w/ 32 levels "Acura","Audi",..: 1 1 2 2 3 4 4 4 4 5 ...
 $ Model             : Factor w/ 93 levels "100","190E","240",..: 49 56 9 1 6 24 54 74 73 35 ...
 $ Type              : Factor w/ 6 levels "Compact","Large",..: 4 3 1 3 3 3 2 2 3 2 ...
 $ Min.Price         : num  12.9 29.2 25.9 30.8 23.7 14.2 19.9 22.6 26.3 33 ...
 $ Price             : num  15.9 33.9 29.1 37.7 30 15.7 20.8 23.7 26.3 34.7 ...
 $ Max.Price         : num  18.8 38.7 32.3 44.6 36.2 17.3 21.7 24.9 26.3 36.3 ...
 $ MPG.city          : int  25 18 20 19 22 22 19 16 19 16 ...
 $ MPG.highway       : int  31 25 26 26 30 31 28 25 27 25 ...
 $ AirBags           : Factor w/ 3 levels "Driver & Passenger",..: 3 1 2 1 2 2 2 2 2 2 ...
 $ DriveTrain        : Factor w/ 3 levels "4WD","Front",..: 2 2 2 2 3 2 2 3 2 2 ...
 $ Cylinders         : Factor w/ 6 levels "3","4","5","6",..: 2 4 4 4 2 2 4 4 4 5 ...
 $ EngineSize        : num  1.8 3.2 2.8 2.8 3.5 2.2 3.8 5.7 3.8 4.9 ...
 $ Horsepower        : int  140 200 172 172 208 110 170 180 170 200 ...
 $ RPM               : int  6300 5500 5500 5500 5700 5200 4800 4000 4800 4100 ...
 $ Rev.per.mile      : int  2890 2335 2280 2535 2545 2565 1570 1320 1690 1510 ...
 $ Man.trans.avail   : Factor w/ 2 levels "No","Yes": 2 2 2 2 2 1 1 1 1 1 ...
 $ Fuel.tank.capacity: num  13.2 18 16.9 21.1 21.1 16.4 18 23 18.8 18 ...
 $ Passengers        : int  5 5 5 6 4 6 6 6 5 6 ...
 $ Length            : int  177 195 180 193 186 189 200 216 198 206 ...
 $ Wheelbase         : int  102 115 102 106 109 105 111 116 108 114 ...
 $ Width             : int  68 71 67 70 69 69 74 78 73 73 ...
 $ Turn.circle       : int  37 38 37 37 39 41 42 45 41 43 ...
 $ Rear.seat.room    : num  26.5 30 28 31 27 28 30.5 30.5 26.5 35 ...
 $ Luggage.room      : int  11 15 14 17 13 16 17 21 14 18 ...
 $ Weight            : int  2705 3560 3375 3405 3640 2880 3470 4105 3495 3620 ...
 $ Origin            : Factor w/ 2 levels "USA","non-USA": 2 2 2 2 2 1 1 1 1 1 ...
 $ Make              : Factor w/ 93 levels "Acura Integra",..: 1 2 4 3 5 6 7 9 8 10 ...
> split(Cars93, Cars93$AirBags)
$`Driver & Passenger`
    Manufacturer       Model    Type Min.Price Price Max.Price MPG.city MPG.highway
2          Acura      Legend Midsize      29.2  33.9      38.7       18          25
4           Audi         100 Midsize      30.8  37.7      44.6       19          26
11      Cadillac     Seville Midsize      37.5  40.1      42.7       16          25
14     Chevrolet      Camaro  Sporty      13.4  15.1      16.8       19          28
20      Chrylser    Concorde   Large      18.4  18.4      18.4       20          28
21      Chrysler     LeBaron Compact      14.5  15.8      17.1       23          28
30         Eagle      Vision   Large      17.5  19.3      21.2       20          28
41         Honda     Prelude  Sporty      17.0  19.8      22.7       24          31
43         Honda      Accord Compact      13.8  17.5      21.2       24          31
50         Lexus       SC300 Midsize      34.7  35.2      35.6       18          23
51       Lincoln Continental Midsize      33.3  34.3      35.3       17          26
52       Lincoln    Town_Car   Large      34.4  36.1      37.8       18          26
59 Mercedes-Benz        300E Midsize      43.8  61.9      80.0       19          25
75       Pontiac    Firebird  Sporty      14.0  17.7      21.4       19          28
77       Pontiac  Bonneville   Large      19.4  24.4      29.4       19          28
93         Volvo         850 Midsize      24.8  26.7      28.5       20          28
              AirBags DriveTrain Cylinders EngineSize Horsepower  RPM Rev.per.mile
2  Driver & Passenger      Front         6        3.2        200 5500         2335
4  Driver & Passenger      Front         6        2.8        172 5500         2535
11 Driver & Passenger      Front         8        4.6        295 6000         1985
14 Driver & Passenger       Rear         6        3.4        160 4600         1805
20 Driver & Passenger      Front         6        3.3        153 5300         1990
21 Driver & Passenger      Front         4        3.0        141 5000         2090
30 Driver & Passenger      Front         6        3.5        214 5800         1980
41 Driver & Passenger      Front         4        2.3        160 5800         2855
43 Driver & Passenger      Front         4        2.2        140 5600         2610
50 Driver & Passenger       Rear         6        3.0        225 6000         2510
51 Driver & Passenger      Front         6        3.8        160 4400         1835
52 Driver & Passenger       Rear         8        4.6        210 4600         1840
59 Driver & Passenger       Rear         6        3.2        217 5500         2220
75 Driver & Passenger       Rear         6        3.4        160 4600         1805
77 Driver & Passenger      Front         6        3.8        170 4800         1565
93 Driver & Passenger      Front         5        2.4        168 6200         2310
   Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase Width Turn.circle
2              Yes               18.0          5    195       115    71          38
4              Yes               21.1          6    193       106    70          37
11              No               20.0          5    204       111    74          44
14             Yes               15.5          4    193       101    74          43
20              No               18.0          6    203       113    74          40
21              No               16.0          6    183       104    68          41
30              No               18.0          6    202       113    74          40
41             Yes               15.9          4    175       100    70          39
43             Yes               17.0          4    185       107    67          41
50             Yes               20.6          4    191       106    71          39
51              No               18.4          6    205       109    73          42
52              No               20.0          6    219       117    77          45
59              No               18.5          5    187       110    69          37
75             Yes               15.5          4    196       101    75          43
77              No               18.0          6    177       111    74          43
93             Yes               19.3          5    184       105    69          38
   Rear.seat.room Luggage.room Weight  Origin                Make
2            30.0           15   3560 non-USA        Acura Legend
4            31.0           17   3405 non-USA            Audi 100
11           31.0           14   3935     USA    Cadillac Seville
14           25.0           13   3240     USA    Chevrolet Camaro
20           31.0           15   3515     USA   Chrylser Concorde
21           30.5           14   3085     USA    Chrysler LeBaron
30           30.0           15   3490     USA        Eagle Vision
41           23.5            8   2865 non-USA       Honda Prelude
43           28.0           14   3040 non-USA        Honda Accord
50           25.0            9   3515 non-USA         Lexus SC300
51           30.0           19   3695     USA Lincoln Continental
52           31.5           22   4055     USA    Lincoln Town_Car
59           27.0           15   3525 non-USA  Mercedes-Benz 300E
75           25.0           13   3240     USA    Pontiac Firebird
77           30.5           18   3495     USA  Pontiac Bonneville
93           30.0           15   3245 non-USA           Volvo 850

$`Driver only`
    Manufacturer          Model    Type Min.Price Price Max.Price MPG.city MPG.highway
3           Audi             90 Compact      25.9  29.1      32.3       20          26
5            BMW           535i Midsize      23.7  30.0      36.2       22          30
6          Buick        Century Midsize      14.2  15.7      17.3       22          31
7          Buick        LeSabre   Large      19.9  20.8      21.7       19          28
8          Buick     Roadmaster   Large      22.6  23.7      24.9       16          25
9          Buick        Riviera Midsize      26.3  26.3      26.3       19          27
10      Cadillac        DeVille   Large      33.0  34.7      36.3       16          25
13     Chevrolet        Corsica Compact      11.4  11.4      11.4       25          34
18     Chevrolet        Caprice   Large      18.0  18.8      19.6       17          26
19     Chevrolet       Corvette  Sporty      34.6  38.0      41.5       17          25
22      Chrysler       Imperial   Large      29.5  29.5      29.5       20          26
24         Dodge         Shadow   Small       8.4  11.3      14.2       23          29
25         Dodge         Spirit Compact      11.9  13.3      14.7       22          27
26         Dodge        Caravan     Van      13.6  19.0      24.4       17          21
27         Dodge        Dynasty Midsize      14.8  15.6      16.4       21          27
28         Dodge        Stealth  Sporty      18.5  25.8      33.1       18          24
34          Ford        Mustang  Sporty      10.8  15.9      21.0       22          29
35          Ford          Probe  Sporty      12.8  14.0      15.2       24          30
36          Ford       Aerostar     Van      14.5  19.9      25.3       15          20
37          Ford         Taurus Midsize      15.6  20.2      24.8       21          30
38          Ford Crown_Victoria   Large      20.1  20.9      21.7       18          26
40           Geo          Storm  Sporty      11.5  12.5      13.5       30          36
42         Honda          Civic   Small       8.4  12.1      15.8       42          46
48      Infiniti            Q45 Midsize      45.4  47.9      50.4       17          22
49         Lexus          ES300 Midsize      27.5  28.0      28.4       18          24
55         Mazda            626 Compact      14.3  16.5      18.7       26          34
57         Mazda           RX-7  Sporty      32.5  32.5      32.5       17          25
58 Mercedes-Benz           190E Compact      29.0  31.9      34.9       20          29
60       Mercury          Capri  Sporty      13.3  14.1      15.0       23          26
63    Mitsubishi       Diamante Midsize      22.4  26.1      29.9       18          24
64        Nissan         Sentra   Small       8.7  11.8      14.9       29          33
65        Nissan         Altima Compact      13.0  15.7      18.3       24          30
67        Nissan         Maxima Midsize      21.0  21.5      22.0       21          26
69    Oldsmobile  Cutlass_Ciera Midsize      14.2  16.3      18.4       23          31
71    Oldsmobile   Eighty-Eight   Large      19.5  20.7      21.9       19          28
78          Saab            900 Compact      20.3  28.7      37.1       20          26
79        Saturn             SL   Small       9.2  11.1      12.9       28          38
82        Subaru         Legacy Compact      16.3  19.5      22.7       23          30
84        Toyota         Tercel   Small       7.8   9.8      11.8       32          37
85        Toyota         Celica  Sporty      14.2  18.4      22.6       25          32
86        Toyota          Camry Midsize      15.2  18.2      21.2       22          29
87        Toyota         Previa     Van      18.9  22.7      26.6       18          22
92         Volvo            240 Compact      21.8  22.7      23.5       21          28
       AirBags DriveTrain Cylinders EngineSize Horsepower  RPM Rev.per.mile Man.trans.avail
3  Driver only      Front         6        2.8        172 5500         2280             Yes
5  Driver only       Rear         4        3.5        208 5700         2545             Yes
6  Driver only      Front         4        2.2        110 5200         2565              No
7  Driver only      Front         6        3.8        170 4800         1570              No
8  Driver only       Rear         6        5.7        180 4000         1320              No
9  Driver only      Front         6        3.8        170 4800         1690              No
10 Driver only      Front         8        4.9        200 4100         1510              No
13 Driver only      Front         4        2.2        110 5200         2665             Yes
18 Driver only       Rear         8        5.0        170 4200         1350              No
19 Driver only       Rear         8        5.7        300 5000         1450             Yes
22 Driver only      Front         6        3.3        147 4800         1785              No
24 Driver only      Front         4        2.2         93 4800         2595             Yes
25 Driver only      Front         4        2.5        100 4800         2535             Yes
26 Driver only        4WD         6        3.0        142 5000         1970              No
27 Driver only      Front         4        2.5        100 4800         2465              No
28 Driver only        4WD         6        3.0        300 6000         2120             Yes
34 Driver only       Rear         4        2.3        105 4600         2285             Yes
35 Driver only      Front         4        2.0        115 5500         2340             Yes
36 Driver only        4WD         6        3.0        145 4800         2080             Yes
37 Driver only      Front         6        3.0        140 4800         1885              No
38 Driver only       Rear         8        4.6        190 4200         1415              No
40 Driver only      Front         4        1.6         90 5400         3250             Yes
42 Driver only      Front         4        1.5        102 5900         2650             Yes
48 Driver only       Rear         8        4.5        278 6000         1955              No
49 Driver only      Front         6        3.0        185 5200         2325             Yes
55 Driver only      Front         4        2.5        164 5600         2505             Yes
57 Driver only       Rear    rotary        1.3        255 6500         2325             Yes
58 Driver only       Rear         4        2.3        130 5100         2425             Yes
60 Driver only      Front         4        1.6        100 5750         2475             Yes
63 Driver only      Front         6        3.0        202 6000         2210              No
64 Driver only      Front         4        1.6        110 6000         2435             Yes
65 Driver only      Front         4        2.4        150 5600         2130             Yes
67 Driver only      Front         6        3.0        160 5200         2045              No
69 Driver only      Front         4        2.2        110 5200         2565              No
71 Driver only      Front         6        3.8        170 4800         1570              No
78 Driver only      Front         4        2.1        140 6000         2910             Yes
79 Driver only      Front         4        1.9         85 5000         2145             Yes
82 Driver only        4WD         4        2.2        130 5600         2330             Yes
84 Driver only      Front         4        1.5         82 5200         3505             Yes
85 Driver only      Front         4        2.2        135 5400         2405             Yes
86 Driver only      Front         4        2.2        130 5400         2340             Yes
87 Driver only        4WD         4        2.4        138 5000         2515             Yes
92 Driver only       Rear         4        2.3        114 5400         2215             Yes
   Fuel.tank.capacity Passengers Length Wheelbase Width Turn.circle Rear.seat.room
3                16.9          5    180       102    67          37           28.0
5                21.1          4    186       109    69          39           27.0
6                16.4          6    189       105    69          41           28.0
7                18.0          6    200       111    74          42           30.5
8                23.0          6    216       116    78          45           30.5
9                18.8          5    198       108    73          41           26.5
10               18.0          6    206       114    73          43           35.0
13               15.6          5    184       103    68          39           26.0
18               23.0          6    214       116    77          42           29.5
19               20.0          2    179        96    74          43             NA
22               16.0          6    203       110    69          44           36.0
24               14.0          5    172        97    67          38           26.5
25               16.0          6    181       104    68          39           30.5
26               20.0          7    175       112    72          42           26.5
27               16.0          6    192       105    69          42           30.5
28               19.8          4    180        97    72          40           20.0
34               15.4          4    180       101    68          40           24.0
35               15.5          4    179       103    70          38           23.0
36               21.0          7    176       119    72          45           30.0
37               16.0          5    192       106    71          40           27.5
38               20.0          6    212       114    78          43           30.0
40               12.4          4    164        97    67          37           24.5
42               11.9          4    173       103    67          36           28.0
48               22.5          5    200       113    72          42           29.0
49               18.5          5    188       103    70          40           27.5
55               15.5          5    184       103    69          40           29.5
57               20.0          2    169        96    69          37             NA
58               14.5          5    175       105    67          34           26.0
60               11.1          4    166        95    65          36           19.0
63               19.0          5    190       107    70          43           27.5
64               13.2          5    170        96    66          33           26.0
65               15.9          5    181       103    67          40           28.5
67               18.5          5    188       104    69          41           28.5
69               16.5          5    190       105    70          42           28.0
71               18.0          6    201       111    74          42           31.5
78               18.0          5    184        99    67          37           26.5
79               12.8          5    176       102    68          40           26.5
82               15.9          5    179       102    67          37           27.0
84               11.9          5    162        94    65          36           24.0
85               15.9          4    174        99    69          39           23.0
86               18.5          5    188       103    70          38           28.5
87               19.8          7    187       113    71          41           35.0
92               15.8          5    190       104    67          37           29.5
   Luggage.room Weight  Origin                     Make
3            14   3375 non-USA                  Audi 90
5            13   3640 non-USA                 BMW 535i
6            16   2880     USA            Buick Century
7            17   3470     USA            Buick LeSabre
8            21   4105     USA         Buick Roadmaster
9            14   3495     USA            Buick Riviera
10           18   3620     USA         Cadillac DeVille
13           14   2785     USA        Chevrolet Corsica
18           20   3910     USA        Chevrolet Caprice
19           NA   3380     USA       Chevrolet Corvette
22           17   3570     USA        Chrysler Imperial
24           13   2670     USA             Dodge Shadow
25           14   2970     USA             Dodge Spirit
26           NA   3705     USA            Dodge Caravan
27           16   3080     USA            Dodge Dynasty
28           11   3805     USA            Dodge Stealth
34           12   2850     USA             Ford Mustang
35           18   2710     USA               Ford Probe
36           NA   3735     USA            Ford Aerostar
37           18   3325     USA              Ford Taurus
38           21   3950     USA      Ford Crown_Victoria
40           11   2475 non-USA                Geo Storm
42           12   2350 non-USA              Honda Civic
48           15   4000 non-USA             Infiniti Q45
49           14   3510 non-USA              Lexus ES300
55           14   2970 non-USA                Mazda 626
57           NA   2895 non-USA               Mazda RX-7
58           12   2920 non-USA       Mercedes-Benz 190E
60            6   2450     USA            Mercury Capri
63           14   3730 non-USA      Mitsubishi Diamante
64           12   2545 non-USA            Nissan Sentra
65           14   3050 non-USA            Nissan Altima
67           14   3200 non-USA            Nissan Maxima
69           16   2890     USA Oldsmobile Cutlass_Ciera
71           17   3470     USA  Oldsmobile Eighty-Eight
78           14   2775 non-USA                 Saab 900
79           12   2495     USA                Saturn SL
82           14   3085 non-USA            Subaru Legacy
84           11   2055 non-USA            Toyota Tercel
85           13   2950 non-USA            Toyota Celica
86           15   3030 non-USA             Toyota Camry
87           NA   3785 non-USA            Toyota Previa
92           14   2985 non-USA                Volvo 240

$None
   Manufacturer      Model    Type Min.Price Price Max.Price MPG.city MPG.highway AirBags
1         Acura    Integra   Small      12.9  15.9      18.8       25          31    None
12    Chevrolet   Cavalier Compact       8.5  13.4      18.3       25          36    None
15    Chevrolet     Lumina Midsize      13.4  15.9      18.4       21          29    None
16    Chevrolet Lumina_APV     Van      14.7  16.3      18.0       18          23    None
17    Chevrolet      Astro     Van      14.7  16.6      18.6       15          20    None
23        Dodge       Colt   Small       7.9   9.2      10.6       29          33    None
29        Eagle     Summit   Small       7.9  12.2      16.5       29          33    None
31         Ford    Festiva   Small       6.9   7.4       7.9       31          33    None
32         Ford     Escort   Small       8.4  10.1      11.9       23          30    None
33         Ford      Tempo Compact      10.4  11.3      12.2       22          27    None
39          Geo      Metro   Small       6.7   8.4      10.0       46          50    None
44      Hyundai      Excel   Small       6.8   8.0       9.2       29          33    None
45      Hyundai    Elantra   Small       9.0  10.0      11.0       22          29    None
46      Hyundai     Scoupe  Sporty       9.1  10.0      11.0       26          34    None
47      Hyundai     Sonata Midsize      12.4  13.9      15.3       20          27    None
53        Mazda        323   Small       7.4   8.3       9.1       29          37    None
54        Mazda    Protege   Small      10.9  11.6      12.3       28          36    None
56        Mazda        MPV     Van      16.6  19.1      21.7       18          24    None
61      Mercury     Cougar Midsize      14.9  14.9      14.9       19          26    None
62   Mitsubishi     Mirage   Small       7.7  10.3      12.9       29          33    None
66       Nissan      Quest     Van      16.7  19.1      21.5       17          23    None
68   Oldsmobile    Achieva Compact      13.0  13.5      14.0       24          31    None
70   Oldsmobile Silhouette     Van      19.5  19.5      19.5       18          23    None
72     Plymouth      Laser  Sporty      11.4  14.4      17.4       23          30    None
73      Pontiac     LeMans   Small       8.2   9.0       9.9       31          41    None
74      Pontiac    Sunbird Compact       9.4  11.1      12.8       23          31    None
76      Pontiac Grand_Prix Midsize      15.4  18.5      21.6       19          27    None
80       Subaru      Justy   Small       7.3   8.4       9.5       33          37    None
81       Subaru     Loyale   Small      10.5  10.9      11.3       25          30    None
83       Suzuki      Swift   Small       7.3   8.6      10.0       39          43    None
88   Volkswagen        Fox   Small       8.7   9.1       9.5       25          33    None
89   Volkswagen    Eurovan     Van      16.6  19.7      22.7       17          21    None
90   Volkswagen     Passat Compact      17.6  20.0      22.4       21          30    None
91   Volkswagen    Corrado  Sporty      22.9  23.3      23.7       18          25    None
   DriveTrain Cylinders EngineSize Horsepower  RPM Rev.per.mile Man.trans.avail
1       Front         4        1.8        140 6300         2890             Yes
12      Front         4        2.2        110 5200         2380             Yes
15      Front         4        2.2        110 5200         2595              No
16      Front         6        3.8        170 4800         1690              No
17        4WD         6        4.3        165 4000         1790              No
23      Front         4        1.5         92 6000         3285             Yes
29      Front         4        1.5         92 6000         2505             Yes
31      Front         4        1.3         63 5000         3150             Yes
32      Front         4        1.8        127 6500         2410             Yes
33      Front         4        2.3         96 4200         2805             Yes
39      Front         3        1.0         55 5700         3755             Yes
44      Front         4        1.5         81 5500         2710             Yes
45      Front         4        1.8        124 6000         2745             Yes
46      Front         4        1.5         92 5550         2540             Yes
47      Front         4        2.0        128 6000         2335             Yes
53      Front         4        1.6         82 5000         2370             Yes
54      Front         4        1.8        103 5500         2220             Yes
56        4WD         6        3.0        155 5000         2240              No
61       Rear         6        3.8        140 3800         1730              No
62      Front         4        1.5         92 6000         2505             Yes
66      Front         6        3.0        151 4800         2065              No
68      Front         4        2.3        155 6000         2380              No
70      Front         6        3.8        170 4800         1690              No
72        4WD         4        1.8         92 5000         2360             Yes
73      Front         4        1.6         74 5600         3130             Yes
74      Front         4        2.0        110 5200         2665             Yes
76      Front         6        3.4        200 5000         1890             Yes
80        4WD         3        1.2         73 5600         2875             Yes
81        4WD         4        1.8         90 5200         3375             Yes
83      Front         3        1.3         70 6000         3360             Yes
88      Front         4        1.8         81 5500         2550             Yes
89      Front         5        2.5        109 4500         2915             Yes
90      Front         4        2.0        134 5800         2685             Yes
91      Front         6        2.8        178 5800         2385             Yes
   Fuel.tank.capacity Passengers Length Wheelbase Width Turn.circle Rear.seat.room
1                13.2          5    177       102    68          37           26.5
12               15.2          5    182       101    66          38           25.0
15               16.5          6    198       108    71          40           28.5
16               20.0          7    178       110    74          44           30.5
17               27.0          8    194       111    78          42           33.5
23               13.2          5    174        98    66          32           26.5
29               13.2          5    174        98    66          36           26.5
31               10.0          4    141        90    63          33           26.0
32               13.2          5    171        98    67          36           28.0
33               15.9          5    177       100    68          39           27.5
39               10.6          4    151        93    63          34           27.5
44               11.9          5    168        94    63          35           26.0
45               13.7          5    172        98    66          36           28.0
46               11.9          4    166        94    64          34           23.5
47               17.2          5    184       104    69          41           31.0
53               13.2          4    164        97    66          34           27.0
54               14.5          5    172        98    66          36           26.5
56               19.6          7    190       110    72          39           27.5
61               18.0          5    199       113    73          38           28.0
62               13.2          5    172        98    67          36           26.0
66               20.0          7    190       112    74          41           27.0
68               15.2          5    188       103    67          39           28.0
70               20.0          7    194       110    74          44           30.5
72               15.9          4    173        97    67          39           24.5
73               13.2          4    177        99    66          35           25.5
74               15.2          5    181       101    66          39           25.0
76               16.5          5    195       108    72          41           28.5
80                9.2          4    146        90    60          32           23.5
81               15.9          5    175        97    65          35           27.5
83               10.6          4    161        93    63          34           27.5
88               12.4          4    163        93    63          34           26.0
89               21.1          7    187       115    72          38           34.0
90               18.5          5    180       103    67          35           31.5
91               18.5          4    159        97    66          36           26.0
   Luggage.room Weight  Origin                  Make
1            11   2705 non-USA         Acura Integra
12           13   2490     USA    Chevrolet Cavalier
15           16   3195     USA      Chevrolet Lumina
16           NA   3715     USA  Chevrolet Lumina_APV
17           NA   4025     USA       Chevrolet Astro
23           11   2270     USA            Dodge Colt
29           11   2295     USA          Eagle Summit
31           12   1845     USA          Ford Festiva
32           12   2530     USA           Ford Escort
33           13   2690     USA            Ford Tempo
39           10   1695 non-USA             Geo Metro
44           11   2345 non-USA         Hyundai Excel
45           12   2620 non-USA       Hyundai Elantra
46            9   2285 non-USA        Hyundai Scoupe
47           14   2885 non-USA        Hyundai Sonata
53           16   2325 non-USA             Mazda 323
54           13   2440 non-USA         Mazda Protege
56           NA   3735 non-USA             Mazda MPV
61           15   3610     USA        Mercury Cougar
62           11   2295 non-USA     Mitsubishi Mirage
66           NA   4100 non-USA          Nissan Quest
68           14   2910     USA    Oldsmobile Achieva
70           NA   3715     USA Oldsmobile Silhouette
72            8   2640     USA        Plymouth Laser
73           17   2350     USA        Pontiac LeMans
74           13   2575     USA       Pontiac Sunbird
76           16   3450     USA    Pontiac Grand_Prix
80           10   2045 non-USA          Subaru Justy
81           15   2490 non-USA         Subaru Loyale
83           10   1965 non-USA          Suzuki Swift
88           10   2240 non-USA        Volkswagen Fox
89           NA   3960 non-USA    Volkswagen Eurovan
90           14   2985 non-USA     Volkswagen Passat
91           15   2810 non-USA    Volkswagen Corrado

> Cars93$MPG.city
 [1] 25 18 20 19 22 22 19 16 19 16 16 25 25 19 21 18 15 17 17 20 23 20 29 23 22 17 21 18 29
[30] 20 31 23 22 22 24 15 21 18 46 30 24 42 24 29 22 26 20 17 18 18 17 18 29 28 26 18 17 20
[59] 19 23 19 29 18 29 24 17 21 24 23 18 19 23 31 23 19 19 19 20 28 33 25 23 39 32 25 22 18
[88] 25 17 21 18 21 20
> head(Cars93)
  Manufacturer   Model    Type Min.Price Price Max.Price MPG.city MPG.highway
1        Acura Integra   Small      12.9  15.9      18.8       25          31
2        Acura  Legend Midsize      29.2  33.9      38.7       18          25
3         Audi      90 Compact      25.9  29.1      32.3       20          26
4         Audi     100 Midsize      30.8  37.7      44.6       19          26
5          BMW    535i Midsize      23.7  30.0      36.2       22          30
6        Buick Century Midsize      14.2  15.7      17.3       22          31
             AirBags DriveTrain Cylinders EngineSize Horsepower  RPM Rev.per.mile
1               None      Front         4        1.8        140 6300         2890
2 Driver & Passenger      Front         6        3.2        200 5500         2335
3        Driver only      Front         6        2.8        172 5500         2280
4 Driver & Passenger      Front         6        2.8        172 5500         2535
5        Driver only       Rear         4        3.5        208 5700         2545
6        Driver only      Front         4        2.2        110 5200         2565
  Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase Width Turn.circle
1             Yes               13.2          5    177       102    68          37
2             Yes               18.0          5    195       115    71          38
3             Yes               16.9          5    180       102    67          37
4             Yes               21.1          6    193       106    70          37
5             Yes               21.1          4    186       109    69          39
6              No               16.4          6    189       105    69          41
  Rear.seat.room Luggage.room Weight  Origin          Make
1           26.5           11   2705 non-USA Acura Integra
2           30.0           15   3560 non-USA  Acura Legend
3           28.0           14   3375 non-USA       Audi 90
4           31.0           17   3405 non-USA      Audi 100
5           27.0           13   3640 non-USA      BMW 535i
6           28.0           16   2880     USA Buick Century
> sp <- split(Cars93$MPG.city, Cars93$Origin)
> summary(sp)
        Length Class  Mode   
USA     48     -none- numeric
non-USA 45     -none- numeric
> median(sp)
Error in sort.int(x, na.last = na.last, decreasing = decreasing, ...) : 
  'x' must be atomic
> median(sp[[1]])
[1] 20
> median(sp[[2]])
[1] 22
> summary(sp[[2]])
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  17.00   19.00   22.00   23.87   26.00   46.00 
> summary(sp[[1]])
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  15.00   18.00   20.00   20.96   23.00   31.00 
> sp[[1]]
 [1] 22 19 16 19 16 16 25 25 19 21 18 15 17 17 20 23 20 29 23 22 17 21 18 29 20 31 23 22 22
[30] 24 15 21 18 17 18 23 19 24 23 18 19 23 31 23 19 19 19 28
> plot(density(sp[[1]]))
> plot(density(sp[[2]]))
> plot(density(sp[[2]]), xlab='MPG.City for Non-USA')
> plot(Cars93$MPG.city, col = Cars93$Origin)
> plot(Cars93$MPG.city, col = Cars93$Origin, xlab='MPG.City')
> Cars93$Origin
 [1] non-USA non-USA non-USA non-USA non-USA USA     USA     USA     USA     USA     USA    
[12] USA     USA     USA     USA     USA     USA     USA     USA     USA     USA     USA    
[23] USA     USA     USA     USA     USA     USA     USA     USA     USA     USA     USA    
[34] USA     USA     USA     USA     USA     non-USA non-USA non-USA non-USA non-USA non-USA
[45] non-USA non-USA non-USA non-USA non-USA non-USA USA     USA     non-USA non-USA non-USA
[56] non-USA non-USA non-USA non-USA USA     USA     non-USA non-USA non-USA non-USA non-USA
[67] non-USA USA     USA     USA     USA     USA     USA     USA     USA     USA     USA    
[78] non-USA USA     non-USA non-USA non-USA non-USA non-USA non-USA non-USA non-USA non-USA
[89] non-USA non-USA non-USA non-USA non-USA
Levels: USA non-USA
> tapply(Cars93$MPG.city, Cars93$Origin, median)
    USA non-USA 
     20      22 
# same thing using sapply
> sapply(split(Cars93$MPG.city, Cars93$Origin),  median)
    USA non-USA 
     20      22 
>  

> tapply(Cars93$MPG.city, Cars93$Origin, mean)
     USA  non-USA 
20.95833 23.86667 
> tapply(Cars93$MPG.city, Cars93$Origin, sum)
    USA non-USA 
   1006    1074 
> tapply(Cars93$MPG.city, Cars93$Origin, length)
    USA non-USA 
     48      45 
	 
	 
	 
#using by

> trials
sex pre dose1 dose2 post
1 F 5.931640 2 1 3.162600
2 F 4.496187 1 2 3.293989
3 M 6.161944 1 1 4.446643
4 F 4.322465 2 1 3.334748
5 M 4.153510 1 1 4.429382
.
. (etc.)
.

by(trials, trials$sex, summary)

trials$sex: F
sex pre dose1 dose2 post
F:7 Min. :4.156 Min. :1.000 Min. :1.000 Min. :2.886
M:0 1st Qu.:4.409 1st Qu.:1.000 1st Qu.:1.000 1st Qu.:3.075
Median :4.895 Median :1.000 Median :2.000 Median :3.163
Mean :5.020 Mean :1.429 Mean :1.571 Mean :3.174
3rd Qu.:5.668 3rd Qu.:2.000 3rd Qu.:2.000 3rd Qu.:3.314
Max. :5.932 Max. :2.000 Max. :2.000 Max. :3.389



models <- by(trials, trials$sex, function(df) lm(post~pre+dose1+dose2, data=df))


#==combinations

> choose(20,4)
[1] 4845
> combn(1:5,4)
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    1    1    1    2
[2,]    2    2    2    3    3
[3,]    3    3    4    4    4
[4,]    4    5    5    5    5
> choose(5,4)
[1] 5


> combn(letters[1:5],4)
     [,1] [,2] [,3] [,4] [,5]
[1,] "a"  "a"  "a"  "a"  "b" 
[2,] "b"  "b"  "b"  "c"  "c" 
[3,] "c"  "c"  "d"  "d"  "d" 
[4,] "d"  "e"  "e"  "e"  "e" 



> combn(letters[1:6],4)
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14] [,15]
[1,] "a"  "a"  "a"  "a"  "a"  "a"  "a"  "a"  "a"  "a"   "b"   "b"   "b"   "b"   "c"  
[2,] "b"  "b"  "b"  "b"  "b"  "b"  "c"  "c"  "c"  "d"   "c"   "c"   "c"   "d"   "d"  
[3,] "c"  "c"  "c"  "d"  "d"  "e"  "d"  "d"  "e"  "e"   "d"   "d"   "e"   "e"   "e"  
[4,] "d"  "e"  "f"  "e"  "f"  "f"  "e"  "f"  "f"  "f"   "e"   "f"   "f"   "f"   "f"  
> apply(combn(letters[1:6],4) , MARGIN = 2, sample)
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14] [,15]
[1,] "d"  "e"  "f"  "d"  "f"  "f"  "a"  "a"  "c"  "a"   "d"   "b"   "b"   "b"   "c"  
[2,] "b"  "b"  "a"  "e"  "a"  "e"  "e"  "c"  "f"  "d"   "e"   "f"   "f"   "f"   "d"  
[3,] "c"  "c"  "c"  "a"  "b"  "a"  "d"  "d"  "a"  "e"   "c"   "c"   "e"   "d"   "e"  
[4,] "a"  "a"  "b"  "b"  "d"  "b"  "c"  "f"  "e"  "f"   "b"   "d"   "c"   "e"   "f"  
> 



mean(abs(x-mean(x)) > 2*sd(x))
Fraction of observations that exceed two standard deviations from the mean



# are the two variables related, Yes if p-value is <0.05
> summary(table(hitters$Sal, hitters$Years))
Number of cases in table: 263 
Number of factors: 2 
Test for independence of all factors:
	Chisq = 110.15, df = 20, p-value = 1.843e-14
	Chi-squared approximation may be incorrect
> 
# t-test
The t test is a workhorse of statistics, and this is one of its basic uses: making inferences
about a population mean from a sample. The following example simulates sampling
from a normal population with mean μ = 100. It uses the t test to ask if the population
mean could be 95, and t.test reports a p-value of 0.001897:
> x <- rnorm(50, mean=100, sd=15)
> t.test(x, mu=95)
One Sample t-test
data: x
t = 3.2832, df = 49, p-value = 0.001897
alternative hypothesis: true mean is not equal to 95
95 percent confidence interval:
97.16167 103.98297
sample estimates:
mean of x
100.5723
The p-value is small and so it’s unlikely (based on the sample data) that 95 could be
the mean of the population.


	 
	 
	 