# load packages to workspace
library(tidyr)
library(dplyr)

# 0: Load the data
titanic <- read.csv("titanic_original.csv")

# 1: Port of embarkation
##  check all unique elements in "embarked" for unexpected entries
unique(titanic$embarked)
##  besides expected characters (S, C, Q), "" elements are present
##  for all entries which are not S, C, or Q: set as S
titanic$embarked[(!(titanic$embarked %in% c("S", "C", "Q")))] <- "S"

#2: Age
##  check unique elements of "age"
unique(titanic$age)
##  besides numerical ages, NA entries are present
##  find all NA entries in "age" and replace with the average age
titanic$age[(is.na(titanic$age))] <- mean(titanic$age, na.rm = TRUE)

# 3: Lifeboat
##  check unique elements of "boat"
unique(titanic$boat)
##  besides boat numbers, "" entries are present
##  "boat" is a factor vector, so "" is one level
##  rename "" level to "none"
levels(titanic$boat)[1] <- "none"

# 4: Cabin
##  check unique elements of "cabin"
unique(titanic$cabin)
##  besides cabin numbers, "" elements are present
##  create a new column which indicates whether guest had assigned column
titanic <- mutate(titanic, has_cabin_number = (!(cabin == "")))

# Save output
write.csv(titanic, "titanic_clean.csv")