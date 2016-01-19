> str(variablesICare)
'data.frame':	891 obs. of  10 variables:
 $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
 $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
 $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
 $ Name       : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
 $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
 $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
 $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
 $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
 $ Embarked   : Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...
> variablesICare <- select(train, -Cabin, -Parch, Name)
> str(variablesICare)
'data.frame':	891 obs. of  10 variables:
 $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
 $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
 $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
 $ Name       : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
 $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
 $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
 $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
 $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
 $ Embarked   : Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...
> variablesICare <- select(train, -Cabin, -Parch, -Name)
> str(variablesICare)
'data.frame':	891 obs. of  9 variables:
 $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
 $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
 $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
 $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
 $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
 $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
 $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
 $ Embarked   : Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...
> test <- select(train, PassengerId:Fare)
> str(test)
'data.frame':	891 obs. of  10 variables:
 $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
 $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
 $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
 $ Name       : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
 $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
 $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
 $ Parch      : int  0 0 0 0 0 0 0 1 2 0 ...
 $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
 $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
> filterClass <- filter(train, PClass==1)
Error in filter_impl(.data, dots) : object 'PClass' not found
> filterClass <- filter(train, Pclass==1)
> head(filterClass)
  PassengerId Survived Pclass
1           2        1      1
2           4        1      1
3           7        0      1
4          12        1      1
5          24        1      1
6          28        0      1
                                                 Name    Sex Age SibSp
1 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female  38     1
2        Futrelle, Mrs. Jacques Heath (Lily May Peel) female  35     1
3                             McCarthy, Mr. Timothy J   male  54     0
4                            Bonnell, Miss. Elizabeth female  58     0
5                        Sloper, Mr. William Thompson   male  28     0
6                      Fortune, Mr. Charles Alexander   male  19     3
  Parch   Ticket     Fare       Cabin Embarked
1     0 PC 17599  71.2833         C85        C
2     0   113803  53.1000        C123        S
3     0    17463  51.8625         E46        S
4     0   113783  26.5500        C103        S
5     0   113788  35.5000          A6        S
6     2    19950 263.0000 C23 C25 C27        S
> filterClass <- filter(train, Pclass==1 & Sex=female)
Error: unexpected '=' in "filterClass <- filter(train, Pclass==1 & Sex="
> filterClass <- filter(train, Pclass==1 & Sex==female)
Error in filter_impl(.data, dots) : object 'female' not found
> filterClass <- filter(train, Pclass==1 & Sex=='female')
> head(filterClass)
  PassengerId Survived Pclass
1           2        1      1
2           4        1      1
3          12        1      1
4          32        1      1
5          53        1      1
6          62        1      1
                                                 Name    Sex Age SibSp
1 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female  38     1
2        Futrelle, Mrs. Jacques Heath (Lily May Peel) female  35     1
3                            Bonnell, Miss. Elizabeth female  58     0
4      Spencer, Mrs. William Augustus (Marie Eugenie) female  NA     1
5            Harper, Mrs. Henry Sleeper (Myna Haxtun) female  49     1
6                                 Icard, Miss. Amelie female  38     0
  Parch   Ticket     Fare Cabin Embarked
1     0 PC 17599  71.2833   C85        C
2     0   113803  53.1000  C123        S
3     0   113783  26.5500  C103        S
4     0 PC 17569 146.5208   B78        C
5     0 PC 17572  76.7292   D33        C
6     0   113572  80.0000   B28         
> nrow(filterClass)
[1] 94
> head(arrange(train, Fare))
  PassengerId Survived Pclass                            Name  Sex Age
1         180        0      3             Leonard, Mr. Lionel male  36
2         264        0      1           Harrison, Mr. William male  40
3         272        1      3    Tornquist, Mr. William Henry male  25
4         278        0      2     Parkes, Mr. Francis "Frank" male  NA
5         303        0      3 Johnson, Mr. William Cahoone Jr male  19
6         414        0      2  Cunningham, Mr. Alfred Fleming male  NA
  SibSp Parch Ticket Fare Cabin Embarked
