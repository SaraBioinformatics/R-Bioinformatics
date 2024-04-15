###load the libraries 
library(ape)
library(adegraphics)
getwd()
setwd("Downloads")
install.packages("treespace")
library(treespace)
###load the tree files into a multiphylo object
treefiles <- list.files(file.path(getwd(), "R_cook", "Ch4", "gene_trees"),full.names = TRUE)
tree_list <- lapply(treefiles, read.tree)
class(tree_list) <- "multiPhylo"
####compute the kendall-colijn distance
comparisons <- treespace(tree_list, nf = 3)
###plot pairwise distance

adegraphics::table.image(comparisons$D, nclass=5)
#######plot PCA (Principle component analysis and cluster)
plotGroves(comparisons$pco, lab.show=TRUE, lab.cex=1.5)

groves <- findGroves(comparisons, nclust = 4)
plotGroves(groves)
