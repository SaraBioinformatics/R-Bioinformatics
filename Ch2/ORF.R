###predicting open reading frame (ORF)  in long reference sequences can be done using the following steps
###load the libraries and input genome
library(Biostrings)
library(systemPipeR)

dna_object <- readDNAStringSet(file.path(getwd(), "Downloads", "R_cook" ,"Ch2", "arabidopsis_chloroplast.fa"))
#####predict the ORF 
predicted_orfs <- predORF(dna_object, n = 'all', type = 'gr', mode='ORF', strand = 'both', longest_disjoint = TRUE)
predicted_orfs

########calculate the properties of the reference genome
bases <- c("A", "C", "T", "G")
raw_seq_string <- strsplit(as.character(dna_object), "")

seq_length <- width(dna_object[1])
counts <- lapply(bases, function(x) {sum(grepl(x, raw_seq_string))}  )
probs <- unlist(lapply(counts, function(base_count){signif(base_count / seq_length, 2) }))
#####create a function that finds the longest ORF  in a simulated genome
get_longest_orf_in_random_genome <- function(x,
                                             length = 1000, 
                                             probs = c(0.25, 0.25, 0.25, 0.25), 
                                             bases = c("A","C","T","G")){
  
  random_genome <- paste0(sample(bases, size = length, replace = TRUE, prob = probs), collapse = "")
  random_dna_object <- DNAStringSet(random_genome)
  names(random_dna_object) <- c("random_dna_string")
  orfs <- predORF(random_dna_object, n = 1, type = 'gr', mode='ORF', strand = 'both', longest_disjoint = TRUE)
  return(max(width(orfs)))
}
#######run the function on 10 simulated genomes
random_lengths <- unlist(lapply(1:10, get_longest_orf_in_random_genome, length = seq_length, probs = probs, bases = bases))
######get the length of the  logest random ORF
longest_random_orf <- max(random_lengths)
####Keep only predicted ORFs longer than the longest random ORF 
keep <- width(predicted_orfs) > longest_random_orf
orfs_to_keep <- predicted_orfs[keep]
orfs_to_keep

##writing to file
extracted_orfs <- BSgenome::getSeq(dna_object, orfs_to_keep) 
names(extracted_orfs) <- paste0("orf_", 1:length(orfs_to_keep))
writeXStringSet(extracted_orfs, "saved_orfs.fa")

