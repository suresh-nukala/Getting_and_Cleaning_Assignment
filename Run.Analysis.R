## installing packages
install.packages("dplyr")
library(dplyr)

## reading train data tables into R
x_train <- read.table("train/X_train.txt", header = FALSE, sep = "")
y_train <- read.table("train/y_train.txt", header = FALSE, sep = "")
subject_train <- read.table("train/subject_train.txt", header = FALSE, sep = "")
features <- read.table("features.txt", header = FALSE, sep = "")
#names(x_train)
#features[,2]

## mapping variables in features file into x_train file.
names(x_train) <- features[,2]

## reading test data tables into R
x_test <- read.table("test/X_test.txt", header = FALSE, sep = "")
y_test <- read.table("test/y_test.txt", header = FALSE, sep = "")
subject_test <- read.table("test/subject_test.txt", header = FALSE, sep = "")
names(x_test) <- features[,2]

## merging data tables
test_combined <- cbind(subject_test, x_test, y_test)
names(test_combined)
train_combined <- cbind(subject_train, x_train, y_train)

## combining train & test data sets
combined <- rbind(train_combined, test_combined)
names(combined)

## assining names to V1 column
names(combined)[1] <- "Volunteer_Id"
names(combined)[1]
names(combined)[563] <- "Activity_Id"
names(combined)[563]

names(combined)  <- make.names(names= names(combined), unique = TRUE, allow_ = TRUE)
names(combined)

## Making Tidy data set
tidy_combined <- select(combined,Volunteer_Id,Activity_Id, contains("mean"), contains("std"))
names(tidy_combined)

## Grouping the data set by Voluneert_ID & Activity_ID
Group_tidy_Combined_data <- group_by(tidy_combined, Volunteer_Id, Activity_Id )

## summary by mean calculation
summary <- summarise_each(Group_tidy_Combined_data,funs(mean))

## Writing Output file
write.table(summary, file = "Summarized.Data.txt", row.names = FALSE )
