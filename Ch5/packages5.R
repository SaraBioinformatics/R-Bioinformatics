install.packages("ape")
install.packages("BiocManager")
BiocManager::install("dada2", force = TRUE)  ######Accurate, high-resolution sample inference from amplicon sequencing data
BiocManager::install("phyloseq")    ####Handling and analysis of high-throughput microbiome census data
install.packages("corrplot")
install.packages("cowplot")   ######Streamlined plot theme and plot annotations for ggplot2
install.packages("dplyr")
install.packages("kmer")
installed.packages("magrittr") ###
install.packages("metacoder")
install.packages("RColorBrewer")
install.packages("vegan")
install.packages("igraph")
install.packages("NetData")
remotes::install_github("wilkelab/cowplot")
library("cowplot")
library(ggplot2)
