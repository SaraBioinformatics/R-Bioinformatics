###load the libraries
library(MSnID)
library(EnsDb.Hsapiens.v86)
library(rtracklayer)
getwd()
###create and populate the search file object
msnid <- MSnID() # create object
msnid <- read_mzIDs(msnid, file.path(getwd(),  "Ch6", "HeLa_180123_m43_r2_CAM.mzid.gz")) # load result into object ! 
###extracted rows containing useful hits and columnd containing useful information
real_hits <- msnid@psms[! msnid@psms$isDecoy, ]
required_info <- real_hits[, c("spectrumID", "pepSeq", "accession", "start", "end")]

####extract the uniprot IDs from the accession column
uniprot_ids <- unlist(lapply(strsplit(required_info$accession, "\\|"), function(x){x[2]}) )

uniprot_ids <- head(uniprot_ids[!is.na(uniprot_ids)])
####create a database connection and obtain genes matching our uniprot IDs.
edb <- EnsDb.Hsapiens.v86
genes_for_prots <- genes(edb, filter = UniprotFilter(uniprot_ids), columns = c("gene_name", "gene_seq_start", "gene_seq_end", "seq_name"))

####set up genome browser track
track <- GRangesForUCSCGenome("hg38", paste0("chr",seqnames(genes_for_prots)), ranges(genes_for_prots), strand(genes_for_prots), genes_for_prots$gene_name, genes_for_prots$uniprot_id)

####setup session browser and view
session <- browserSession("UCSC")
track(session, "my_peptides") <- track

first_peptide <- track[1] 
view <- browserView(session, first_peptide * -5, pack = "my_peptides")