1     0     0   LINE    0              S
2     0     0 112059    0   B94        S
3     0     0   LINE    0              S
4     0     0 239853    0              S
5     0     0   LINE    0              S
6     0     0 239853    0              S
> head(arrange(train, -Fare))
  PassengerId Survived Pclass                               Name    Sex
1         259        1      1                   Ward, Miss. Anna female
2         680        1      1 Cardeza, Mr. Thomas Drake Martinez   male
3         738        1      1             Lesurer, Mr. Gustave J   male
4          28        0      1     Fortune, Mr. Charles Alexander   male
5          89        1      1         Fortune, Miss. Mabel Helen female
6         342        1      1     Fortune, Miss. Alice Elizabeth female
  Age SibSp Parch   Ticket     Fare       Cabin Embarked
1  35     0     0 PC 17755 512.3292                    C
2  36     0     1 PC 17755 512.3292 B51 B53 B55        C
3  35     0     0 PC 17755 512.3292        B101        C
4  19     3     2    19950 263.0000 C23 C25 C27        S
5  23     3     2    19950 263.0000 C23 C25 C27        S
6  24     3     2    19950 263.0000 C23 C25 C27        S
> head(arrange(train, -Fare, Ticket))
  PassengerId Survived Pclass                               Name    Sex
1         259        1      1                   Ward, Miss. Anna female
2         680        1      1 Cardeza, Mr. Thomas Drake Martinez   male
3         738        1      1             Lesurer, Mr. Gustave J   male
4          28        0      1     Fortune, Mr. Charles Alexander   male
5          89        1      1         Fortune, Miss. Mabel Helen female
6         342        1      1     Fortune, Miss. Alice Elizabeth female
  Age SibSp Parch   Ticket     Fare       Cabin Embarked
1  35     0     0 PC 17755 512.3292                    C
2  36     0     1 PC 17755 512.3292 B51 B53 B55        C
3  35     0     0 PC 17755 512.3292        B101        C
4  19     3     2    19950 263.0000 C23 C25 C27        S
5  23     3     2    19950 263.0000 C23 C25 C27        S
6  24     3     2    19950 263.0000 C23 C25 C27        S
> head(arrange(train, Fare, Pclass))
  PassengerId Survived Pclass                            Name  Sex Age
1         264        0      1           Harrison, Mr. William male  40
2         634        0      1   Parr, Mr. William Henry Marsh male  NA
3         807        0      1          Andrews, Mr. Thomas Jr male  39
4         816        0      1                Fry, Mr. Richard male  NA
5         823        0      1 Reuchlin, Jonkheer. John George male  38
6         278        0      2     Parkes, Mr. Francis "Frank" male  NA
  SibSp Parch Ticket Fare Cabin Embarked
1     0     0 112059    0   B94        S
2     0     0 112052    0              S
3     0     0 112050    0   A36        S
4     0     0 112058    0  B102        S
5     0     0  19972    0              S
6     0     0 239853    0              S
> head(arrange(train, Fare, -Pclass))
  PassengerId Survived Pclass                            Name  Sex Age
1         180        0      3             Leonard, Mr. Lionel male  36
2         272        1      3    Tornquist, Mr. William Henry male  25
3         303        0      3 Johnson, Mr. William Cahoone Jr male  19
4         598        0      3             Johnson, Mr. Alfred male  49
5         278        0      2     Parkes, Mr. Francis "Frank" male  NA
6         414        0      2  Cunningham, Mr. Alfred Fleming male  NA
  SibSp Parch Ticket Fare Cabin Embarked
1     0     0   LINE    0              S
2     0     0   LINE    0              S
3     0     0   LINE    0              S
4     0     0   LINE    0              S
5     0     0 239853    0              S
6     0     0 239853    0              S
> head(arrange(train, -Fare, -Pclass))
  PassengerId Survived Pclass                               Name    Sex
