#######import the required libraries
library(GenomicRanges)
showMethods(findOverlaps)
library(gmapR)
library(rtracklayer)
library(VariantAnnotation)
library(VariantTools)
getwd()
#########load the datasets
bam_folder <- file.path(getwd(), "Downloads", "R_cook", "Ch2")
bam_file <- file.path( bam_folder, "hg17_snps.bam")

fasta_file <- file.path(bam_folder,"chr17.83k.fa")
#######set up genome object and the parameter
fa <- rtracklayer::FastaFile(fasta_file)

genome <- gmapR::GmapGenome(fa, create=TRUE)


qual_params <- TallyVariantsParam(
  genome = genome,
  minimum_mapq = 20)


var_params <- VariantCallingFilters(read.count = 19,
                                    p.lower = 0.01
)
#########called the variants

BiocManager::install("GenomicRanges")
BiocManager::install("GenomicRanges", force = TRUE)

called_variants <- callVariants(bam_folder, qual_params, 
                                calling.filters = var_params
)

head(called_variants)

VariantAnnotation::sampleNames(called_variants) <- "sample_name"
vcf <- VariantAnnotation::asVCF(called_variants)
VariantAnnotation::writeVcf(vcf, "hg17.vcf")
#######Now we move on to annotation and load in the feature position information from a gff or .bed
get_annotated_regions_from_gff <- function(file_name) {
  gff <- rtracklayer::import.gff(file_name) 
  as(gff, "GRanges")
}

get_annotated_regions_from_bed <- function(file_name){
  bed <- rtracklayer::import.bed(file_name)
  as(bed, "GRanges")
}

genes <- get_annotated_regions_from_gff(file.path( bam_folder, "chr17.83k.gff3"))

overlaps <- GenomicRanges::findOverlaps(called_variants, genes)
overlaps
genes[subjectHits(overlaps)]

