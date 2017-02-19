# CodeBook
This code book describes the variables, the data, and any transformations or work that performed to clean up the data. 

## Data source
The dataset that is used in this project can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) [59.7 MB], and the brief description of it can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

**Licence:**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

## Variables
List of variables:
* **subject**, ID the subject who performed the activity for each window sample, ranging from 1 to 30.
* **activity**, activity names, from 'activity_labels.txt'
* **features**, from 'features.txt' (total:561)    

## Transformation

Following is the detail of transformation from data source to tidy data result:
1. Merge the loaded training data and test data to create one dataset
2. Filter only the measurements on the mean and standard deviation for each measurement
3. Change activities in the dataset to use descriptive names listed in 'activity_labels.txt'
4. Label the dataset with descriptive names, e.g.:
   * prefix t is replaced by time
   * Acc is replaced by Accelerometer
   * Gyro is replaced by Gyroscope
   * prefix f is replaced by frequency
   * Mag is replaced by Magnitude
   * BodyBody is replaced by Body
   * () is replaced by empty string
5. Output the processed dataset into an independent tidy dataset.

Please see **[run_analysis.R](https://github.com/fitrianingrum/getting-and-cleaning-data/blob/master/run_analysis.R)** for detailed transformation.


