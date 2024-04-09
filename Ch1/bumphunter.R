source("http://www.bioconductor.org/biocLite.R")
biocLite(c("Rsamtools")
BiocManager::install("Rsamtools", force = TRUE)

bamPath <- system.file("R_cook", "windows.bam", package="Rsamtools")


library(Rsamtools)
BiocManager::install("bumphunter")
library(bumphunter)
getwd()
setwd("Downloads")

pileup_df <- Rsamtools::pileup(file.path(getwd(),"R_cook" , "windows.bam"))
clusters <- bumphunter::clusterMaker(pileup_df$seqnames, pileup_df$pos, maxGap = 100) 
table(clusters)

bumphunter::regionFinder(pileup_df$count, pileup_df$seqnames, pileup_df$pos, clusters, cutoff=1)