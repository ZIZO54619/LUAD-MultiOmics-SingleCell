source("R/project_paths.R")

moda_message <- function(...) {
  cat(sprintf("[%s] ", format(Sys.time(), "%Y-%m-%d %H:%M:%S")), sprintf(...), "\n")
}

ensure_dir <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
  }
  invisible(path)
}

assert_external_path <- function(path, label) {
  if (!nzchar(path) || !file.exists(path)) {
    stop(
      label, " was not found. Update config/paths.yml or config/paths.example.yml ",
      "with a valid local path before running this workflow."
    )
  }
  invisible(path)
}
