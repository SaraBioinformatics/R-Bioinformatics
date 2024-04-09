###Load the library and get counts in windows across the genome
BiocManager::install("csaw")

library(csaw)

whole_genome <- csaw::windowCounts( 
  file.path(getwd(), "R_cook", "Ch2", "hg17_snps.bam"),
  bin = TRUE,
  filter = 0,
  width = 100,
  param = csaw::readParam(
    minq = 20,
    dedup = TRUE,
    pe = "both"
  )
)
colnames(whole_genome) <- c("h17")
####Extract data from SummarizedExperiment
counts <- assay(whole_genome)[,1]
######work out a low count threshould and set windows with lower counts NA
min_count <- quantile(counts, 0.1)[[1]]
counts[counts < min_count] <- NA
#####Double the counts of the set of window in the middle -these will act as our high copy number region
n <- length(counts)

doubled_windows <- 10

left_pad <- floor( (n/2) - doubled_windows )
right_pad <- n - left_pad -doubled_windows
multiplier <- c(rep(1, left_pad ), rep(2,doubled_windows), rep(1, right_pad) )
counts <- counts * multiplier
###calculate the mean coverage and the ratio in each window to that mean coverage , and inspect the ratio vector with a plot
mean_cov <- mean(counts, na.rm=TRUE) 

ratio <- matrix(log2(counts / mean_cov), ncol = 1)
plot(ratio)
########build SummerizedExperiment with the new data and the row data of the old one
se <- SummarizedExperiment(assays=list(ratio), rowRanges= rowRanges(whole_genome), colData = c("CoverageRatio"))
######create a region of interest and extract coverage data from it
region_of_interest <- GRanges(
  seqnames = c("NC_000017.10"),
  IRanges(c(40700), width = c(1500) )
)

overlap_hits <- findOverlaps(region_of_interest, se)
data_in_region <- se[subjectHits(overlap_hits)]
assay(data_in_region)
