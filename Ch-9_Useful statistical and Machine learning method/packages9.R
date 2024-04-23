####### CHAPTER 9 INSTALL PACKAGES
BiocManager::install("Biobase",force = TRUE)
install.packages("caret")
install.packages("class")
install.packages("dplyr")
install.packages("e1071")
install.packages("factoextra")
install.packages("fakeR")
install.packages("magrittR")
install.packages("randomForest")
install.packages("RColorBrewer")
install.packages("estimability")   ####Support for determining estimability of linear functions
install.packages("emmeans")
devtools::install_github("rvlenth/estimability", dependencies = TRUE)
setRepositories()


