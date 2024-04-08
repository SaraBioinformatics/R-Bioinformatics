##BicConductor: following are the packages
install.packages("BiocManager")
library(BiocManager)
install.packages("RCurl")

BiocManager::install("GenomeInfoDb")
BiocManager::install("Biostrings")
BiocManager::install("GenomicRanges")
BiocManager::install("gmapR")
BiocManager::install("karyoploteR")

BiocManager::install("rtracklayer")###
BiocManager::install("rtracklayer", force = TRUE)

BiocManager::install("rtracklayer")
BiocManager::install("systemPipeR")
BiocManager::install("systemPipeR", force = TRUE)

BiocManager::install("SummarizedExperiment")##or
BiocManager::install("SummarizedExperiment", force = TRUE)

BiocManager::install("VariantAnnotation")##or
BiocManager::install("VariantAnnotation", force = TRUE)
BiocManager::install("VariantTools")
