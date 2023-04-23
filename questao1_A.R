# letra A

sql_A <- "SELECT 
  reaction_type, 
  COUNT(*) as reaction_count
FROM (
  SELECT 
    SPLIT(reactions, ',') as reaction_types
  FROM `bigquery-public-data.fda_food.food_events`
), UNNEST(reaction_types) as reaction_type
GROUP BY reaction_type
ORDER BY reaction_count DESC
LIMIT 1;
"
# Run the query; this returns a bq_table object that you can query further
tb_A <- bq_project_query(projectid, sql_A)

# Store the first 100 rows of the data in a tibble
sample_A <-bq_table_download(tb_A, n_max = 1)

# Print the 100 rows of data
sample_A