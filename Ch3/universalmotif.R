##first load the libraries and a motif of interest
library(universalmotif)
library(Biostrings)


getwd()
setwd("/Downloads")
motif <- read_matrix(file.path(getwd() , "R_cook", "Ch3","simple_motif.txt"))
view_motifs(motif)
#####then load the sequences to scan with the motif
sequences <- readDNAStringSet(file.path(getwd(), "R_cook", "Ch3", "promoters.fa"))
########perform a scan of the sequence
motif_hits <- scan_sequences(motif, sequences = sequences)
motif_hits
head(motif_hits)
#####calculate whether the motif is enriched in the sequences
motif_info <- enrich_motifs(motif, sequences, shuffle.k = 3, verbose = 0, RC = TRUE)
motif_info
####rum MEME TO FIND NOVEL MOTIFS
install.packages("sysfonts")



library(meme)
meme_path = "/home/meme"
meme_run <- read_meme(sequences, bin = meme_path, output = "meme_out", overwrite.dir = TRUE)

motifs <- read_meme("meme_out/meme.txt")
view_motifs(motifs)
