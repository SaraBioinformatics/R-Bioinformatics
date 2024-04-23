          #### Applying quality control filter to spectra ##########

###load the library and downloads the source data
library(proteoQC)

online_file <- "ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2017/11/PXD006247/CS_130530_ORBI_EMCP2156_b2469_narQ_DDM_AmH_X_5.mzXML"

mzxml_file <- file.path(getwd(), "Ch6", "PXD006247_mz.xml.gz" )
download.file(online_file, mzxml_file, "internal")

####create a design file
design_df <- data.frame(
  file = c(mzxml_file),
  sample = c(1),
  bioRep = c(1),
  techRep = c(1),
  fraction = c(1)
)

design_file <- file.path(getwd(), "Ch6", "design_file.txt")

write.table(design_df, file = design_file, quote = FALSE, row.names = FALSE)

###set up the QC pipeline and run the following cammands
qc <- msQCpipe(
  spectralist = design_file,
  fasta = file.path(getwd(),  "Ch6", "Escherichia_coli.pep.all.fa"),
  outdir = file.path(getwd(), "qc_result"),
  enzyme = 1, varmod = 2, fixmod =1,
  tol = 10, itol = 0.6, cpu = 2,
  mode = "identification"
)

