source("R/project_paths.R")

repo_root <- find_moda_repo_root()
setwd(repo_root)

workflow_files <- c(
  "workflow/01_import_align_samples.Rmd",
  "workflow/02_qc_normalization.Rmd",
  "workflow/03_clinical_metadata_curation.Rmd",
  "workflow/04_single_omics_baseline.Rmd",
  "workflow/05_mofa_integration.Rmd",
  "workflow/06_diablo_supervised_integration.Rmd",
  "workflow/07_consensus_intersection_enrichment.Rmd",
  "workflow/08_scrna_signature_localization.Rmd"
)

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  install.packages("rmarkdown", repos = "https://cloud.r-project.org")
}

for (file in workflow_files) {
  message("Rendering: ", file)
  rmarkdown::render(file, knit_root_dir = repo_root)
}
