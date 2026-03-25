# Data Access and Provenance

This public repository does not redistribute the original patient-level datasets used in the private MODA workspace.

## Not Included in This Repository
- Raw CPTAC/ICPC LUAD omics files
- Raw clinical metadata table
- Processed and scaled per-sample omics matrices
- Single-cell Seurat object or cell-level matrices
- Full trained MOFA and DIABLO model binaries

## Expected External Assets
- Bulk omics raw files matching the original naming conventions used by the workflow
- Processed data directory produced by the private workspace or regenerated locally
- MOFA RNA gene-list directory used by the consensus notebook
- Single-cell `.rds` object for the scRNA localization notebook

## How to Configure Local Data
1. Copy `config/paths.example.yml` to `config/paths.yml`.
2. Point the fields to your local data locations.
3. Keep those private paths out of version control.

## Public Manifests
The `data/manifests/` folder contains only non-sensitive summary files:
- file-level cohort summary
- pairwise overlap counts
- combination overlap counts
- aggregate sample counts by layer

Do not add sample-level identifiers or patient-level matrices to this repository without verifying redistribution rights.
