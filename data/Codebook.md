X_train: training dataset

y_train: activity labels for training dataset (X_train)

subject_train: subject ids for training dataset (X_train)

X_test: test dataset

y_test: activity labels for test dataset (X_test)

subject_test: subject ids for test dataset (X_test)

features: features that measured in the dataset

activity_labels: a lookup table indicating activity label and name


X: a dataframe containing both training and test data.
Y: activity labels corresponding to each observations in X_all


Subject: subject ids for all the observations in both datasets.

Merged_Data: full data set (containing both training and testing) with subject id and activity for each observation. Variable names are changed to feature names

TidyData: filtered out the measurements of features that only contain mean and standard deviation measurements of all the observations. similar to X_filtered, except that it contains subject id and activity id, also with column names as features.

FinalData: dataset of TidyData where the data has been grouped by subject and activity and then summarized by performing a mean calculation