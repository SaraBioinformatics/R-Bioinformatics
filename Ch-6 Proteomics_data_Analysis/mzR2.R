###load library and import the source data files
library(mzR)
mzxml_file <- file.path(getwd(),  "Ch6", "threonine_i2_e35_pH_tree.mzXML")
mzdata <- openMSfile(mzxml_file)
###extract the header and peak data
header_info <- header(mzdata)
peak_data_list <- spectra(mzdata) #must be a list - if only one spectrum, remember to wrap it in list()
###write the data into a new formate file
writeMSData(peak_data_list, file.path(getwd(), "Ch6", "out.mz"), header = header_info, outformat = "mzml", rtime_seconds = TRUE ) #can import mzml mzxml and mzdata and export mzml and mzxml
