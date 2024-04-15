install.packages("ape") ###Analyses of Phylogenetics and Evolution(ape)
install.packages("BioManager")
BiocManager::install("Biostrings", force = TRUE)
BiocManager::install("biomaRt" , force = TRUE) ##biomaRt provides an interface to a growing collection of databases implementing the BioMart software suite ().
BiocManager::install("DECIPHER")
BiocManager::install("EnsDb.Rnorvegicus.v79") ###Ensembl based annotation package
 
BiocManager::install("kebabs") ###An R Package for Kernel-Based Analysis of Biological Sequences. 
BiocManager::install("msa") ###multiple sequence alignment algorithms ClustalW, ClustalOmega,
BiocManager::install("org.At.tair.db") ###Genome wide annotation for Arabidopsis, primarily based on mapping using TAIR identifiers


BiocManager::install("org.EcK12.eg.db")
##Genome wide annotation for E coli strain K12, primarily based on mapping using Entrez Gene identifiers
BiocManager::install("PFAM.db") ###Pfam is a manually curated collection of protein families available via the web and in flat file form
BiocManager::install("universalmotif")
install.packages("bio3d") ##Bio3D is an R package containing utilities for the analysis of protein structure, sequence and trajectory data.
install.packages("dplyr")
install.packages("e1071") ####e1071 is an R package that provides tools for performing support vector machine (SVM) classification and regression.
