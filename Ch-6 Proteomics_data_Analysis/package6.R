BiocManager::install("EnsDb.Hsapiens.v86")
BiocManager::install("MSnID")
BiocManager::install("mzR", force = TRUE)
install.packages("ncdf4")
BiocManager::install("mzR")  ########parser for netCDF, mzXML, mzData and mzML and mzIdentML files (mass spectrometry data)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("proteoQC")
BiocManager::install("rtracklayer",force = TRUE)
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("protViz")
BiocManager::install("RforProteomics")
