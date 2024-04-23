##Load the library and the MS data
library(mzR)
library(protViz)

mzml_file <-  file.path(getwd(), "Ch6", "MM8.mzML")
ms <- openMSfile(mzml_file)
####extract the peaks and retention time from the spectrum
p <- peaks(ms,2)
###create a plot of theoratical time from versus observed ion masses
spec <- list(mZ = p[,1], intensity = p[,2])

m <- psm("PEPTIDESEQ", spec, plot=TRUE)
