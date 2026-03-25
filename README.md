# MODA: Integrative Multi-Omics Analysis of LUAD with Consensus Bulk-to-Single-Cell Interpretation

## Overview
This repository is a curated public packaging of a larger notebook-driven LUAD multi-omics analysis workspace. It focuses on the canonical workflow, selected final figures and tables, and transparent documentation rather than mirroring the full private analysis dump.

The workflow integrates matched bulk omics, clinical metadata, latent factor modeling with MOFA+, supervised multi-block learning with DIABLO, consensus signature overlap, and final localization of the dominant program in single-cell RNA-seq.

## Scientific Motivation
LUAD is biologically heterogeneous across molecular, clinical, and microenvironmental axes. The goal of this project is to identify robust biological programs that persist across complementary multi-omics integration strategies and can be localized to specific cell states using single-cell transcriptomics.

## Cohort and Omics Summary
- Core matched all-layer cohort: 369 samples
- Tumor samples: 186
- NAT samples: 183
- Core omics layers: RNA-seq, miRNA, proteome, phosphoproteome, acetylome, methylation
- Additional raw layer present in the original workspace but excluded from the public core workflow: ubiquitin
- Clinical context includes genotype, subtype, immune labels, stage-related variables, and survival-related fields

## Workflow Summary
1. `01_import_align_samples.Rmd`: import raw multi-omics tables and harmonize sample IDs.
2. `02_qc_normalization.Rmd`: perform QC, filtering, imputation, batch correction, and scaling.
3. `03_clinical_metadata_curation.Rmd`: curate clinical metadata and derive analysis-ready labels.
4. `04_single_omics_baseline.Rmd`: establish baseline pathway and tumor-versus-NAT biology.
5. `05_mofa_integration.Rmd`: learn latent multi-omics structure and extract top features.
6. `06_diablo_supervised_integration.Rmd`: build supervised cross-omics signatures.
7. `07_consensus_intersection_enrichment.Rmd`: intersect MOFA and DIABLO signatures and run enrichment.
8. `08_scrna_signature_localization.Rmd`: localize the final intersect signature in scRNA-seq.

## Methods Overview
- Multi-omics overlap-aware sample harmonization
- Layer-specific QC, missingness filtering, imputation, ComBat, and z-score scaling
- Clinical metadata cleaning and label curation
- Single-omics baseline pathway and differential analyses
- MOFA+ latent factor modeling via `MOFA2` and `reticulate`
- DIABLO supervised multi-block integration via `mixOmics`
- Consensus intersection and Reactome enrichment
- Seurat-based module scoring for scRNA localization

## Key Findings
- The files support a balanced matched 6-omics LUAD cohort and a coherent integrative analysis path.
- MOFA Factor 1 is the dominant tissue-state factor and is strongly associated with tumor-versus-NAT structure.
- Factor 1 loadings and enrichment support a vascular-endothelial microenvironment-associated program.
- DIABLO identifies a compact cross-omics feature set, with the strongest consensus overlap mapping to MOFA Factor 1 and DIABLO component 1.
- The final intersect signature localizes to endothelial or vascular-associated states in scRNA-seq.

## Main Finding
In the current workspace, the strongest reproducible signal is a vascular-endothelial bulk program that dominates the shared latent structure, overlaps between MOFA Factor 1 and DIABLO Component 1, and localizes to endothelial or vascular-associated cell states in single-cell RNA-seq. This should be presented as a robust microenvironment-associated program rather than a clinically validated biomarker or a pure EGFR-specific classifier.

## Limitations
- This public repository is a curated packaging, not a full re-release of the private workspace.
- Raw and processed patient-level data are not redistributed here.
- The original workflow was not fully reproducible from scratch and still requires path configuration plus environment reconstruction.
- The DIABLO outcome definition in the original analysis is confounded because NAT samples are labeled as `No.Mutation`, so component-level performance should not be overinterpreted as clean EGFR classification.
- Factor 3 remains biologically interesting, but it does not show the same level of MOFA-DIABLO consensus support as Factor 1 in the current files.

## Repository Structure
- `workflow/`: canonical analysis notebooks and a `run_all.R` driver.
- `R/`: shared path and workflow helper functions.
- `config/`: example runtime paths and lightweight project parameters.
- `env/`: R and Python environment scaffolding for public reproducibility.
- `data/`: data-access documentation and non-sensitive manifests only.
- `results/`: curated public-facing figures, summary tables, and final signature lists.
- `docs/`: graphical abstract and a portable HTML presentation.

## Reproducibility
This repository is more portable than the original workspace, but it is still not a true one-command reproduction package.

Before running:
1. Copy `config/paths.example.yml` to `config/paths.yml`.
2. Replace the placeholder paths with your local locations for the private raw data, processed data, MOFA gene lists, and scRNA object.
3. Install R packages listed in `env/install.R`.
4. Create the Python environment from `env/environment.yml`.
5. Regenerate `env/renv.lock` from a real R session before claiming full reproducibility.

Suggested execution:
```r
source("workflow/run_all.R")
```

## Data Availability
This repository does not redistribute:
- Raw CPTAC/ICPC omics matrices
- Processed per-sample omics matrices
- Raw clinical sample-level tables
- Full MOFA and DIABLO model binaries
- Seurat objects or cell-level scRNA matrices

These assets must be obtained from their original sources or local private storage and configured through `config/paths.yml`.

Expected external assets are documented in [data/README.md](data/README.md).

## Contact
Update this section before public release with your preferred institutional contact information.

- Maintainer: Abdulaziz
- Contact email: `replace-with-your-email@institution.edu`
- Optional links: LinkedIn, ORCID, Google Scholar, or lab page
