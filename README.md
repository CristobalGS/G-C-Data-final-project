# G-C-Data-final-project

This code takes some txt files data loaded in the directory. 

-> 
_________________________________________________________________________
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws 
__________________________________________________________________________

In the first place it tidies up the data adding variable columns (subject, set, activity) and selects only measurments for the mean and standard deviation of the original variables. It does that for both the test and train set, and then merges both data set together ("data" dataframe). 

It generates a new data set (final.data) summarizing the first one by taken the mean of each variable over subject and activity.

