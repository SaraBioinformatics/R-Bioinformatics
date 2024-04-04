BiocManager::install("sva")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("sva")

library(sva)
##########load data###########

arab <- readRDS(file.path(getwd(), "R_cook", "arabidopsis.RDS"))

### filter out rows with too few counts in some experiment#######
keep <- apply(arab, 1, function(x) { length(x[x>3])>=2 } )
arab_filtered <- arab[keep,]

######### create the initial design ###############
groups <- as.factor(rep(c("mock", "hrcc"), each=3))
### set up the test and null models and run sva ##################
test_model <- model.matrix(~groups)
null_model <- test_model[,1]

svar <- svaseq(arab_filtered, test_model, null_model, n.sv=1)

### extract surrogate variable to a new design for downstream use ######33
design <- cbind(test_model, svar$sv)
