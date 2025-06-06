
## Getting summary data (covariances, variances, and means) for each of two groups
## from Table 5.1 (p. 169) of:

## Thompson, M. & Green, S. (2013). Evaluating between-group differences
## in latent variable means. In G. Hancock & R. Mueller (Eds.), Structural
## equation modeling: A second course (2nd Ed., pp. 163-218). Charlotte, NC:
## Information Age Publishing.

## Thompson_Table1.pdf (in the pdf folder) shows the single page that contains Table 5.1.
## The grouped data is in the upper part of Table 5.1.


### Using pdftools package ###

## Load required packages
library(pdftools)
library(readr)
library(here)           # relative paths


## pdf_text() (from pdftools package) creates a vector with one string per page.
## read_lines() (from readr package) creates a vector with one string per line.
## Select the lines that contain the table or the required part of the table.
## Grouped data are in lines 7 to 12, and lines 14 to 19.
## Note that the covariance matrix contains the lower triangle of the 
## covariances with the variances along the diagonal.
## The means are to the right.  
path <- here::here("Thompson_2013", "pdf", "Thompson_Table1.pdf")
(tab <- pdf_text(path))
(tab <- readr::read_lines(tab, skip_empty_rows = TRUE))
(tab <- tab[c(7:12, 14:19)])


## For each line, trim off the leading white space, and
## reduce internal white space to a single space.
## strsplit() - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
tab <- trimws(gsub("\\s+", " ", tab))
(tab <- strsplit(tab, split = " "))


## Variable names are the first element in each line.
## Select the first element in each line - each line is an element 
## of the list, so sapply() will do the selecting.
## Select the first 6 names.
names <- sapply(tab, "[[", 1)
(names <- names[1:6])


## Means are the last element in each line.
## Select the last element in each line (list element) using sapply()
## convert characters to numeric,
## split the vector into a two-element list:
## the 1st element contains means for Group 1,
## the 2nd contains means for group 2.
means <- sapply(tab, function(x) x[length(x)])
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





### Using tabulapdf package ###


## First, set Java environment in current directory
## Install rJavaEnv package (if not already installed),
## then run following r code:
##    rJavaEnv::java_quick_install(version = 21)


##  Load required packages
library(tabulapdf)
library(here)           # relative paths

## Get the data table
path <- here::here("Thompson_2013", "pdf", "Thompson_Table1.pdf")
tab <- extract_tables(path, pages = 1)[[1]]
print(tab, n = 20)


## Select the relevant lines.
## Each line becomes an element of a list.
(tab <- tab[[1]][c(5:10, 12:17)])
(tab <- strsplit(tab, split = " "))


## Names are the first element in each line
names <- sapply(tab, function(x) x[1])
(names <- names[1:6])


## Means are the last element in each line
means <- sapply(tab, function(x) x[length(x)])
means <- as.numeric(as.character(means))
(means <- split(means, cut(seq_along(means), 2, labels = c("Day-care", "Home-care"))))


## Variances
## Strip off names and means.
## Unlist the list,
## convert characters to numeric,
## split the vector into a two-element list.
var <- lapply(tab, function(x) x[-length(x)])
var <- lapply(var, function(x) x[-1])
var <- unlist(var)
var <- as.numeric(as.character(var))
(var <- split(var, cut(seq_along(var), 2, labels = c("Group 1", "Group 2"))))
