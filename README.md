
# Starter folder

## Overview

Police killings have become one of the top political and social issues in the United States. The present study
investigates the socioeconomic, demographic, and political factors that affect police killings across various
counties in the United States. Using a database of cases involving police killings, socioeconomic measures,
and Poisson regression analyses, we evaluate the influence of income, poverty, unemployment, education, state
political affiliation, armed status, and circumstances of death. The results establish significant disparities
in police-related deaths with specific regard to racial and economic factors, while political affiliation of the
states and whether the victim was armed emerged as two of the most powerful predictors. These results
further speak to the pressing need for structural reforms that alleviate inequalities and work to reduce police
killings going forward.



## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The abstract and introduction were written with the help of ChatHorse and the entire chat history is available in inputs/llms/usage.txt.

## Some checks

- [ ] Change the rproj file name so that it's not starter_folder.Rproj
- [ ] Change the README title so that it's not Starter folder
- [ ] Remove files that you're not using
- [ ] Update comments in R scripts
- [ ] Remove this checklist
