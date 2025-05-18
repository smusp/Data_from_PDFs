
## Getting summary data (covariances, variances, and means) for each of two groups
## from Table 5.2 (p. 183) of:

## Thompson, M. & Green, S. (2013). Evaluating between-group differences
## in latent variable means. In G. Hancock & R. Mueller (Eds.), Structural
## equation modeling: A second course (2nd Ed., pp. 163-218). Charlotte, NC:
## Information Age Publishing.

## Thompson_Table2.pdf (in the pdf folder) shows the single page that contains Table 5.2.
## The grouped data is in the upper part of Table 5.2.
## I use pdftools package only.
## Also, I do not extract the data in the combined part of the table.


### Using pdftools package ###

## Load required packages
library(pdftools)
library(readr)
library(here)           # relative paths


## pdf_text() (from pdftools package) creates a vector with one string per page.
## read_lines() (from readr package) creates a vector with one string per line.
## Select the lines that contain the table.
## Grouped data are in lines 7 to 12, and lines 14 to 19.
## Note that the covariance matrix contains the lower triangle of the 
## covariances with the variances along the diagonal.
## The means are to the right.  
path <- here::here("Thompson_2013", "pdf", "Thompson_Table2.pdf")
(tab <- pdf_text(path))
(tab <- readr::read_lines(tab, skip_empty_rows = TRUE))
(tab <- tab[c(7:12, 14:19)])


## For each line, trim off the leading white space, and
## reduce internal white space to a sinle space.
## strsplit() - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
tab <- trimws(gsub("\\s+", " ", tab))
(tab <- strsplit(tab, split = " "))


## Variable names are the first element in each line.
## Select the first element in each line - each line is an element 
## of the list, so lapply() will do the selecting.
## Unlist the list, 
## select the first 6 names.
names <- lapply(tab, "[[", 1)
names <- unlist(names)
(names <- names[1:6])


## Means are the last element in each line.
## Select the last element in each line (list element) using lapply()
## Unlist the list,
## convert characters to numeric,
## split the vector into a two-element list:
## the 1st element contains means for Group 1,
## the 2nd contains means for group 2.
means <- lapply(tab, function(x) x[length(x)])
means <- unlist(means)
means <- as.numeric(as.character(means))
(means <- split(means, cut(seq_along(means), 2, labels = c("Day-care", "Home-care"))))


## Variances/Covariances
## First strip off the names and the means.
## Unlist the list,
## convert characters to numeric,
## split the vector into a two-element list:
## The 1st contains the (co)variances for Group 1,
## the 2nd contains (co)variances for Group 2.
var <- lapply(tab, function(x) x[-length(x)])
var <- lapply(var, function(x) x[-1])
var <- unlist(var)
var <- as.numeric(as.character(var))
(var <- split(var, cut(seq_along(var), 2, labels = c("Day-care", "Home-care"))))

