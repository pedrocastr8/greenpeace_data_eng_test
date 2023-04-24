pokemons <- c("bulbasaur", "charmander", "squirtle", "pikachu", "chikorita", "cyndaquil", "totodile", "treecko",
              "torchic", "mudkip", "turtwig", "chimchar", "piplup", "snivy", "tepig", "oshawott", "chespin",
              "fennekin", "froakie", "rowlet", "litten", "popplio", "grookey", "scorbunny", "sobble")

pokemon_data <- list()

for (pokemon in pokemons) {
  # consulta para obter informações de nome e id
  response_info <- GET(paste0("https://pokeapi.co/api/v2/pokemon/", pokemon))
  name <- content(response_info)$name
  id <- content(response_info)$id
  
  # consulta para obter informações de elemento(s)
  response_type <- GET(paste0("https://pokeapi.co/api/v2/pokemon-species/", pokemon))
  types <- content(response_type)$color$name
  
  # adiciona informações ao data frame
  pokemon_data[[pokemon]] <- c(name = name, id = id, element = types)
}

# converte lista em data frame
pokemon_df <- bind_rows(pokemon_data, .id = "pokemon") %>%
  select(id, pokemon,name, element)
