
## Getting summary data (covariances, variances, and means) for combined group
## from Table 5.1 (p. 169) of:

## Thompson, M. & Green, S. (2013). Evaluating between-group differences
## in latent variable means. In G. Hancock & R. Mueller (Eds.), Structural
## equation modeling: A second course (2nd Ed., pp. 163-218). Charlotte, NC:
## Information Age Publishing.

## Thompson_Table1.pdf (in the pdf folder) shows the single page that contains Table 5.1.
## The combined data is in the lower part of Table 5.1.


### Using pdftools package ###

## Load required packages
library(pdftools)
library(readr)
library(here)           # relative paths


## pdf_text() (from pdftools package) creates a vector with one string per page.
## read_lines() (from readr package) creates a vector with one string per line.
## Select the lines that contain the table, or the required part of the table.
## Combined data are in lines 23 to 29.
## Note that the covariance matrix contains the lower triangle of the 
## covariances with the variances along the diagonal. 
## Means are not required in the analysis, and therefore, there are no means 
## in this part of the data. 
path <- here::here("Thompson_2013", "pdf", "Thompson_Table1.pdf")
(tab <- pdf_text(path))
(tab <- readr::read_lines(tab, skip_empty_rows = TRUE))
(tab <- tab[c(23:29)])


## For each line, trim off the leading white space, and
## reduce internal white space to a single space.
## strsplit() - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
tab <- trimws(gsub("\\s+", " ", tab))
(tab <- strsplit(tab, split = " "))


## Variable names are the first element in each line.
## For each element in the list, select the first element of the vector.
## Unlist the list
names <- lapply(tab, "[[", 1)
(names <- unlist(names))


## Variances/Covariances
## Strip off the names,
## unlist the list,
## convert characters to numeric.
var <- lapply(tab, function(x) x[-1])
var <- unlist(var)
(var <- as.numeric(as.character(var)))





### Using tabulapdf package ###

##  Load required packages
library(tabulapdf)
library(here)           # relative paths

## Get the data table
path <- here::here("Thompson_2013", "pdf", "Thompson_Table1.pdf")
tab <- extract_tables(path, pages = 1)[[1]]
print(tab, n = 30)

## Note that in the 'combined' section,
## the row containing V7 has not been extracted.
## I could use locate_areas(). When I do, on my machine, the numbers in the 
## resulting table have been rounded up, but not consistently - 
## some rounded up to a whole number, some to one decimal place, 
## some with no rounding up. 

locate_areas(path, widget = "native")
tab <- extract_tables(path, guess = FALSE,
   area = list(c(319.17862,  61.71431, 410.78578, 373.17864)))[[1]]
print(tab)


## Using extract_text() instead
tab <- extract_text(path, pages = 1)[[1]]
(tab <- readr::read_lines(tab, skip_empty_rows = TRUE))


## Select the relevant rows for the combined 
## Combined part of the table is in rows 36 to 42
(tab <- tab[c(36:42)])


## The steps are more-or-less the same as when using pdftools. 
## strsplit() - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
(tab <- strsplit(tab, split = " "))


## Names are the first element of each line
names <- lapply(tab, function(x) x[1])
(names <- unlist(names))


## Variances/Covariances
## Strip off the names,
## unlist the list,
## convert characters to numeric.
var <- lapply(tab, function(x) x[-1])
var <- unlist(var)
(var <- as.numeric(as.character(var)))