1         259        1      1                   Ward, Miss. Anna female
2         680        1      1 Cardeza, Mr. Thomas Drake Martinez   male
3         738        1      1             Lesurer, Mr. Gustave J   male
4          28        0      1     Fortune, Mr. Charles Alexander   male
5          89        1      1         Fortune, Miss. Mabel Helen female
6         342        1      1     Fortune, Miss. Alice Elizabeth female
  Age SibSp Parch   Ticket     Fare       Cabin Embarked
1  35     0     0 PC 17755 512.3292                    C
2  36     0     1 PC 17755 512.3292 B51 B53 B55        C
3  35     0     0 PC 17755 512.3292        B101        C
4  19     3     2    19950 263.0000 C23 C25 C27        S
5  23     3     2    19950 263.0000 C23 C25 C27        S
6  24     3     2    19950 263.0000 C23 C25 C27        S
> head(arrange(train, -Fare, Pclass))
  PassengerId Survived Pclass                               Name    Sex
1         259        1      1                   Ward, Miss. Anna female
2         680        1      1 Cardeza, Mr. Thomas Drake Martinez   male
3         738        1      1             Lesurer, Mr. Gustave J   male
4          28        0      1     Fortune, Mr. Charles Alexander   male
5          89        1      1         Fortune, Miss. Mabel Helen female
6         342        1      1     Fortune, Miss. Alice Elizabeth female
  Age SibSp Parch   Ticket     Fare       Cabin Embarked
1  35     0     0 PC 17755 512.3292                    C
2  36     0     1 PC 17755 512.3292 B51 B53 B55        C
3  35     0     0 PC 17755 512.3292        B101        C
4  19     3     2    19950 263.0000 C23 C25 C27        S
5  23     3     2    19950 263.0000 C23 C25 C27        S
6  24     3     2    19950 263.0000 C23 C25 C27        S
> head(arrange(train, -Fare, -Pclass))
  PassengerId Survived Pclass                               Name    Sex
1         259        1      1                   Ward, Miss. Anna female
2         680        1      1 Cardeza, Mr. Thomas Drake Martinez   male
3         738        1      1             Lesurer, Mr. Gustave J   male
4          28        0      1     Fortune, Mr. Charles Alexander   male
5          89        1      1         Fortune, Miss. Mabel Helen female
6         342        1      1     Fortune, Miss. Alice Elizabeth female
  Age SibSp Parch   Ticket     Fare       Cabin Embarked
1  35     0     0 PC 17755 512.3292                    C
2  36     0     1 PC 17755 512.3292 B51 B53 B55        C
3  35     0     0 PC 17755 512.3292        B101        C
4  19     3     2    19950 263.0000 C23 C25 C27        S
5  23     3     2    19950 263.0000 C23 C25 C27        S
6  24     3     2    19950 263.0000 C23 C25 C27        S
> select(train, Sex, Survived) %>%
+ group_by(Sex) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Fare))
Error in mean(Fare) : 
  error in evaluating the argument 'x' in selecting a method for function 'mean': Error: object 'Fare' not found
> select(train, Sex, Survived) %>%
+ group_by(Sex) %>%
+ summarize(Probsurvived=mean(Survived))
Source: local data frame [2 x 2]

     Sex Probsurvived
1 female    0.7420382
2   male    0.1889081
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Fare))
Source: local data frame [3 x 4]

  Pclass  AvgFare ProbSurvived   N
1      1 84.15469    0.6296296 216
2      2 20.66218    0.4728261 184
3      3 13.67555    0.2423625 491
> summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Pclass))
Error in summarise_(.data, .dots = lazyeval::lazy_dots(...)) : 
  argument ".data" is missing, with no default
> summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Error in summarise_(.data, .dots = lazyeval::lazy_dots(...)) : 
  argument ".data" is missing, with no default
> summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Fare))
Error in summarise_(.data, .dots = lazyeval::lazy_dots(...)) : 
  argument ".data" is missing, with no default
> summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Fare))
Error in summarise_(.data, .dots = lazyeval::lazy_dots(...)) : 
  argument ".data" is missing, with no default
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Fare))
Source: local data frame [3 x 4]

  Pclass  AvgFare ProbSurvived   N
1      1 84.15469    0.6296296 216
2      2 20.66218    0.4728261 184
3      3 13.67555    0.2423625 491
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Pclass))
Source: local data frame [3 x 4]

  Pclass  AvgFare ProbSurvived   N
1      1 84.15469    0.6296296 216
2      2 20.66218    0.4728261 184
3      3 13.67555    0.2423625 491
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [3 x 4]

  Pclass  AvgFare ProbSurvived   N
1      1 84.15469    0.6296296 216
2      2 20.66218    0.4728261 184
3      3 13.67555    0.2423625 491
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(train))
Source: local data frame [3 x 4]

  Pclass  AvgFare ProbSurvived  N
1      1 84.15469    0.6296296 12
2      2 20.66218    0.4728261 12
3      3 13.67555    0.2423625 12
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [3 x 4]

  Pclass  AvgFare ProbSurvived   N
1      1 84.15469    0.6296296 216
2      2 20.66218    0.4728261 184
3      3 13.67555    0.2423625 491
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass, Sex) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [6 x 5]
Groups: Pclass

  Pclass    Sex   AvgFare ProbSurvived   N
1      1 female 106.12580    0.9680851  94
2      1   male  67.22613    0.3688525 122
3      2 female  21.97012    0.9210526  76
4      2   male  19.74178    0.1574074 108
5      3 female  16.11881    0.5000000 144
6      3   male  12.66163    0.1354467 347
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Sex) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [2 x 4]

     Sex  AvgFare ProbSurvived   N
1 female 44.47982    0.7420382 314
2   male 25.52389    0.1889081 577
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Pclass, Sex, Embarked) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Error: unknown column 'Embarked'
> str(train)
'data.frame':	891 obs. of  12 variables:
 $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
 $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
 $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
 $ Name       : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
 $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
 $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
 $ Parch      : int  0 0 0 0 0 0 0 1 2 0 ...
 $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
 $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
 $ Cabin      : Factor w/ 148 levels "","A10","A14",..: 1 83 1 57 1 1 131 1 1 1 ...
 $ Embarked   : Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...
> select(train, Sex, Survived, Fare, Pclass) %>%
+ group_by(Sex, Embarked, Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Error: unknown column 'Embarked'
> select(train, Sex, Survived, Fare, Pclass, Embarked) %>%
+ group_by(Sex, Embarked, Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [19 x 6]
Groups: Sex, Embarked

      Sex Embarked Pclass    AvgFare ProbSurvived   N
1  female               1  80.000000   1.00000000   2
2  female        C      1 115.640309   0.97674419  43
3  female        C      2  25.268457   1.00000000   7
4  female        C      3  14.694926   0.65217391  23
5  female        Q      1  90.000000   1.00000000   1
6  female        Q      2  12.350000   1.00000000   2
7  female        Q      3  10.307833   0.72727273  33
8  female        S      1  99.026910   0.95833333  48
9  female        S      2  21.912687   0.91044776  67
10 female        S      3  18.670077   0.37500000  88
11   male        C      1  93.536707   0.40476190  42
12   male        C      2  25.421250   0.20000000  10
13   male        C      3   9.352237   0.23255814  43
14   male        Q      1  90.000000   0.00000000   1
15   male        Q      2  12.350000   0.00000000   1
16   male        Q      3  11.924251   0.07692308  39
17   male        S      1  52.949947   0.35443038  79
18   male        S      2  19.232474   0.15463918  97
19   male        S      3  13.307149   0.12830189 265
> select(train, Sex, Survived, Fare, Pclass, Embarked) %>%
+ group_by(Embarked, Pclass) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [10 x 5]
Groups: Embarked

   Embarked Pclass   AvgFare ProbSurvived   N
1                1  80.00000    1.0000000   2
2         C      1 104.71853    0.6941176  85
3         C      2  25.35834    0.5294118  17
4         C      3  11.21408    0.3787879  66
5         Q      1  90.00000    0.5000000   2
6         Q      2  12.35000    0.6666667   3
7         Q      3  11.18339    0.3750000  72
8         S      1  70.36486    0.5826772 127
9         S      2  20.32744    0.4634146 164
10        S      3  14.64408    0.1898017 353
> select(train, Sex, Survived, Fare, Pclass, Embarked) %>%
+ group_by(Embarked, Sex) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [7 x 5]
Groups: Embarked

  Embarked    Sex  AvgFare ProbSurvived   N
1          female 80.00000   1.00000000   2
2        C female 75.16981   0.87671233  73
3        C   male 48.26211   0.30526316  95
4        Q female 12.63496   0.75000000  36
5        Q   male 13.83892   0.07317073  41
6        S female 38.74093   0.68965517 203
7        S   male 21.71200   0.17460317 441
> select(train, Sex, Survived, Fare, Pclass, Embarked) %>%
+ group_by(Pclass, Sex) %>%
+ summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))
Source: local data frame [6 x 5]
Groups: Pclass

  Pclass    Sex   AvgFare ProbSurvived   N
