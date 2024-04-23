 n        ######## IDENTIFYING GENOMIC LOCI THAT MATCH PEPTIDES  ########

###load in the libraries and the data
library(MSnID)
library(dplyr)
library(Biostrings)

####extract the peptide sequence and save it as a fasta file
msnid <- MSnID() # create object
msnid <- read_mzIDs(msnid, file.path(getwd(), "Ch6", "PXD006247.mzXML.mzid")) # load result into object ! 
peptide_info <- as(msnid, "data.table") %>%
  filter(isDecoy == FALSE) %>%
  select(spectrumID, pepSeq, ) %>%
  mutate(fasta_id = paste0( spectrumID, ":", 1:length(spectrumID)) )

string_set <- AAStringSet(peptide_info$pepSeq )
names(string_set) <- peptide_info$fasta_id

writeXStringSet(string_set[1], file.path(getwd(), "Ch6", "peptides.fa")) #note we just do one peptide
###prepare the filenames for the BLAST 
input_seqs <- file.path(getwd(), "Ch6", "peptides.fa")
genome_seqs <- file.path(getwd(), "Ch6", "ecoli_genome.fasta")
output_blast <- file.path(getwd(), "Ch6", "out.blast")
###prepare the BLAST cammand
command <- paste0("tblastn -query ", input_seqs ,
                  " -subject ", genome_seqs,  
                  " -out ", output_blast,
                  " -word_size 2 -evalue 20000 -seg no -matrix PAM30 -comp_based_stats F -outfmt 6 -max_hsps 1"
)

# if searching eukaryotes, might want to allow gap extensions to account for introns.


#if tblastn not on R path - sometimes happens with conda installs
###run BLAST  as a background process
library(withr)
with_path("/home/bioinfo/miniconda3/bin", system(command, wait = TRUE) )
#system(command, wait = TRUE)
####convert BLAST into  GFF   and   GRange

results <- read.table(output_blast)

blast_to_gff <- function(blst_res){
  blst_res %>% 
    mutate(
      seqid = V2,
      source = rep("tblastn", length(V1)),
      type = rep(".", length(V1)),
      start = V9,
      end = V10,
      score = V3,
      strand = rep(".", length(V1)),
      phase = rep(".", length(V1)),
      attributes = paste("Name=",V1)
    ) %>%
    select( - starts_with("V") )
}

gff_df <- blast_to_gff(results)

## there's more
library(GenomicRanges)
granges<-makeGRangesFromDataFrame(gff_df)

