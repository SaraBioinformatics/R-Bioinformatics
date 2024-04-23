###predicting classes with randomForest
###prepare a training set from thhe iris
ibrary(randomForest)

train_rows <- sample(nrow(iris), 0.8 * nrow(iris), replace = FALSE)

train_set <- iris[train_rows, ]
test_set <- iris[-train_rows, ]
####build a model on the training data
model <- randomForest(Species ~ . , data = train_set, mtry = 2) #optimise mtry
model
###use the model to make predictions on the test data
test_set_predictions <- predict(model, test_set, type = "class")
caret::confusionMatrix(test_set_predictions,  test_set$Species)
