# Contributing

This repository is a curated public packaging of a larger analysis workspace. Contributions are welcome, but changes should preserve the public-facing principles of the repository:

- keep the repo lightweight and readable
- do not add raw or processed patient-level data
- do not reintroduce legacy dump folders or duplicate notebook lineages
- prefer documented, reproducible edits over one-off manual exports

For substantial changes:
1. Open an issue describing the scientific or reproducibility motivation.
2. Keep workflow changes inside `workflow/` and shared helpers inside `R/`.
3. Document any new external dependency in `env/` and `data/README.md`.
