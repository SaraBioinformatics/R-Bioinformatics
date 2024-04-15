######## reading writing tree formats with ape and treeio can be executed usisng the following steps
###load the ape library and trees
library(ape)
getwd()
setwd("Downloads")
newick <-ape::read.tree(file.path(getwd(), "R_cook", "Ch4", "mammal_tree.nwk"))
nexus <-ape::read.nexus(file.path(getwd(), "R_cook", "Ch4", "mammal_tree.nexus"))

##### load treeio library and load beast/RAxML output 
library(treeio)
beast <- read.beast(file.path(getwd(), "R_cook", "Ch4", "beast_mcc.tree"))
raxml <- read.raxml(file.path(getwd(), "R_cook", "Ch4", "RAxML_bipartitionsBranchLabels.H3"))
#######check the object types that the different ftions return
class(newick)
class(nexus)
class(beast)
class(raxml)

beast_phylo <- treeio::as.phylo(beast)
newick_tidytree <- treeio::as.treedata(newick)


treeio::write.beast(newick_tidytree,file = "mammal_tree.beast")
ape::write.nexus(beast_phylo, file = "beast_mcc.nexus")

