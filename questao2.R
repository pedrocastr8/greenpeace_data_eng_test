# Loading Packages
library(httr)
library(jsonlite)
library(tidyverse)

# Function for user in API
get_random_user <- function() {
  # Make the API request
  response <- httr::GET("https://randomuser.me/api/?nat=br")
  # Parse the JSON response
  json <- jsonlite::fromJSON(httr::content(response, "text"), simplifyDataFrame = TRUE)
  # Extract the user data
  user <- json$results
  return(user)
}

# Single user
users <- list()
for (i in 1:1000) {
  users[[i]] <- get_random_user()
}

# Convert to df
users_df <- dplyr::bind_rows(users)

# Create a new column for user's state based on their phone number's area code
json_text <- readLines("~/Desktop/greenpeace_data_eng_test/dddsBrasileiros.json", warn = FALSE)
json <- fromJSON(json_text)
df_ddd_uf <- tibble(
  DDD = names(json$estadoPorDdd),
  UF = unlist(json$estadoPorDdd)
)
users_df <- users_df %>%
  mutate(DDD = stringr::str_sub(cell, 2, 3),
         UF = df_ddd_uf$UF[match(DDD, df_ddd_uf$DDD)],
         .keep = "unused") %>%
  filter(!is.na(UF))

