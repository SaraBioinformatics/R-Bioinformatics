library(ggplot2)
library(ggtree)
#### load library and get a phylo object of the newick tree
itol <- ape::read.tree(file.path(getwd(), "R_cook", "Ch4", "itol.nwk")) 
###make basic tree plot
ggtree(itol)
##make the circular tree
ggtree(itol, layout = "circular")
####rotate and invert the tree
ggtree(itol) + coord_flip() + scale_x_reverse()

####add the levels to tree tips
ggtree(itol) + geom_tiplab( color = "purple", size = 2)

######make a trip of color to annotate a particular clade
ggtree(itol, layout = "circular") + geom_strip(13,14, color="red", barsize = 1)
##########make a blob of color to highlight a particular clade
ggtree(itol, layout = "unrooted") + geom_hilight_encircle(node = 11, fill = "steelblue")



MRCA(itol, tip=c("Photorhabdus_luminescens", "Blochmannia_floridanus"))
 
