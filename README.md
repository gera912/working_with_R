# Bi623 (Summer 2019) Homework 2
# (Due Thursday 08/22/2019 at midnight)
# Working with R

Directions: Perform the tasks below using the R Studio Interface. Address the following questions by writing R code. Type any “verbal” answers in human-readable format, as commented lines within your R script. Submit your .R script file, and submit any plots (labeled by question number) as a single, concatenated .pdf file. Make sure your R code is readable and commented well. Each numbered section is worth 5 points, for a total of 75 points.

# Reading in files
1. Read the GacuRNAseq_Subset.csv file into R, specifying that there are row names in column 1, and name the object data_csv. head() data_csv and print the dimensions of the dataset using dim().
- Now read in the GacuRNAseq_Subset.txt file, specifying row names, and name the object data_txt. head() data_txt and print the dimensions to confirm the two datasets are equivalent.
(For parts 2-10 below, work exclusively with data_txt)
2. What type of object is data_txt?
- (hint: look into the class() function).

# Understanding elements of experimental data

3. Name all of the “explanatory variables” we have in this experiment. (hint: look at the column names in data_text)
- We often call discreet explanatory variables “factors,” and we expect each factor in an experiment to have several “factor levels.”

- Print out the factor levels for the factors you identified above. How many factor levels are there for each factor? (hint: look into the unique() function and use indexing to get the levels for each of the factor columns)

- What type of vector are the factor columns? (use class() and index as above)

- If they weren’t already defined as factors, you should do that: e.g. data_txt$Sex <- as.factor(data_txt$Sex)

4. How many “response variables” do we have in this dataset? (remember, it’s a gene expression data set)
- What type of vector are the response variable columns? (use class() in a for loop to iterate over all response variable columns)
# Summary statistics and distributions

5. Calculate the mean of all expression values for the first gene.
- Now calculate the mean of all expression values for the second gene.

- Try calculating means for for the first and second gene in a single expression. (try mean(data_txt[,4:5]))

- You’ll notice that it doesn’t work! Instead, use the lapply() function to accomplish this. If you want to know more about lapply(), type help(lapply).

6. Using lapply() again, calculate the mean expression level for the first 100 genes, and store them as an object called expr_means_100.
- What happens when you try to take the mean of expr_means_100?

- Better check what type of object expr_means_100 is.

- Before you can work with these means as a vector, you’ll have to do something to convert them from their current type (hint: it has to do with lists)

- Now, plot a frequency distribution for these 100 values, but title the plot “mean expression level for 100 genes” and label the x axis “mean expression level”

  - (learn how to use the hist() function)
  - Export your plot as a .pdf (call it hist_mean_exp.pdf)

7. To make a more meaningful histogram, plot the log (base 10) of the means instead, and relabel the title and x-axis appropriately.
- Export your plot as a .pdf (call it hist_logmean_exp.pdf)
8. Another way to make a more meaningful histogram is to subset the data to discard the genes with large expression values.
- Subset your expr_means so that you only take means < 500 and plot the new histogram. (look into the subset() function to accomplish this)

- How many genes are in your new subset?

- Label the title and axes appropriately, color your histogram “steel blue”, and export your plot as a .pdf (call it hist_subset_exp.pdf)

9. Calculate the mean expression value (for the 2nd gene in the dataset), for Boot Lake individuals, and Rabbit Slough individuals separately. (hint: learn about tapply())
- Also calculate the mean for all individuals, and also calculate sample standard deviations for all three sets. (hint: how is the standard deviation related to the variance?)

- Generate a sample of 1000 values from a normal distribution, using the mean and standard deviation calculated from the Rabbit Slough individuals.

- Now do the same based on the mean and standard deviation from the Boot individuals.

- Also do the same based on the mean and standard deviation from all individuals.

- Generate a figure with three panels (three rows and one column) that includes histogram plots from your three samples. Make sure your axis ranges are the same for all three (ylim and xlim arguments). Title each plot appropriately (Boot Lake Distribution, Rabbit Lake Distribution, Total Distribution), use different colors for the histograms, and save as a .pdf called Gene2_Pop_NormSamp.pdf.

# Writing simple functions, boxplots, and statistical vs. practical significance

10. Define a new dataframe called three_genes, which contains the factor columns and the expression values for the first 3 genes.
- Write this to a .csv file and save it to your computer as three_genes.csv. Verify that the file looks correct by cat-ing it in a Unix terminal.

11. Write a function (called coefvar()) to calculate the coefficient of variation (CV) for a specified numeric vector, then write a for loop to generate a vector of CVs for all genes. When you are generating something like a vector, using a for loop, make sure to initialize or pre-allocate that object first. e.g. All_CVs <- NULL.
-(A common way to express the CV is the standard deviation as a percentage of the mean).
- Plot a histogram, then a boxplot of the distribution of CVs, and save these as .pdfs called CV_hist.pdf and CV_boxplot.pdf.

12. Finally, use your new coefvar() function, looping through all genes, to calculate the CV for the different fish populations (Boot and Rabbit Slough) separately. Write two separate loops, as above, to generate CV vectors, one for Boot and one for Rabbit Slough. This time, however, use the subset() function to define the vectors being iterated over, so that you’re only considering observations that are either Boot or Rabbit Slough.

13. How do the two CV distributions compare (look at the two distributions using hist() and boxplot())?

14. Think about how the coefficient of variation is calculated. Why might the CV be a better measure than the standard deviation when comparing two different variables?

15. Reproduce the boxplots I showed in lecture (don’t worry about formatting them in exactly the same way) to illustrate statistical vs. practical significance (maybe you already did this during lecture?).

- The following functions will help: rnorm(), data.frame(), colnames(), c(), cbind(), rep(), and t.test().

- Save the two plots (one for the small sample sizes and one for the large sample sizes) as a single .pdf. Render the 2 plots as two panels in the same figure.

- Optional (if you have time). Play around with different means, effect sizes, and sample sizes to examine the effect on hypothesis test results.
