## ----include=FALSE------------------------------------------------------------------------------------------------
# Libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(caret)
library(matrixStats)


## -----------------------------------------------------------------------------------------------------------------
# Import data
# https://www.kaggle.com/ntnu-testimon/paysim1
data <- read_csv("Financial_Data.csv")

## -----------------------------------------------------------------------------------------------------------------
# Split the data into a set of 50% fraud and 50% not fraud.
set.seed(0)
size <- dim(data[data$isFraud == 1,])[1]
temp_df_fraud <- data[data$isFraud == 1,]
temp_df_not_fraud <- data[data$isFraud == 0,][sample(seq(1, size), size),]

# Join the splits
df <- full_join(temp_df_not_fraud, temp_df_fraud)
rm(temp_df_fraud, temp_df_not_fraud)


## -----------------------------------------------------------------------------------------------------------------
# Remove non numeric predictors
df_num <- df %>%
  select(-c(nameOrig, nameDest, type))
head(df_num)


## -----------------------------------------------------------------------------------------------------------------
# Create Train ans Test sets
set.seed(0)
test_index <- createDataPartition(df_num$isFraud, times = 1, p = 0.2, list = FALSE) # first create the indexes for the test set

# select our test set
test_x <- select(df_num, -isFraud)[test_index,]
test_y <- df_num$isFraud[test_index]

# select the reamining indexes for our train set
train_x <- select(df_num, -isFraud)[-test_index,]
train_y <- df_num$isFraud[-test_index]

# change de training data as factor because we will only have to values
train_y <- as.factor(train_y)


## -----------------------------------------------------------------------------------------------------------------
# Model K Means
predict_kmeans <- function(x, k) {
    centers <- k$centers    # extract cluster centers
    # calculate distance to cluster centers
    distances <- sapply(1:nrow(x), function(i){
                        apply(centers, 1, function(y) dist(rbind(x[i,], y)))
                 })
  max.col(-t(distances))  # select cluster with min distance to center
}
set.seed(0)
k <- kmeans(train_x, centers = 2)
kmeans_preds <- ifelse(predict_kmeans(test_x, k) == 1, 0, 1)
# mean(kmeans_preds == test_y)


## ----warning=FALSE------------------------------------------------------------------------------------------------
# Add results to a df
results <- data_frame(method = "K means", accuracy = mean(kmeans_preds == test_y)) # save the results in the data frame


## ----warning=FALSE------------------------------------------------------------------------------------------------
# Model GLM
set.seed(0)
# Train the model
train_glm <- train(train_x, train_y,
                     method = "glm")

# Predict for the test set
glm_preds <- predict(train_glm, test_x)
# mean(glm_preds == test_y)


## -----------------------------------------------------------------------------------------------------------------
# Add results to a df
results <- bind_rows(results, # add accuracy to the df
                          data_frame(method="Logistic regression",
                                     accuracy = mean(glm_preds == test_y)))


## ----warning=FALSE------------------------------------------------------------------------------------------------
# Model LDA
set.seed(0)
# Train the model
train_lda <- train(train_x, train_y,
                     method = "lda")

# Predict for the test set
lda_preds <- predict(train_lda, test_x)
# mean(lda_preds == test_y)


## -----------------------------------------------------------------------------------------------------------------
# Add results to a df
results <- bind_rows(results, # add accuracy to the df
                          data_frame(method="LDA",
                                     accuracy = mean(lda_preds == test_y)))


## ----warning=FALSE------------------------------------------------------------------------------------------------
# Model KNN
set.seed(0)
# Train the model
train_knn <- train(train_x, train_y,
                     method = "knn",
                     tuneGrid = data.frame(k = seq(1.95, 2, 0.01)))
# Predict for the test set
knn_preds <- predict(train_knn, test_x)
# mean(knn_preds == test_y)
# train_knn$bestTune %>% pull()


## -----------------------------------------------------------------------------------------------------------------
# Add results to a df
results <- bind_rows(results, # add accuracy to the df
                          data_frame(method="KNN",
                                     accuracy = mean(knn_preds == test_y),
                                     tune = train_knn$bestTune %>% pull()))

## ----warning=FALSE------------------------------------------------------------------------------------------------
# Model Random Forest
set.seed(0)
# Train the model
train_rf <- train(train_x, train_y,
                  method = "rf",
                  tuneGrid = data.frame(mtry = seq(5.4,5.6,0.1)),
                  importance = TRUE)
# Predict for the test set
rf_preds <- predict(train_rf, test_x)
# mean(rf_preds == test_y)
# train_rf$bestTune %>% pull()


## -----------------------------------------------------------------------------------------------------------------
# Add results to a df
results <- bind_rows(results, # add accuracy to the df
                          data_frame(method="RF",
                                     accuracy = mean(rf_preds == test_y),
                                     tune = train_rf$bestTune %>% pull()))

## ----warning=FALSE------------------------------------------------------------------------------------------------
# Model Ensemble
models <- matrix(c(glm_preds, knn_preds, rf_preds), ncol = 3)

# Predict the mayority value.
ensemble_preds <- ifelse(rowMedians(models) == 1, 0, 1)
# add accuracy to the df
results <- bind_rows(results,
                          data_frame(method="Ensemble",
                                     accuracy = mean(ensemble_preds == test_y)))

## ----warning=FALSE------------------------------------------------------------------------------------------------
# Print Accuracies
results %>% knitr::kable()