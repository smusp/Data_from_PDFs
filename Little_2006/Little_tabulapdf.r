
## Getting summary data (correlations, means, and standard deviations)
## Appendix A (pp. 71-72) of:

## Little, T., Slegers, D., & Card, N. (2006). A non-arbitrary method of 
## identifying and scaling latent variables in SEM and MACS models. 
## Structural Equation Modeling, 13(1), 59-72.

# Little.pdf (in the pdf folder) shows just the two pages that contain Appendix A.


### Using tabulapdf package ###


## First, set Java environment in current directory
## Install rJavaEnv package (if not already installed),
## then run following r code:
##    rJavaEnv::java_quick_install(version = 21)


##  Load required packages
library(tabulapdf)
library(readr)

## Get the summary data.
## There is no "table" in the pdf document,
## and as a result, extract_tables() will return an empty list.
## Use extract_text() instead.
path = here::here("Little_2006", "pdf", "Little.pdf")
tab <- extract_text(path, pages = c(1,2))
(tab = readr::read_lines(tab, skip_empty_rows = TRUE))


## Select the relevant rows
(tab = tab[c(41, 30, 32, 34:39, 58, 60, 62:67)])


## The steps are more-or-less the same as above. 
## strsplit() - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
(tab = strsplit(tab, split = " "))


## Variable names in element 1
names = tab[[1]]
(names = gsub("AFF", "", names))


## Means in elements 2 and 10
means = tab[c(2, 10)]
means = unlist(means)
means = as.numeric(as.character(means))
(means = split(means, cut(seq_along(means), 2, labels = c("Grade 7", "Grade 8"))))


## Standard Deviations in elements 3 and 11
sd = tab[c(3, 11)]
sd = unlist(sd)
sd = as.numeric(as.character(sd))
(sd = split(sd, cut(seq_along(sd), 2, labels = c("Grade 7", "Grade 8"))))


## Correlations in elements 4 to 9, and elements 12 to 17
cor = tab[c(4:9, 12:17)]
cor = lapply(cor, function(x) gsub("—", "-", x))
cor = unlist(cor)
cor = as.numeric(as.character(cor))
(cor = split(cor, cut(seq_along(cor), 2, labels = c("Grade 7", "Grade 8"))))



