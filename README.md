# Data Set: The NBER U.S. Patent Data

Data Link: http://www.nber.org/patents/

We will use the following data sets:

        Patent data, including constructed variables:

        Data link: http://www.nber.org/patents/apat63_99.zip

        Summary of this data is given here - http://www.nber.org/patents/pat63_99.txt

Problems 
1. Create an internal table for Patent data set.
   (Make sure not to include the header row)
2. Create an external table with dynamic partitioning for Patent data set so that it can be used efficiently for queries which require looking into patents granted for given year.
   (Use data from previous table and partition by Grant Year)
3. Find out number of patents granted in year 1963.
4. Find out number of patents granted in each country in year 1999.
