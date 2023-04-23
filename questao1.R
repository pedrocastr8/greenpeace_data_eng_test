# Loading packages
library(tidyverse)
library(bigrquery)

# Auth in google account
bq_auth()

# Store the project ID
projectid = "gp-data-engineer"

# Set your query
sql <- "SELECT * 
FROM `bigquery-public-data.fda_food.food_events` 
WHERE consumer_gender = 'Male'
ORDER BY date_created DESC
LIMIT 100"

# Run the query; this returns a bq_table object that you can query further
tb <- bq_project_query(projectid, sql)

# Store the first 100 rows of the data in a tibble
sample <-bq_table_download(tb, n_max = 100)

# Print the 100 rows of data
sample


