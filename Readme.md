Readme
=========

This file explains the details of the project Course Project for Getting and Cleaning data. 

Source
----------

This script takes the original data from:
```sh
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
```

Steps
------------
The following transformation are performed

  - Merge training and test data sets
  - Bind the subject, observation and activity data sets into one
  - Only select the median and standard deviation columns
  - Calculates the mean of each column across activity and subjects
 
All work is performed by run_Analysis.R script. In order for this script to work, data downloaded from the link above needs to be extracted to the same folder as the R script.

Output
--------
At the end of execution a new file will be created in the same folder with the following name:
```sh
Means_of_mean_and_stdev_type_features.txt
```

