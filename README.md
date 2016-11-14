# Getting and cleaning data Course Project

This is the course project for the Getting and Cleaning Data course part of the Data Science Specialization by John Hopkins University. The script, run_analysis.R, performs the following:

1.	In case the dataset is not in the working directory, it is downloaded and unzipped.
2.	Loads activity labels and features.
3.	Creates a variable in order to extract only the features needed (mean and standard deviation) from the original dataset.
4.	Loads the two datasets, train and test, selecting only the features highlighted in the previous step (mean and SD). Then, the activity and subject columns for each set is merged
5.	Merges both datasets in a single file called “Data”
6.	Converts the columns of the latter file, activity and subject, into factors.
7.	Creates a tidy dataset. It mainly consists of the mean each of the 79 variables for each subject and activity performed by it.  
8.	 Exports the tidy dataset under the name “tidy.txt”
