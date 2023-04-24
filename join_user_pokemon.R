# Adicionar uma nova coluna "pokemon" em users_df com um Pokemon aleatório atribuído a cada pessoa
users_df$pokemon <- sample(pokemon_df$name, size = nrow(users_df), replace = TRUE)

# Visualizar os resultados
head(users_df)
