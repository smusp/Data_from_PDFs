
## Getting summary data (correlations, means, and standard deviations)
## Appendix A (pp. 71-72) of:

## Little, T., Slegers, D., & Card, N. (2006). A non-arbitrary method of 
## identifying and scaling latent variables in SEM and MACS models. 
## Structural Equation Modeling, 13(1), 59-72.

# Little.pdf (in the pdf folder) shows just the two pages that contain Appendix A.


### Using pdftools package ###

## Required packages
library(pdftools)
library(readr)


## pdf_text() (from pdftools package) creates a vector with one string per page.
## Select the pages with Appendix A - pages 1 and 2 of the pdf.
## Appendix A is not a table, it is LISREL script. 
## Summary data (correlations, means, and standard deviations) are coded
## into the script. The data is spread across both pages.
## In LISREL, `ME` contains means;
## `SD` contains standard deviations;
## and `KM` contains the lower triangle of correlations
## with ones along the diagonal. 
## The first page contains summary data for Grade 7,
## the second page contains summary data for Grade 8. 
## The variable names are given in `LA`.
## 
## read_lines() (from readr package) creates a vector with one string per line.
## Select the lines that contain the correlations, means, and standard deviations. 
## I've also selected the line (42) that contains the variable names, 
## but moved it to the first position.
path = here::here("Little_2006", "pdf", "Little.pdf")
(tab = pdf_text(path))
(tab = readr::read_lines(tab[c(1,2)], skip_empty_rows = TRUE))
(tab = tab[c(42, 31, 33, 35:40, 59, 61, 63:68)])


## For each line in tab, trim off the leading white space, and
## reduce internal white space to a single space.
## strsplit() - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
tab = trimws(gsub("\\s+", " ", tab))
(tab = strsplit(tab, split = " "))


## Variable names are in 1st element of the list.
## I make the names a little more compact by removing "AFF" from each.
names = tab[[1]]
(names = gsub("AFF", "", names))


## Means are in elements 2 and 10.
## unlist() the two elements;
## convert the strings to numeric;
## split the vector into a two-element list:
## the 1st element contains means for Grade 7,
## the 2nd contains means for Grade 8.
means = tab[c(2, 10)]
means = unlist(means)
means = as.numeric(as.character(means))
(means = split(means, cut(seq_along(means), 2, labels = c("Grade 7", "Grade 8"))))


## Standard Deviations are in elements 3 and 11.
## Apply the same process as was applied to the means.
sd = tab[c(3, 11)]
sd = unlist(sd)
sd = as.numeric(as.character(sd))
(sd = split(sd, cut(seq_along(sd), 2, labels = c("Grade 7", "Grade 8"))))


## Correlations in elements 4 to 9, and elements 12 to 17
## Note: what appear to be minus signs are not minus signs 
## (possibly they are em dashes). 
## Replace with a minus signs.
## Then apply the same process as above.
cor = tab[c(4:9, 12:17)]
cor = lapply(cor, function(x) gsub("—", "-", x))
cor = unlist(cor)
cor = as.numeric(as.character(cor))
(cor = split(cor, cut(seq_along(cor), 2, labels = c("Grade 7", "Grade 8"))))