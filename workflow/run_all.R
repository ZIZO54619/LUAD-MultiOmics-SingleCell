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

missing_workflow_files <- workflow_files[!file.exists(workflow_files)]
if (length(missing_workflow_files)) {
  stop(
    "The following workflow files are missing:\n",
    paste0(" - ", missing_workflow_files, collapse = "\n"),
    "\nEnsure you are running from an intact repository checkout."
  )
}

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  install.packages("rmarkdown", repos = "https://cloud.r-project.org")
}

for (file in workflow_files) {
  message("Rendering: ", file)
  rmarkdown::render(file, knit_root_dir = repo_root)
}
