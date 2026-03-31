find_moda_repo_root <- function(start = getwd()) {
  current <- normalizePath(start, winslash = "/", mustWork = FALSE)
  repeat {
    has_structure <-
      dir.exists(file.path(current, "workflow")) &&
      dir.exists(file.path(current, "config")) &&
      file.exists(file.path(current, "README.md"))
    if (has_structure) {
      return(current)
    }
    parent <- dirname(current)
    if (identical(parent, current)) {
      stop(
        "Could not locate the MODA repository root. ",
        "Run notebooks from the repository root or via workflow/run_all.R."
      )
    }
    current <- parent
  }
}

read_simple_yaml <- function(path) {
  if (!file.exists(path)) {
    return(list())
  }

  lines <- readLines(path, warn = FALSE)
  lines <- trimws(lines)
  lines <- lines[lines != ""]
  lines <- lines[!startsWith(lines, "#")]
  if (!length(lines)) {
    return(list())
  }

  out <- list()
  for (line in lines) {
    parts <- strsplit(line, ":", fixed = TRUE)[[1]]
    if (length(parts) < 2) {
      next
    }
    key <- trimws(parts[1])
    value <- trimws(paste(parts[-1], collapse = ":"))
    value <- gsub('^"|"$', "", value)
    value <- gsub("^'|'$", "", value)
    if (nzchar(key)) {
      out[[key]] <- value
    }
  }
  out
}

is_absolute_path <- function(path) {
  if (!nzchar(path)) {
    return(FALSE)
  }
  grepl("^([A-Za-z]:[\\/]|/|~)", path)
}

resolve_repo_relative_path <- function(path, repo_root) {
  if (!nzchar(path) || is_absolute_path(path)) {
    return(path)
  }
  file.path(repo_root, path)
}

load_moda_paths <- function(config_path = NULL) {
  repo_root <- find_moda_repo_root()
  if (is.null(config_path)) {
    candidate <- file.path(repo_root, "config", "paths.yml")
    if (!file.exists(candidate)) {
      candidate <- file.path(repo_root, "config", "paths.example.yml")
    }
    config_path <- candidate
  }

  config <- read_simple_yaml(config_path)
  defaults <- list(
    external_project_dir = "",
    external_raw_dir = "",
    external_processed_dir = "",
    external_results_dir = "",
    external_scRNA_object = "",
    external_mofa_gene_lists_dir = "",
    public_signature_file = file.path(repo_root, "results", "signatures", "intersection_rna_factor1_genes.txt")
  )

  keys <- union(names(defaults), names(config))
  merged <- setNames(vector("list", length(keys)), keys)
  for (key in keys) {
    merged[[key]] <- if (!is.null(config[[key]]) && nzchar(config[[key]])) config[[key]] else defaults[[key]]
  }

  path_like_keys <- c(
    "external_project_dir",
    "external_raw_dir",
    "external_processed_dir",
    "external_results_dir",
    "external_scRNA_object",
    "external_mofa_gene_lists_dir",
    "public_signature_file"
  )
  for (key in intersect(path_like_keys, names(merged))) {
    merged[[key]] <- resolve_repo_relative_path(merged[[key]], repo_root)
  }

  if (!nzchar(merged$external_raw_dir) && nzchar(merged$external_project_dir)) {
    merged$external_raw_dir <- file.path(merged$external_project_dir, "data", "raw")
  }
  if (!nzchar(merged$external_processed_dir) && nzchar(merged$external_project_dir)) {
    merged$external_processed_dir <- file.path(merged$external_project_dir, "data", "processed")
  }
  if (!nzchar(merged$external_results_dir) && nzchar(merged$external_project_dir)) {
    merged$external_results_dir <- file.path(merged$external_project_dir, "results")
  }

  merged$repo_root <- repo_root
  merged$workflow_dir <- file.path(repo_root, "workflow")
  merged$config_dir <- file.path(repo_root, "config")
  merged$results_dir <- file.path(repo_root, "results")
  merged$docs_dir <- file.path(repo_root, "docs")
  merged$data_dir <- file.path(repo_root, "data")
  merged
}
