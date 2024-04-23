library(phyloseq)
library("phyloseq"); packageVersion("phyloseq")
## import the QIIME . bam file
biom_file <- file.path(getwd(),  "Ch5", "rich_sparse_otu_table.biom")
qiime <- import_biom(biom_file)
###acess different of the phyloseq object
tax_table(qiime)
otu_table(qiime)
sample_data(qiime)

########import the mothur data files
getwd()
setwd("Downloads")
mothur <- import_mothur(
  mothur_list_file = file.path(getwd(), "R_data", "Ch5", "esophagus.fn.list"),
  mothur_group_file = file.path(getwd(), "R_data", "Ch5", "esophagus.good.groups"),
  mothur_tree_file = file.path(getwd(), "R_data", "Ch5", "esophagus.tree")
)
####output the otu objects in the phyloseq objects
otu_table(mothur)

