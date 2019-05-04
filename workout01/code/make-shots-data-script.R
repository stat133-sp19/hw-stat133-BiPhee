#title : R scirpt for making shots-data
#description : This script is R codes that have been used for making shots-data by combining data of 5 Golden States Warriers players.
#input : "../data/andre-iguodala.csv", "../data/draymond-green.csv", "../data/kevin-durant.csv", "../data/klay-thompson.csv","/data/stephen-curry.csv" all of data can be found from github repo "https://github.com/ucb-stat133/stat133-hws"
#output : summary of iguodala, green, durant, thompson, curry data and combined data frame of those five.
  
getwd()
setwd("/Users/junghun/desktop/stat133/workout01/data")
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <-read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)

iguodala$name <- rep("Andre Iguodala", nrow(iguodala))
green$name <- rep("Draymond Green", nrow(green))
durant$name <- rep("Kevin Durant", nrow(durant))
thompson$name <- rep("Klay Thompson", nrow(thompson))
curry$name <- rep("Stephen Curry", nrow(curry))

iguodala$shot_made_flag[iguodala$shot_made_flag=='n']<-'shot_no'
iguodala$shot_made_flag[iguodala$shot_made_flag=="y"]<-'shot_yes'
green$shot_made_flag[green$shot_made_flag=='n']<-'shot_no'
green$shot_made_flag[green$shot_made_flag=='y']<-'shot_yes'
durant$shot_made_flag[durant$shot_made_flag=='n']<-'shot_no'
durant$shot_made_flag[durant$shot_made_flag=='y']<-'shot_yes'
thompson$shot_made_flag[thompson$shot_made_flag=='n']<-'shot_no'
thompson$shot_made_flag[thompson$shot_made_flag=='y']<-'shot_yes'
curry$shot_made_flag[curry$shot_made_flag=='n']<-'shot_no'
curry$shot_made_flag[curry$shot_made_flag=='y']<-'shot_yes'

iguodala$minute<-12 * iguodala$period - iguodala$minutes_remaining
green$minute<-12 * green$period - green$minutes_remaining
durant$minute<-12 * durant$period - durant$minutes_remaining
thompson$minute<-12 * thompson$period - thompson$minutes_remaining
curry$minute<-12 * curry$period - curry$minutes_remaining

iguodala<-iguodala[,-1]
green<-green[,-1]
thompson<-thompson[,-1]
curry<-curry[,-1]

sink("../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()
sink("../output/draymond-green-summary.txt")
summary(green)
sink()
sink("../output/kevin-durant-summary.txt")
summary(durant)
sink()
sink("../output/klay-thompson-summary.txt")
summary(thompson)
sink()
sink("../output/stephen-curry-summary.txt")
summary(curry)
sink()

assembled_table<-rbind(iguodala,green,durant,thompson,curry)
write.csv(assembled_table, file = '../data/shots-data.csv')
write.csv(iguodala, file = '../data/andre-iguodala.csv')
write.csv(green, file = '../data/draymond-green.csv')
write.csv(thompson, file = '../data/klay-thompson.csv')
write.csv(curry, file='../data/stephen-curry.csv')
sink('../output/shots-data-summary.txt')
summary(assembled_table)
sink()
