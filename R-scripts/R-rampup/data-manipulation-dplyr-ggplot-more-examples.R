# data manipulation 
# http://lincolnmullen.com/projects/dh-r/data.html

require(historydata)
data(us_state_populations)

birthplace_1850 <- read.csv("C:/Ahmed/ML/dataset local copy/nhgis0023_ds12_1850_state.csv",
                            header=T)

require(tidyr)
# merge all columns execpt the below 5, as rest 65 are same 
# key-value mapping i.e AreaCode :Count
# -GISJOIN, -YEAR, -STATE, -STATEA, -AREANAME 
t <- birthplace_1850 %>%
  gather(birthplace, count, -GISJOIN, -YEAR, -STATE, -STATEA, -AREANAME)

# row count changes as below
> length(colnames(birthplace_1850))
[1] 70
> 65*nrow(birthplace_1850)
[1] 2340
> nrow(t)
[1] 2340
birthplace_long <- t

# revert back to old, wide column format
spread(t, birthplace, count)

# how many data for each birthplace ?
table(birthplace_long$birthplace)

#In tidy data:
#  1. Each variable forms a column.
#  2. Each observation forms a row.
#  3. Each type of observational unit forms a table.2


#Example: Tidying and analyzing birthplace data
birthplace1 <- "C:/Ahmed/ML/dataset local copy/nhgis-nativity/nhgis0023_ds12_1850_state.csv"
birthplace2 <- "C:/Ahmed/ML/dataset local copy/nhgis-nativity/nhgis0024_ds15_1860_state.csv"
birthplace3 <- "C:/Ahmed/ML/dataset local copy/nhgis-nativity/nhgis0024_ds17_1870_state.csv"

codes1 <- "C:/Ahmed/ML/dataset local copy/nhgis-nativity/nhgis0023_ds12_1850_state_codebook.txt"
codes2 <- "C:/Ahmed/ML/dataset local copy/nhgis-nativity/nhgis0024_ds15_1860_state_codebook.txt"
codes3 <- "C:/Ahmed/ML/dataset local copy/nhgis-nativity/nhgis0024_ds17_1870_state_codebook.txt"

birthdata1 <- read.csv(birthplace1, stringsAsFactors = FALSE)
birthdata2 <- read.csv(birthplace2, stringsAsFactors = FALSE)
birthdata3 <- read.csv(birthplace3, stringsAsFactors = FALSE)


library(dplyr)
library(tidyr)

birthdata1 %>%
  gather(code, value, -GISJOIN, -YEAR, -STATE, -STATEA, -AREANAME) %>%
  tbl_df() -> birthdata1

birthdata2 %>%
  gather(code, value, -GISJOIN, -YEAR, -STATE, -STATEA, -AREANAME) %>%
  tbl_df() -> birthdata2

birthdata3 %>%
  gather(code, value, -GISJOIN, -YEAR, -STATE, -STATEA, -AREANAME) %>%
  tbl_df() -> birthdata3

#merget all 3
birthplace <- rbind(birthdata1, birthdata2, birthdata3)
birthplace


#OR 
# simpler way to ready multiple files and merge all to One

csv_files <- Sys.glob("C:/Ahmed/ML/dataset local copy/nhgis-nativity/*state.csv")

birthplace_data <- lapply(csv_files, read.csv, stringsAsFactors = FALSE)

str(birthplace_data, max.level = 1)

# apply gather to each dframe separately
birthplace_reshaped <- lapply(birthplace_data, function(df) {
    df %>%
      gather(code, value, -GISJOIN, -YEAR, -STATE, -STATEA, -AREANAME) %>%
      tbl_df()
  })
birthplace_reshaped

birthplace <- rbind_all(birthplace_reshaped)
birthplace


#lets read the codebooks
# install.packages("devtools")
# devtools::install_github("lmullen/mullenMisc")
library(mullenMisc)
Sys.glob("C:/Ahmed/ML/dataset local copy/nhgis-nativity/*state_codebook.txt") %>%
  lapply(parse_nhgis_codebook) %>%
  rbind_all() -> codebooks

codebooks
