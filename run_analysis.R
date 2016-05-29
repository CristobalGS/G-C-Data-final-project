library(dplyr)
library(tidyr)

setwd("C:/Users/cfgal/OneDrive/Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/UCI HAR Dataset")
ac.lab <- read.table("activity_labels.txt")
features <- read.table("features.txt")
setwd("C:/Users/cfgal/OneDrive/Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test")
sub.test <- read.table("subject_test.txt")
x.test <- read.table("X_test.txt")
y.test <- read.table("y_test.txt")

setwd("C:/Users/cfgal/OneDrive/Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train")
sub.train <- read.table("subject_train.txt")
x.train <- read.table("X_train.txt")
y.train <- read.table("y_train.txt")

setwd("C:/Users/cfgal/OneDrive/Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project")

train <- cbind(sub.train, y.train, x.train)
features <- as.character(features[ , 2])
names(train) <- c("subject", "training", features)
train <- merge(ac.lab, train, by.x = "V1", by.y = "training", sort = FALSE)
train <- select(train, -V1)
names(train) <- c("training", "subject", features)

test <- cbind(sub.test, y.test, x.test)
names(test) <- c("subject", "training", features)
test <- merge(ac.lab, test, by.x = "V1", by.y = "training", sort = FALSE)
test <- select(test, -V1)
names(test) <- c("training", "subject", features)

x <- grepl("training|subject|mean()|std()", names(train))
stest <- test[ , x]
strain <- train[ , x]
y <- !grepl("Freq", names(stest))
stest <- stest[ , y]
strain <- strain[ , y]

stest <- arrange(stest, subject)
strain <- arrange(strain, subject)

col_idx <- grep("subject", names(stest))                  #moves subject column 
stest <- stest[ , c(col_idx, (1:ncol(stest))[-col_idx])]  #to first position
col_idx <- grep("subject", names(strain)) 
strain <- strain[ , c(col_idx, (1:ncol(strain))[-col_idx])]

set <- rep("train", time = 7352)
strain <- cbind(subject = strain[ , 1], set, strain[ , 2:68])
set <- rep("test", time = 2947)
stest <- cbind(subject = stest[ , 1], set, stest[ , 2:68])

data <- rbind(stest, strain)
data <- arrange(data, subject)
datanames <- names(data)
names(data) <- c(datanames[1:2], "activity", datanames[4:69])
datanames <- names(data)

final.data <- data.frame(1:180)

for(i in 4:69){
  
  x1 <- data.frame(tapply(data[ , i], data[ , c(1, 3)], mean))
  x2 <- gather(x1, activity, Var, LAYING:WALKING_UPSTAIRS)
  final.data <- cbind(final.data, x2[ , 2])
  
}

subste <- unique(stest[ , 1])                             #Add set variable accordingly
substr <- unique(strain[ , 1])
set.te <- paste(subste, "test", sep = ".")
set.tr <- paste(substr, "train", sep = ".")
set <- c(set.te, set.tr)
set <- data.frame(set)
set.sub <- separate(set, set, into = c("subject", "set"))
sub <- as.numeric(set.sub[ , 1])
set.sub <- data.frame(subject = sub, set = set.sub[ , 2])
set.sub <- arrange(set.sub, subject)


final.data <- final.data[ , 2:67]
final.data <- cbind(subject = rep(1:30, time = 6), set = rep(set.sub[ , 2], time = 6), activity = x2[ , 1], final.data)
names <- c(datanames[1:3], paste("mean.of.", datanames[4:69], sep = ""))
names(final.data) <- names

rm(ac.lab, stest, strain, sub.test, sub.train, test, train, x.test, x.train, y.test, y.train, col_idx, features, set, x, y, set.sub, x1, x2, i, set.te, set.tr, sub, subste, substr, datanames, names)
