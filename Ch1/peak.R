BiocManager::install(SummarizedExperiment())
library(SummarizedExperiment)
getwd()
arab_rse <- readRDS(file.path(getwd(), "R_cook", "arabidopsis_rse.RDS") )

make_tag <- function(grange_obj){ 
    paste0(
        grange_obj@seqnames, 
        ":", 
        grange_obj@ranges@start, 
        "-", 
        (grange_obj@ranges@start + grange_obj@ranges@width)
    ) 
}

counts <- assay(arab_rse)

if ( ! is.null(names(rowRanges(arab_rse))) ){
  rownames(counts) <- names(rowRanges(arab_rse))
} else {
  rownames(counts) <- make_tag(rowRanges(arab_rse))
}

head(counts)
