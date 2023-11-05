# Load necessary libraries
library(caret)
library(e1071)
library(randomForest)
library(kernlab)
library(rpart)

# Load the Iris dataset (this dataset is included in R)
data(iris)

#Train the models
# Define train control
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

### LDA ----
set.seed(7)
iris_model_lda <- train(Species ~ ., data = iris,
                        method = "lda", trControl = train_control)
### CART ----
set.seed(7)
iris_model_cart <- train(Species ~ ., data = iris,
                         method = "rpart", trControl = train_control)

