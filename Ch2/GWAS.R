########Load in the libraries and get the VCF file
library(VariantAnnotation)
install.packages("rrBLUP")
library(rrBLUP)
set.seed(1234)

vcf_file <- file.path(getwd(), "R_cook", "Ch2", "small_sample.vcf")
vcf <- readVcf(vcf_file, "hg19")
#######extract the genotype, sample and marker position information
gts <- geno(vcf)$GT


samples <- samples(header(vcf))
markers <- rownames(gts)
chrom <- as.character(seqnames(rowRanges(vcf)))
pos <- as.numeric(start(rowRanges(vcf)))
#####create a custom function to convert  VCF genotypes into the convention used by the GWAS function
convert <- function(v){
  v <- gsub("0/0", 1, v)
  v <- gsub("0/1", 0, v)
  v <- gsub("1/0", 0, v)
  v <- gsub("1/1",-1, v)
  return(v)
}
###call the function and convert the result into a numeric matrix
gt_char<- apply(gts, convert, MARGIN = 2)

genotype_matrix <- matrix(as.numeric(gt_char), nrow(gt_char) )
colnames(genotype_matrix)<- samples
#######build the dataframe describing the variant
variant_info <- data.frame(marker = markers,
                           chrom = chrom,
                           pos = pos)
###build a combined variant/genotype dataframe
genotypes <-  cbind(variant_info, as.data.frame(genotype_matrix))
genotypes
#####build a phenotype dataframe
phenotypes <- data.frame(
  line = samples,
  score = rnorm(length(samples))
)

phenotypes
########  RUN GWAS
GWAS(phenotypes, genotypes,plot=FALSE)
