#1

# sets the working directory
# setwd("/Users/gerardoperez/Documents")

# Reads file into R with row names in column 1, and names object into a csv file.
data_csv <- read.table("GacuRNAseq_Subset.csv", header=T, row.names=1, sep=",")
head(data_csv)
dim(data_csv)


# Reads file into R with row names in column 1, and names object into a tsv file.
data_txt <- read.table("GacuRNAseq_Subset.txt", header=T, row.names=1, sep="\t")
head(data_txt)
dim(data_txt)
#same size

#2
# function used to get the object type.
class(data_txt)
#data_txt is data.frame object.

#3
#The explanatory variables: Population Treatment Sex

# function unique to get no repeats of factors (included an alternative)
unique(data_txt[,1])
unique(data_txt$Population)
# 2 factor levels: Boot RabbitSlough

unique(data_txt[,2])
unique(data_txt$Treatment)
# 2 factor levels: Conventional MonoAssoc

unique(data_txt[,3])
unique(data_txt$Sex)
# 2 factor levels: female male

class(data_txt[,1])
#factor

class(data_txt[,2])
#factor

class(data_txt[,3])
#factor

data_txt[1,]

#4
# Gets all the response variables columns
resp_var<-colnames(data_txt[,4:length(data_txt)])
length(resp_var)
# 182 response variables

# Prints out the type of vector for response variable columns
for (i in resp_var) {
  print(class(i))
}
# They are class character


# Prints out the type of vector for response variable in the columns
for (i in data_txt[,4:length(data_txt)]) {
  print(class(i))
}
# They are class numeric

# A way to grep response variables
#r_var<-colnames(data_txt)
#r_var<-grep("ENSGACG", r_var)




r_var=colnames(data_txt)
for (i in r_var) {
  print(class(i))
  #print(i)
}



#5

# Calculates the mean of gene in data frame
mean(data_txt$ENSGACG00000000003)
mean(data_txt$ENSGACG00000000004)

# Stores the first 2 genes from dataframe into a variable.
mean_2_col <- data_txt[,4:5]

# Computes 2 means of the first 2 genes at the same time.
lapply(mean_2_col, mean)

#6
# Stores the first 100 genes from dataframe into a variable.
expr_means_100<-data_txt[,4:104]

# Computes 100 means of the first 100 genes at the same time and stores the resuls to a variable.
expr_means_100<-lapply(data_txt[,4:104], mean)
print(expr_means_100)

# Fails to compute the mean for the first 100 variables.
mean(expr_means_100)

# Fails to compute, get the following message:

"

[1] NA
Warning message:
In mean.default(expr_means_100) :
  argument is not numeric or logical: returning NA
"

class(expr_means_100)
# The type of object is list


# Converts the object to numeric
as.numeric(expr_means_100)

# Computes the mean for the first 100 variables.
mean(as.numeric(expr_means_100))


expr_means_100<-data_txt[,4:104]

# Opens and names a pdf file.
pdf("hist_mean_exp.pdf")

# Creates a histogram with figure title and x-axis label.
hist(as.numeric(expr_means_100), main = "mean expression level for 100 genes", xlab="mean expression level")

# Ends outputing into pdf file
dev.off()

#7
pdf("hist_log_10_mean_exp.pdf")
hist(log(as.numeric(expr_means_100), base = 10), main = "mean expression level for 100 genes at log of 10", xlab="mean expression level at log of 10")
dev.off()

#8
# Takes the values as a subset that are less than 500 and store the result to a variable
expr_means <-subset(as.numeric(expr_means_100), as.numeric(expr_means_100)<500)

# An alternative
(as.numeric(expr_means_100)[as.numeric(expr_means_100)<500])

length(expr_means)
#94 genes in new subset

pdf(" hist_subset_exp.pdf")
hist(expr_means, main = "mean expression level less than 500 for 100 genes", xlab="mean expression level less than 500 for 100 genes", col = "steel blue")
dev.off()

#9
# Calculates the 2nd gene mean expression value for Boot Lake individuals, and Rabbit Slough separately
tapply(data_txt$ENSGACG00000000004, data_txt$Population, mean)
# Boot:9.8480121
# RabbitSlough:0.1809256 

# Calculates the mean of gene 2 in data frame
mean(data_txt$ENSGACG00000000004)
All_pop_mean<-5.014469

# Calculates the variance of gene 2 for individuals in data frame
tapply(data_txt$ENSGACG00000000004, data_txt$Population, var)
Boot_var<-31.406866
Rab_var<- 0.145544 

# Calculates the standard deviation for individual
(Boot_stdev<-sqrt(Boot_var))
#5.604183

# Calculates the standard deviation for individual
(Rab_stdev<-sqrt(Rab_var))
#0.3815023

# alternative way to get the standard deviation using tapply
tapply(data_txt$ENSGACG00000000004, data_txt$Population, sd)
# Boot:5.6041829
# RabbitSlough:0.3815023

# Calculates the variance of gene 2 for all individuals in data frame
All_pop_var<-var(data_txt$ENSGACG00000000004)

# Calculates the standard deviation for all individuals
(All_pop_stdev<-sqrt(All_pop_var))
#6.287977

# alternative way to get the standard deviation.
sd(data_txt$ENSGACG00000000004)
#6.287977

# Generates a sample of 1000 values from a normal distribution, using the mean and standard deviation calculated.
Boot_n_dist<-rnorm(1000, mean =9.8480121 , sd = 5.6041829)
Rab_n_dist<-rnorm(1000, mean =0.1809256 , sd = 0.3815023)
All_n_dist<-rnorm(1000, mean =5.014469 , sd = 6.287977)

