# Environment Notes

This folder contains a portable environment scaffold for the public version of the MODA LUAD repository.

- `install.R` lists the CRAN and Bioconductor packages referenced by the workflow notebooks.
- `environment.yml` defines the Python environment needed for `mofapy2` and `reticulate`.
- `renv.lock` is a scaffold placeholder created outside an R runtime. Regenerate it from a real R session with `renv::init()` and `renv::snapshot()` before calling the repository fully reproducible.
