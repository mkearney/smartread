
#' A smart function for reading data files
#'
#' Reads data based on file extension
#'
#' @param x Name of file to read.
#' @param ... Other args passed on to read-in function, see details for
#'   more info.
#' @details Here is the function logic \itemize{
#'   \item csv = readr::read_csv
#'   \item rds = readRDS
#'   \item rda|Rdata = load
#'   \item xlsx = openxlsx::read.xlsx
#'   \item sav = haven::read_sav
#'   \item dta = haven::read_dta
#'   \item tsv = read.delim
#'   \item fst = fst::read_fst
#'   \item dt|data.table = data.table::fred
#'   \item txt|table = read.table
#'   \item html = xml2::read_html
#'   \item xml = xml2::read_xml
#'   \item json = jsonlite::stream_in
#'   \item yaml = yaml::read_yaml
#' }
#' @examples
#' ## save congress data as .rds, .csv, and .rda files
#' saveRDS(congress, "congress.rds")
#' save(congress, file = "congress.rda")
#' write.csv(congress, "congress.csv", row.names = FALSE)
#'
#' ## now read and view each file
#' (c1 <- read_smart("congress.rds"))
#' (c2 <- read_smart("congress.csv"))
#' (c3 <- read_smart("congress.rda"))
#'
#' @return Info from file returned as R data object.
#' @export
read_smart <- function(x, ...) {
  if (grepl("\\.csv$", x)) {
    x <- suppressMessages(readr::read_csv(x, ...))
  } else if (grepl("\\.rds$", x, ignore.case = TRUE)) {
    x <- readRDS(x, ...)
  } else if (grepl("\\.rda$|\\.Rdata$", x, ignore.case = TRUE)) {
    x <- read_rda(x, ...)
  } else if (grepl("\\.xlsx$", x)) {
    x <- openxlsx::read.xlsx(x, ...)
  } else if (grepl("\\.sav$", x)) {
    x <- haven::read_sav(x, ...)
  } else if (grepl("\\.dta$", x)) {
    x <- haven::read_dta(x, ...)
  } else if (grepl("\\.fst$", x)) {
    x <- fst::read_fst(x, ...)
  } else if (grepl("\\.data\\.table$|\\.dt$", x)) {
    x <- data.table::fread(x, ...)
  } else if (grepl("\\.tsv", x)) {
    x <- read.delim(x, ...)
  } else if (grepl("\\.table$|\\.txt$", x)) {
    x <- tryCatch(read.table(x), error = function(e) safe_read(x),
      warning = function(w) safe_read(x))
  } else if (grepl("\\.html$", x)) {
    x <- xml2::read_html(x, ...)
  } else if (grepl("\\.xml$", x)) {
    x <- xml2::read_xml(x, ...)
  } else if (grepl("\\.yaml$", x)) {
    x <- yaml::read_yaml(x, ...)
  } else if (grepl("\\.json$", x)) {
    con <- file(x)
    x <- jsonlite::stream_in(con, ...)
    close(con)
  } else {
    x <- safe_read(x, ...)
  }
  if (is.data.frame(x)) {
    x <- tibble::as_tibble(x, validate = FALSE)
  }
  x
}

safe_read <- function(x, ...) {
  warning("file extension not recognized. using readr::read_lines()")
  readr::read_lines(x, ...)
}

#' A more normal way to read-in .rda data/
#'
#' Reads in .rda files like any other data file would (outputs an object, which you can name whatever you want)
#'
#' @inheritParams read_smart
#' @rdname read_smart
#' @export
read_rda <- function(x) {
  ## validate input
  stopifnot(is.character(x) && length(x) == 1L)
  ## load into new environment
  rda_env <- new.env()
  load(x, envir = rda_env)
  ## fetch from environment and return
  get(ls(envir = rda_env), envir = rda_env)
}
