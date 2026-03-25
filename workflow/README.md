# Workflow Notes

This folder contains the canonical public notebook lineage for the MODA LUAD workflow.

## Canonical Notebooks
- `01_import_align_samples.Rmd`
- `02_qc_normalization.Rmd`
- `03_clinical_metadata_curation.Rmd`
- `04_single_omics_baseline.Rmd`
- `05_mofa_integration.Rmd`
- `06_diablo_supervised_integration.Rmd`
- `07_consensus_intersection_enrichment.Rmd`
- `08_scrna_signature_localization.Rmd`

## Important Scope Note
These notebooks were repackaged from a larger private workspace and cleaned for public presentation. They now depend on the path configuration defined in `config/paths.yml` or `config/paths.example.yml`.

## What This Folder Does Not Contain
- rendered HTML exports
- raw or processed data
- legacy duplicate notebook branches
- private one-off plotting dumps
