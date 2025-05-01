<img src = 'logo/Banner.svg' align = "center"/>  

This repository contains **R** scripts to extract data from PDFs of published papers and books. The aim is to get summary data (means, standard deviations, correlations, variances, covariances) from tables or table-like formats so that analyses can be reproduced. 

Two approaches are demonstrated. The first uses the `pdf_text()` function from the **pdftools** package. It is good at extracting text, but that means it will extract all text, whether contained in a table or not.  My approach is to get each of the lines of text into a vector, then to select the relevant lines. The data still needs tidying up - for that I use regular expressions. 

The second approach uses the `extract_tables()` function from the **tabulapdf** package. It is good at detecting and extracting a table. The extracted table usually needs some tidying up, for instance, to separate means and standard deviations from correlations, or to remove significance markers from correlations, but tidying-up is relatively straightforward compared to the work required to tidy-up data extracted using **pdftools**.  When it works, it works well; but it does not always work. For instance, in Little_2006 the data are not contained in a table, and not surprisingly, `extract_tables()` cannot find it. A more troubling example is shown in Thompson_2023. The data are in a table but `extract_tables()` does not extract all rows of the table - not sure why. In these situations, **tabulapdf** provides an alternative function, `extract_text()`. As the name suggests, it extracts text - all text. The tidying-up process is then similar to that for **pdftools**.

The **tabulapdf** requires **rJava** which implies a system requirement for Java. It can be somewhat daunting having to install and set-up Java. The process can be simplified using the **rJavaEnv** package. Once installed, one line of **R** code will download, install, and setup Java for a given project.

<br/>



- [Kurbanoglu_2021](https://github.com/smusp/Data_from_pdf/tree/main/Kurbanoglu_2021)
The paper presents a basic three-variable mediation analysis. The R scripts extract means, standard deviations, and correlations for the three variables. Arguably, it would be quicker and simpler to cut-and-paste the means, standard deviations, and correlations into R. The purpose is to outline the process for a simple case. 

- [Little_2006](https://github.com/smusp/Data_from_pdf/tree/main/Little_2006)
The paper presents a two-group, two-construct factor model. Each construct is assessed with three manifest indicators. The R scripts extract means, standard deviations, and correlations for each group, not from a table but from LISREL script. 

- [Thompson_2013](https://github.com/smusp/Data_from_pdf/tree/main/Thompson_2013)
The chapter presents an analysis assessing group differences in latent means using a two-group, two-construct factor model and a MIMIC model. Each construct is assessed with three manifest indicators. The R scripts extract means and variances/covariances for each group (for the two-group model) and for the total sample (for the MIMIC model).
