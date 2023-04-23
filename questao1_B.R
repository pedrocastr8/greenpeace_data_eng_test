# letra B

sql_B <- "SELECT
  products_industry_name,
  COUNT(*) AS death_count
FROM
  `bigquery-public-data.fda_food.food_events`
WHERE
  products_industry_name IS NOT NULL
  AND LOWER(reactions) LIKE '%death%'
GROUP BY
  products_industry_name
ORDER BY
  death_count DESC
LIMIT 1
"
# Run the query; this returns a bq_table object that you can query further
tb_B <- bq_project_query(projectid, sql_B)

# Store the first 100 rows of the data in a tibble
sample_B <-bq_table_download(tb_B, n_max = 1)

# Print the 100 rows of data
sample_B