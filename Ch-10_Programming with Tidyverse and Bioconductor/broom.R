####making base R objects tidy
###tidy and lm object
###
library(broom)

model <- lm(mpg ~ cyl + qsec, data = mtcars)
tidy(model) 
augment(model)
glance(model)
##### tidy a test object 
t_test_result <- t.test(x = rnorm(20), y = rnorm(20) )
tidy(t_test_result)
glance(t_test_result)
####the tidy ANOVA object
anova_result <- aov(Petal.Length ~ Species, data = iris)
tidy(anova_result)
post_hoc <- TukeyHSD(anova_result)
tidy(post_hoc)

##### tidy a bioconductor expressionset object

library(biobroom)
library(Biobase)
load(file.path(getwd(), "R_cook", "Ch1", "modencodefly_eset.RData") ) 
tidy(modencodefly.eset, addPheno = TRUE)
