getwd()
setwd("/home/bioinfo")

1 ###load data####

count_dataframe <- readr::read_tsv(file.path(getwd(), "Downloads", "R_data", "ch1", "modencodefly_count_table.txt" ))

genes <- count_dataframe[['gene']]
count_dataframe[['gene']] <- NULL

count_matrix <- as.matrix(count_dataframe)
rownames(count_matrix) <- genes

pheno_data <- readr::read_table2(file.path(getwd(), "Downloads", "R_data", "ch1", "modencodefly_phenodata.txt"))

2####specify experiment of interst#############

experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which( pheno_data[['stage']] %in% experiments_of_interest ) #gives the numeric indices of the above experiments in the matrix

3 ###from the grouping factor########

library(magrittr)
grouping <- pheno_data %>% 
  dplyr::filter(stage %in% experiments_of_interest )

4 ########from the subset of countdata#########


counts_of_interest <-  count_matrix[,columns_of_interest]

5 #####build the DESeq objects##########

library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = counts_of_interest,
                              colData = grouping,
                              design = ~ stage)
6##carry out the analysis#########

dds <- DESeq(dds)
7######extract the result
res <- results(dds, contrast=c("stage","L2Larvae","L1Larvae"))

8####load the eset data and convert into DESeqdataset############

library(SummarizedExperiment)
load(file.path(getwd(), "datasets/ch1/modencodefly_eset.RData"))
summ_exp <- makeSummarizedExperimentFromExpressionSet(modencodefly.eset)
ddsSE <- DESeqDataSet(summ_exp, design= ~ stage)

9#######carry out the analysis and extract the result#####
ddsSE <- DESeq(ddsSE)
resSE <- results(ddsSE, contrast=c("stage","L2Larvae","L1Larvae"))