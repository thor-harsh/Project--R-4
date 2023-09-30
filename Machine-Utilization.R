# You have been supplied one month worth of data for all of their machines. The
# dataset shows what percentage of capacity for each machine was idle (unused) in any
# given hour. You are required to deliver an R list with the following components:

  # Character: Machine name
  # Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
  # Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
  # Vector: All hours where utilisation is unknown (NA’s)
  # Dataframe: For this machine
  # Plot: For all machines


getwd()

util<-read.csv("P3-Machine-Utilization.csv")
util
head(util)
str(util)
summary(util)

util$Utilization<-1-util$Percent.Idle
head(util,12)


#Handling Date-Times in R
?POSIXct

util$Posixtime<-as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M")
summary(util)


#IP: rearrange columns in df:
head(util)
util$Timestamp<-NULL
util<-util[,c(4,1,2,3)]
head(util,12)



summary(util)
RL1<-util[util$Machine=="RL1",]
summary(RL1)

RL1$Machine<-factor(RL1$Machine)
summary(RL1)

# Character: Machine name
# Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
# Logical: Has utilisation ever fallen below 90%? TRUE / FALSE



util_stats_R1<-c(min(RL1$Utilization,na.rm = T),
                 mean(RL1$Utilization,na.rm=T),
                 max(RL1$Utilization,na.rm=T))
util_stats_R1


util_under_90_flag<-length(which(RL1$Utilization<0.9))>0
util_under_90_flag

list_rl1<-list("RL1",'util_stats_R1','util_under_90_flag')
list_rl1


#Naming components of a list
list_rl1
names(list_rl1)



#Another way to name components of list just like dataframe
rm(list_rl1)

list_rl1<-list(Machine="RL1",Stats=util_stats_R1,
               LawThreshold=util_under_90_flag)
list_rl1



#Extracting components of a list
#three ways:
#[]-will always return a list
#[[]]-will always return an actual object
#$- same as [[]] but prettier

list_rl1

list_rl1[1]
list_rl1[[1]]
list_rl1$Machine


list_rl1[2]
typeof(list_rl1[2])
list_rl1[[2]]
typeof(list_rl1[[2]])
list_rl1$Stats
typeof(list_rl1$Stats)


list_rl1[[2]][3]
list_rl1$Stats[3]


list_rl1[3]
list_rl1[[3]]
list_rl1$LawThreshold




#Adding and deleting list components
list_rl1[4]<-"New Information"
list_rl1


list_rl1$UnknownHours<-RL1[is.na(RL1$Utilization),"Posixtime"]
list_rl1


#Remove a component.Using the null method
list_rl1[4]<-NULL
list_rl1[4]

#Add another component
list_rl1$data<-RL1
list_rl1

summary(list_rl1)

str(list_rl1)


#Subsetting a list
list_rl1
list_rl1$UnknownHours[1]
list_rl1[[4]][1]


sublist_list_rl1<-list_rl1[c("Machine","Stats")]
sublist_list_rl1
sublist_list_rl1[[2]][2]


#Double Square Brackets are not for subsetting
#They are for accessing the single element/component of the list

list_rl1[[1:3]]
list_rl1[[1]]


#Building a time series plot
library(ggplot2)
p<-ggplot(data=util)
p+geom_line(aes(x=Posixtime,y=Utilization,colour=Machine),size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.9,colour='Gray',size=1.2,linetype=3)


myplot<-
 
p+geom_line(aes(x=Posixtime,y=Utilization,colour=Machine),size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.9,colour='Gray',size=1.2,linetype=3)



list_rl1$Plot<-myplot

list_rl1
summary(list_rl1)
str(list_rl1)
