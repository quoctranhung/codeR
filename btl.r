library(tidyr)
library(stringr)
df <- read.csv("All_GPUs.csv")
View(df)

# Chọn biến

df <- df[ , c("Name", "Max_Power", "Memory_Bandwidth", "Memory_Speed", "Pixel_Rate", "Release_Date", "Texture_Rate")]
View(df)

# Xử lý dữ liệu

str(df)
row <- c(1:3406)

df$Max_Power_Nums <- str_extract(df$Max_Power ,"\\d+\\.?\\d*")
df$Max_Power_Units <- str_replace(df$Max_Power, "\\d+\\.?\\d*", "")
View(df)