# Homework4_Tagle

The script takes in the files from the UCI_HAR folder where the contents of the zipped folder are available in a work directory.

The x_train and x_test column names are renamed using the features dataset and using a separate variable list, filtered for only columns
relating to std and mean.

Interial signaling data is read into the R enviornment but not used.

The y_train and y_test variables are uploaded and renamed. The subject ID's are also uploaded and renamed.

All of the data is combined using rbind and cbind.

The final data set is created using an aggregate function and then unecessary columns are dropped and the remaining columns renamed to look
more approriate.