1      1 female 106.12580    0.9680851  94
2      1   male  67.22613    0.3688525 122
3      2 female  21.97012    0.9210526  76
4      2   male  19.74178    0.1574074 108
5      3 female  16.11881    0.5000000 144
6      3   male  12.66163    0.1354467 347



> ggplot(A)
Error: No layers in plot
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+ geom_point(aes(Size=N))+
+ geom_line(aes(by=Sex, color=Sex))
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+   geom_point(aes(Size=N))+
+   geom_line(aes(by=Sex, color=Sex))
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+   geom_point(aes(Size=N))+
+   geom_line(aes(by=Sex, color=Sex))
> A
Source: local data frame [6 x 5]
Groups: Pclass

  Pclass    Sex   AvgFare ProbSurvived   N
1      1 female 106.12580    0.9680851  94
2      1   male  67.22613    0.3688525 122
3      2 female  21.97012    0.9210526  76
4      2   male  19.74178    0.1574074 108
5      3 female  16.11881    0.5000000 144
6      3   male  12.66163    0.1354467 347
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+   geom_point(aes(Size=N))+
+   geom_line(aes(by=Fare, color=Fare))
Error in eval(expr, envir, enclos) : object 'Fare' not found
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+   geom_point(aes(Size=N))+
+   geom_line(aes(by=Sex, color=Sex))
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+   geom_point(aes(Size=N))
> ggplot(A, aes(x=Pclass, y=ProbSurvived))+
+   geom_point(aes(Size=N))+
+   geom_line(aes(by=Sex, color=Sex))
> 

============the old way, using aggregate()

> str(train)
'data.frame':	891 obs. of  12 variables:
 $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
 $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
 $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
 $ Name       : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
 $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...
 $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
 $ Parch      : int  0 0 0 0 0 0 0 1 2 0 ...
 $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
 $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
 $ Cabin      : Factor w/ 148 levels "","A10","A14",..: 1 83 1 57 1 1 131 1 1 1 ...
 $ Embarked   : Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...
> select(train, Pclass, Sex, Age, Survived) %>%
+ group_by(Sex, Pclass) %>%
+ summarize(AverageAge=mean(Age), SurvChance=mean(Survived), N=length(Sex))
Source: local data frame [6 x 5]
Groups: Sex

     Sex Pclass AverageAge SurvChance   N
