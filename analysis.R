life=read.csv("C:/Users/hp/OneDrive/Desktop/Statisitcal Machine Learning/lifeexpetancy.csv", header= TRUE)
life <- life[, !(colnames(life) == "country")]
set.seed(49747)

#train <- life[life$Year == 2014, ]
#test <- life[life$Year == 2015, ]
train <- subset(life, Year == 2014)
test <- subset(life, Year == 2015)
test_life <- test$life_expectancy
train <- train[, !(colnames(train) == "Year")]
test <- test[, !(colnames(test) == "Year")]

install.packages('tree')
library(tree)
rtree <- tree(life_expectancy ~ ., data = train)
summary(rtree)
plot(rtree)
text(rtree, pretty = 0)
leaves <- length(unique(rtree$where))
cat("Number of leaves:", leaves, "\n")
deviance <- sum((train$life_expectancy - predict(rtree, train))^2)
cat("Deviance:", deviance, "\n")

yhat_train <- predict(rtree, train)
mse_train <- mean((train$life_expectancy - yhat_train)^2)
yhat_test <- predict(rtree, test)
mse_test <- mean((test_life - yhat_test)^2)
cat("Training MSE:", mse_train, "\n")
cat("Validation MSE:", mse_test, "\n")

cv_rtree <- cv.tree(rtree)
best_size <- cv_rtree$size[which.min(cv_rtree$dev)]
best_size
plot(cv_rtree$size, cv_rtree$dev, type = "b", main = "Deviance vs Tree Size")
abline(v = best_size, col = "red", lty = 2)

pruned_tree <- prune.tree(rtree, best = best_size)
plot(pruned_tree)
text(pruned_tree, pretty = 0)

new_obs <- data.frame(status = "Developing", adult_mortality = 100, infant_deaths = 50,
                      bmi = 50, gdp = 15000, population = 10000000)
life_pred <- predict(pruned_tree, new_obs)
cat("Predicted life expectancy for new observation:", life_pred, "\n")


# Check for missing values
missing_summary <- colSums(is.na(life))
print(missing_summary)
numeric_columns <- c("bmi", "gdp", "population")
# Impute missing values in numeric columns with their respective means in test and train data
for (col in numeric_columns) {
  if (any(is.na(train[[col]]))) {
    train[[col]][is.na(train[[col]])] <- mean(train[[col]], na.rm = TRUE)}}
for (col in numeric_columns) {
  if (any(is.na(test[[col]]))) {
    test[[col]][is.na(test[[col]])] <- mean(test[[col]], na.rm = TRUE)}}
#Bagging
bag_model <- randomForest(life_expectancy~., data = train,mtry=6,importance=TRUE)
# Bagging is special case of RF with m = p
bag_yhat <- predict(bag_model, test)
bag_mse <- mean((test_life - bag_yhat)^2)
#Random Forest
rf_model <- randomForest(life_expectancy ~ ., data = train, mtry = sqrt(6), 
                         ntree = 500, importance = TRUE)
rf_yhat <- predict(rf_model, test)
rf_mse <- mean((test_life - rf_yhat)^2)
cat("Bagging MSE:", bag_mse, "\n")
cat("Random Forest MSE:", rf_mse, "\n")
cat("Pruned/Unpruned Tree MSE:", mse_test, "\n")
# Variable importance for Bagging and Random Forest
importance(bag_model)
importance(rf_model)
# Predict life expectancy for the given specifications using Bagging and Random Forest
bag_pred <- predict(bag_model, new_obs)
rf_pred <- predict(rf_model, new_obs)
cat("Predicted life expectancy using Bagging:", bag_pred, "\n")
cat("Predicted life expectancy using Random Forest:", rf_pred, "\n")
#Describing effect of m
mtryx=seq(1,12,1)
mse=rep(0,12)
for (i in 1:12) {
  bag.m=randomForest(life_expectancy~., data =train,mtry=i,importance=TRUE)
  yhat.bag=predict(bag.m,test)
  mse[i]=mean((yhat.bag-test_life)^2)
}
plot(mtryx , mse, xaxt="n")
axis(1, at = seq(1, 12, by = 1), las=1)
lines(mtryx , mse, col = "blue")
mtryx[mse==min(mse)]
