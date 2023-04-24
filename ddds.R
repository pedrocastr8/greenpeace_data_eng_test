library(tidyverse)

# Load json file
json <- jsonlite::read_json("~/Desktop/greenpeace_data_eng_test/dddsBrasileiros.json")

# Combine DDDs and UF into a single data frame
df_ddd_uf <- tibble(
  DDD = names(json$estadoPorDdd),
  UF = unlist(json$estadoPorDdd)
)

# Create a data frame of DDDs per state
df_por_estado <- purrr::map_dfr(json$dddsPorEstado, ~ tibble(UF = .y, DDD = .x))

# Convert to a tidy format
df_final <- df_por_estado %>%
  tidyr::pivot_longer(cols = DDD, names_to = "DDD_index", values_to = "DDD") %>%
  left_join(df_ddd_uf, by = "DDD") %>%
  arrange(UF, DDD)

df_final
