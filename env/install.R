cran_packages <- c(
  "arrow",
  "cowplot",
  "data.table",
  "dplyr",
  "effectsize",
  "effsize",
  "ggplot2",
  "ggpubr",
  "janitor",
  "knitr",
  "lubridate",
  "matrixStats",
  "msigdbr",
  "naniar",
  "patchwork",
  "pROC",
  "purrr",
  "readr",
  "reticulate",
  "rmarkdown",
  "stringr",
  "sva",
  "tibble",
  "tidyr",
  "tidyverse",
  "visdat",
  "yaml"
)

bioc_packages <- c(
  "AnnotationDbi",
  "GSVA",
  "MOFA2",
  "MOFAdata",
  "ReactomePA",
  "clusterProfiler",
  "imputeLCMD",
  "mixOmics",
  "org.Hs.eg.db"
)

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager", repos = "https://cloud.r-project.org")
}

cran_missing <- cran_packages[!cran_packages %in% rownames(installed.packages())]
if (length(cran_missing)) {
  install.packages(cran_missing, repos = "https://cloud.r-project.org")
}

bioc_missing <- bioc_packages[!bioc_packages %in% rownames(installed.packages())]
if (length(bioc_missing)) {
  BiocManager::install(bioc_missing, ask = FALSE, update = FALSE)
}

message("Package installation scaffold completed.")
