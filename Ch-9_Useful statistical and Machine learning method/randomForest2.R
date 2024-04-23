#####identifying the most important variables in data with random forest

###prepare training and test data
library(randomForest)


train_rows <- sample(nrow(iris), 0.8 * nrow(iris), replace = FALSE)

train_set <- iris[train_rows, ]
test_set <- iris[-train_rows, ]
###train the model and create the importance plot
model <- randomForest(Species ~ . , data = train_set, mtry = 2, importance = TRUE) #optimise mtry
varImpPlot(model)
