######load the libraries and sequence
library(Biostrings)
library(ggplot2)
library(dotplot)
seqs <- readAAStringSet(file.path(getwd(), "R_cook", "Ch4", "bhlh.fa"))
####make basic dotplot
dotPlotg(as.character(seqs[[1]]), as.character(seqs[[2]] ))

#####change the dot plot and  apply tyhe ggplot2 themes and labels
dotPlotg(as.character(seqs[[1]]), as.character(seqs[[2]] ), wsize=7, wstep=5, nmatch=4) + theme_bw() + labs(x=names(seqs)[1], y=names(seqs)[2] )
########make the function that wuill create a dot plot from sequences provided and the sequence index
make_dot_plot <- function(i=1, j=1, seqs = NULL){
  
  seqi <- as.character(seqs[[i]])
  seqj <- as.character(seqs[[j]])
  namei <- names(seqs)[i]
  namej <- names(seqs)[j]
  return( dotPlotg(seqi, seqj ) + theme_bw() + labs(x=namei, y=namej) )
}
#########sequence up data structures to run the functions
combinations <- expand.grid(1:length(seqs),1:length(seqs))
plots <- vector("list", nrow(combinations) )
####run the fuction on all the possible combinations of pairs of sequences 
for (r in 1:nrow(combinations)){
  
  i <- combinations[r,]$Var1[[1]]
  j <- combinations[r,]$Var2[[1]]
  plots[[r]] <- make_dot_plot(i,j, seqs)
}
###plot the grid  of plots
cowplot::plot_grid(plotlist = plots)

