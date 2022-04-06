# The purpuse of this code is to build a matching function using the Gale-Shapley algorithm
# It matchs two sides of selctions based on the preferences from two parties to reach the optimal results:
# The results reach a optimal situation where there will be no two parties who will both be better off by switching to a different party.
# This is commonly used in student & college dormitory and hostipal & patient assignment scenarios where there were two parties and perferences involved.
# There are two algorithms considered using two libraries.

#-------------------------Allow incomplete Ranking & Multiple to Multiple macthcing (peferred mothod)--------------------------------
# install RJava
# install portable 46 java.
# http://portableapps.com/apps/utilities/java_portable

# Locate the path to the jiva file 
Sys.setenv(JAVA_HOME='C:\\Users\\Downloads\\CommonFiles\\Java64')
library(rJava)
library("matchingMarkets")

# Step1 : Input the top 3 rankings for party a: associates and party b: managers
# The jth column contains associate j's rankings on descrenting order, e.g. Associate no.1's top choice is team 1, 2nd choice is team 2, and 3rd choice is team 3

# 5 assocites' top three team ranking starts from the top of column 
prefA <- matrix(c(1,1,3,1,2,
                  2,3,2,3,1,
                  3,2,1,2,3), nrow=3, ncol=5, byrow=TRUE)

prefM <- matrix(c(1,3,4,
                  2,1,1,
                  5,2,3), nrow=3, ncol=5, byrow=TRUE)

# Step 2: Input nslot: the # of spot under each team
# the first 2 team wants 2 associates nd the thrid them wants 1 associates 
res = hri(s.pref=prefA, c.prefs=prefM, nSlots=c(2,2,1))

# Matching Results
res$matchings[,c('college','student')]


#--------------------------------------Need complete rankings & multiple to multiple (secondary method)--------------------------------
# Allow to accept different number of positions 
# e.g. 8 manager, 10 associates 
# Team 1 and team 2 have sports of 2, and the rest has a spot of 1

# *User Note: It is assumed that it is better to be matched than not, when this algorithm needs to be run in the second time, people maye be matched with team they already been to previously 

# Example 1:
library("matchingR")
library('openxlsx')


#Read in Utilizations 
#Input number of people in party a: manager and party b: associates
M_Number = 8
A_Number = 10

# this has the utilizations/weights from party a: manages
prefM = read.xlsx("c/Users/Documents/R/Matching.xlsx", cols= c(1:M_Number+1), sheet = 'Sheet1')

# this has the utilizations/weights from party b: associates
prefA = read.xlsx("c/Users/Documents/R/Matching.xlsx", cols= c(1:M_Number+1), sheet = 'Sheet2')
prefM
prefA 

matching = galeShapley.collegeAdmissions(prefA, prefM, slot= c(2,2,1,1,1,1,1,1), studentOptimal = TRUE)
matching$matched.colleges 