1 female      1         NA  0.9680851  94
2 female      2         NA  0.9210526  76
3 female      3         NA  0.5000000 144
4   male      1         NA  0.3688525 122
5   male      2         NA  0.1574074 108
6   male      3         NA  0.1354467 347
> select(train, Pclass, Sex, Age, Survived) %>%
+ group_by(Sex, Pclass) %>%
+ summarize(SurvChance=mean(Survived), N=length(Sex))
Source: local data frame [6 x 4]
Groups: Sex

     Sex Pclass SurvChance   N
1 female      1  0.9680851  94
2 female      2  0.9210526  76
3 female      3  0.5000000 144
4   male      1  0.3688525 122
5   male      2  0.1574074 108
6   male      3  0.1354467 347
====lets do the same, old school way
> A = aggregate(train, by=list(train$Sex, train$Survived), FUN='mean')
There were 20 warnings (use warnings() to see them)
> A
  Group.1 Group.2 PassengerId Survived   Pclass Name Sex Age     SibSp
1  female       0    434.8519        0 2.851852   NA  NA  NA 1.2098765
2    male       0    449.1218        0 2.476496   NA  NA  NA 0.4401709
3  female       1    429.6996        1 1.918455   NA  NA  NA 0.5150215
4    male       1    475.7248        1 2.018349   NA  NA  NA 0.3853211
      Parch Ticket     Fare Cabin Embarked
1 1.0370370     NA 23.02439    NA       NA
2 0.2072650     NA 21.96099    NA       NA
3 0.5150215     NA 51.93857    NA       NA
4 0.3577982     NA 40.82148    NA       NA
> A = aggregate(train$Survived, by=list(train$Sex, train$Survived), FUN='mean')
> A
  Group.1 Group.2 x
1  female       0 0
2    male       0 0
3  female       1 1
4    male       1 1
> A = aggregate(train$Survived, by=list(Sex=train$Sex, Chance=train$Survived), FUN='mean')
> A
     Sex Chance x
1 female      0 0
2   male      0 0
3 female      1 1
4   male      1 1
> B= aggregate(train$Survived, by=list(Sex=train$Sex, chance=train$Survived), FUN = 'length')
> B
     Sex chance   x
1 female      0  81
2   male      0 468
3 female      1 233
4   male      1 109
> A = aggregate(train$Survived, by=list(Sex=train$Sex, Class=train$Pclass), FUN='mean')
> A
     Sex Class         x
1 female     1 0.9680851
2   male     1 0.3688525
3 female     2 0.9210526
4   male     2 0.1574074
5 female     3 0.5000000
6   male     3 0.1354467
> B= aggregate(train$Survived, by=list(Sex=train$Sex, Class=train$Pclass), FUN = 'length')
> B
     Sex Class   x
1 female     1  94
2   male     1 122
3 female     2  76
4   male     2 108
5 female     3 144
6   male     3 347
> cbind(A,B$x)
     Sex Class         x B$x
1 female     1 0.9680851  94
2   male     1 0.3688525 122
3 female     2 0.9210526  76
4   male     2 0.1574074 108
5 female     3 0.5000000 144
6   male     3 0.1354467 347
> cbind(A,N=B$x)
     Sex Class         x   N
1 female     1 0.9680851  94
2   male     1 0.3688525 122
3 female     2 0.9210526  76
4   male     2 0.1574074 108
5 female     3 0.5000000 144
6   male     3 0.1354467 347
> 
====old result using dplyr 
Groups: Sex

     Sex Pclass SurvChance   N
1 female      1  0.9680851  94
2 female      2  0.9210526  76
3 female      3  0.5000000 144
4   male      1  0.3688525 122
5   male      2  0.1574074 108
6   male      3  0.1354467 347


====using dplyr output in ggplot for plotting graphs 

A=select(train, Sex, Survived, Fare, Pclass, Embarked) %>%
group_by(Pclass, Sex) %>%
summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))

ggplot(A, aes(x=Pclass, y=ProbSurvived))+
  geom_point(aes(Size=N))+
  geom_line(aes(by=Sex, color=Sex))
