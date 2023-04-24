library(googledrive)

# Specify the parent folder using as_dribble()
parent_folder <- as_dribble("1yuM9Gr5YtULMFL23sCj2isOw9fq9Qbpx")

# Create the file inside the parent folder
new_file <- drive_upload("test.csv", path = parent_folder)