df_big5 <- read.table("data/big5/big5-data.csv", header = TRUE)

df_big5 <- df_big5 %>%
  mutate(engnat = as.character(engnat)) %>%
  mutate(engnat = recode(engnat, "1"="yes", "2"="no", "0"="missing")) %>%
  mutate(gender = recode(gender, `1`="male", `2`="female", `3`="other", .default ="missed"))