pdf("Gene2_Pop_NormSamp.pdf")

#Creates figure with three panels (three rows and one column) 
par(mfrow=c(3,1))

hist(Boot_n_dist, main = "Boot Lake Distributions", col="blue", xlim=c(-20,30),ylim=c(0,300))
hist(Rab_n_dist, main = " Rabbit Lake Distribution", col="yellow", xlim=c(-20,30), ylim=c(0,300))
hist(All_n_dist, main = "Total Distribution", col="green", xlim=c(-20,30), ylim=c(0,300))
dev.off()

#10
# Creates a data frame which contains the factor columns and the expression values for the first 3 genes
data.frame(data_txt[,1:6])

# writes the dataframe to a csv file  called three_genes, 
write.table(data.frame(data_txt[,1:6]), "three_genes.csv", quote=F, row.names=T, sep=",")

# cat three_genes.csv

"
Population,Treatment,Sex,ENSGACG00000000003,ENSGACG00000000004,ENSGACG00000000006
BtCV1,Boot,Conventional,male,5.8000224,7.7333632,41.5668272
BtCV2,Boot,Conventional,male,21.331358,9.5991111,62.9275061.....

"

#11
# Creates a function that calculates the coefficient of variation (CV) for a specified numeric vector,
coefvar<-function(x) {
  cal_sd<- sd(x)
  cal_mean<-mean(x)
  (100*cal_sd/cal_mean)
}

# initialize a variable to null
All_CVs <- NULL

#for loop to generate a vector of CVs for all genes
for (i in data_txt[,4:185]) {
  
  #appends the results to a variable
  All_CVs<-append(All_CVs, coefvar(i))

}

pdf("CV_hist.pdf.pdf")
hist(All_CVs, main = "ALL_CVs", col="blue")
dev.off()

pdf("CV_boxplot.pdf")
boxplot(All_CVs, main = "ALL_CVs", col="Green")
dev.off()

#12

# initialize a variable to null
Boot_CVs <- NULL

#for loop to go through all genes, to calculate the CV for the different fish populations of Boot
for (i in subset(data_txt, Population=="Boot")[,4:185]) {
  
  #appends the results to a variable
  Boot_CVs<-append(Boot_CVs, coefvar(i))
}




# initialize a variable to null
Rab_CVs <- NULL

# for loop to go through all genes, to calculate the CV for the different fish populations of Rabbit Slough.
for (i in subset(data_txt, Population=="RabbitSlough")[,4:185]) {
  
  #appends the results to a variable
  Rab_CVs<-append(Rab_CVs, coefvar(i))
}







#13
pdf("Boot_CVs_vs_Rab_CVs_hist.pdf")
par(mfrow=c(2,1))
hist(Boot_CVs, main = "Boot_CVs", col="green", xlim=c(0,130),ylim=c(0,300))
hist(Rab_CVs, main = "RabbitSlough_CVs", col="red", xlim=c(0,130),ylim=c(0,300))
dev.off()
# They are different. Boot population is more evenly distrubeted where Rabbit slogh seems to be only 2 bars with one havine more frequency.

pdf("Boot_CVs_vs_Rab_CVs_boxplot.pdf")
par(mfrow=c(2,1))
boxplot(Boot_CVs, main = "Boot_CVs", col="green", ylim=c(0,350))
boxplot(Rab_CVs, main = "RabbitSlough_CVs", col="red", ylim=c(0,350))
dev.off()
# They are different. Boot population points are more condensed to median where Rabbit slough population points are more spread out in higher frequency.

#14
#CV adjusts for the size of mean and standardized the standard deviation. This helps to compare and normalize datasets where size can be a difference,
# such as comparing the sizes of mouse tails to Elephant tails.


#15

# Generates a sample of 10 values from a normal distribution, using 20 as a mean and standard deviation as 1. Stores result into a variable.
DietA<-rnorm(10, mean=20, sd=1)

# Generates a sample of 10 values from a normal distribution, using the mean times 1% of 20  and standard deviation as 1. Stores result into a variable.
DietB<-rnorm(10, mean=(20*0.01+20), sd=1)

#Creates boxplots
boxplot(DietA, ylim=c(17,25))
boxplot(DietB, ylim=c(17,25))




# Generates a sample of 1000 values from a normal distribution, using 20 as a mean and standard deviation as 1. Stores result into a variable.
DietA_1000<-rnorm(1000, mean=20, sd=1)


# Generates a sample of 1000 values from a normal distribution, using the mean times 1% of 20  and standard deviation as 1. Stores result into a variable.
DietB_1000<-rnorm(1000, mean=(20*0.01+20), sd=1)

#Creates boxplots
boxplot(DietA_1000, ylim=c(17,25))
boxplot(DietB_1000, ylim=c(17,25))

# Computes the T_test for two datasets
(T_test_10 <-t.test(DietA, DietB))
#p-value = 0. 0.6355

# Computes the T_test for two datasets
(T_test_1000 <-t.test(DietA_1000, DietB_1000))
#p-value=0.0002132

# Saves the two plots (one for the small sample sizes and one for the large sample sizes) as a single pdf file with 2 plots as two panels in the same figure.
pdf("DietA_DietB.pdf")
par(mfrow=c(1,2))
boxplot(DietA, DietB, ylim=c(17,25), names=c("Diet A","Diet B"), ylab="mass (grams)")
boxplot(DietA_1000, DietB_1000, ylim=c(17,25), names=c("Diet A","Diet B"), ylab="mass (grams)")
dev.off()

