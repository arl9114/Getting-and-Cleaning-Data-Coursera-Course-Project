# Getting-and-Cleaning-Data-Coursera-Course-Project
##== IMPORTANT - PLEASE READ ==
There are a few steps that you need to do before you can run the script successfully and replicate the outcome:
1. Install the necessary packages (dplyr,plyr,data.table)
2. Download & unzip the source data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
3. Get the run_analysis.R source code
4. Place the downloaded source data file and R source code in the same folder
5. Open R console, set your working directory using setwd() command to the same folder where you placed the data and source code
6. Run the code using 'source("run_analysis.R")' command
7. Sit back & drink coffee ;)
8. You should get the same outcome that is uploaded to the submission page

== WHAT THE CODE DOES ==
The comments in the code should be self explanatory. However, here's a big picture of what the code will do to your machine:
1. Read data files from the downloaded file to the R environment
2. Do the necessary data manipulation (e.g. merging, renaming columns, assigning variables) to the test observation
3. Do the necessary data manipulation (e.g. merging, renaming columns, assigning variables) to the training observation
4. Do a row join to combine both test and training observations
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Saves the output/tidy data set to a txt file

If you have any questions, feel free to contact me directly. Thanks!