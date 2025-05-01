
## Getting summary data (correlations, means, and standard deviations)
## from Table 1 (p. 50) of:

## Kurbanoglu, N. & Takunyaci, M. (2021). A structural equation modeling 
## on relationship between self-efficacy, physics laboratory anxiety
## and attitudes. Journal of Family, Counseling and Education, 6(1), 47-56.

## The paper is contained in the pdf folder.


### Using pdftools package ###

## Required packages
library(pdftools)
library(readr)
library(here)           # relative paths


## pdf_text() (from pdftools package) creates a vector with one string per page.
## Select the page with Table 1 - the 4th page of the pdf.
## read_lines() (from readr package) creates a vector with one string per line.
## Select the lines that contain Table 1, 
## or rather, the part of Table 1 that contains the correlations, means, 
## and standard deviations.
path = here::here("Kurbanoglu_2021", "pdf", "Kurbanoglu.pdf")
(tab = pdf_text(path))
(tab = readr::read_lines(tab[4], skip_empty_rows = TRUE))
(tab = tab[13:17])

## Two regexes
## First, for each string, drop the text and the white space before the table elements.
## The regex searches: 
##    ^ from the beginning of the string;
##    .+ for any character any number of times;
##    \\s{25,} followed by at least 25 spaces.
(tab = gsub("^.+\\s{25,}", "", tab))


## Second, for each string, reduce white space inside each string to just one space.
## The second regex searches:
##    \\s+  for one or more spaces.
(tab = gsub("\\s+", " ", tab))


## strsplit()  - each line becomes an element in a list, 
## and each string is split at the space into separate strings.
(tab = strsplit(tab, split = " "))


## Means are in the 4th element of the list.
## Convert strings to numeric.
(means = as.numeric(as.character(tab[[4]])))

## Standard deviations are in the 5th element of the list.
## Convert strings to numeric.
(sd = as.numeric(as.character(tab[[5]])))


## Correlations are in the first three elements of the list.
## Unlist the three elements,
## drop the asterisks,
## convert the strings to numeric.
cor = unlist(tab[c(1:3)])
cor = gsub("\\*", "", cor) 
(cor = as.numeric(as.character(cor)))
