# letra C

sql_C <- "SELECT
  reactions,
  COUNT(*) AS reaction_count
FROM
  (
    SELECT
      products_industry_name,
      SPLIT(reactions, ',') AS reactionss
    FROM
      `bigquery-public-data.fda_food.food_events`
    WHERE
      lower(products_industry_name) LIKE '%cosmetics%'
      AND consumer_age BETWEEN 18 AND 25
  ), UNNEST(reactionss) AS reactions
GROUP BY
  reactions
ORDER BY
  reaction_count DESC
LIMIT
  3
"
# Run the query; this returns a bq_table object that you can query further
tb_C <- bq_project_query(projectid, sql_C)

# Store the first 100 rows of the data in a tibble
sample_C <-bq_table_download(tb_C, n_max = 3)

# Print the 100 rows of data
sample_C