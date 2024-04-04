### set up a loading function ###########
get_annotated_regions_from_gff <- function(genes.gff) {
  gff <- rtracklayer::import.gff(genes.gff)
  as(gff, "GRanges")
}

get_annotated_regions_from_bed <- function(file_name){
  bed <- rtracklayer::import.bed(file_name)
  as(bed, "GRanges")
}


install.packages("tidyverse")
library("tidyverse")
install.packages("devtools")

BiocManager::install("dada2")
options(BioC_mirror = "http://bioconductor.org")
BiocManager::install("dada2", version = "3.14")
BiocManager::install("dada2")
BiocManager::install('Rccp')
library("dada2")

install.packages("path/to/dada2",
                 repos = NULL,
                 type = "source",
                 dependencies = c("Depends", "Suggests","Imports"))
library("ggplot2")
install.packages("BiocManager")
library(BiocManager)
BiocManager::version()
BiocManager::install(version = "3.18")

#get counts in windows across whole genome
whole_genome <- csaw::windowCounts( 
    file.path(getwd(), "Downloads", "R_cook", "windows.bam"),
    bin = TRUE,
    filter = 0,
    width = 500,
    param = csaw::readParam(
        minq = 20,
        dedup = TRUE,
        pe = "both"
    )
)
colnames(whole_genome) <- c("small_data")

#make a GRanges object of the annotated features
annotated_regions <- get_annotated_regions_from_gff(file.path(getwd(), "datasets", "ch1", "genes.gff"))


library(IRanges)
library(SummarizedExperiment)
#find the overlaps between the windows we made  
windows_in_genes <-IRanges::overlapsAny(
  SummarizedExperiment::rowRanges(whole_genome),
  annotated_regions
)

annotated_window_counts <- whole_genome[windows_in_genes,]
non_annotated_window_counts <- whole_genome[ ! windows_in_genes,]


assay(annotated_window_counts)
