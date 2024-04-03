library(tidyr)
library(stringr)
df <- read.csv("All_GPUs.csv")
View(df)

# Chọn biến

df <- df[ , c("Name", "Max_Power", "Memory_Bandwidth", "Memory_Speed", "Pixel_Rate", "Release_Date", "Texture_Rate")]
View(df)

# Xử lý dữ liệu

str(df)

#Tách dữ liệu làm 2 phần giá trị và đơn vị

df$Max_Power_Nums <- str_extract(df$Max_Power ,"\\d+\\.?\\d*")
df$Max_Power_Units <- str_replace(df$Max_Power, "\\d+\\.?\\d*", "")

df$Memory_Bandwidth_Nums <- str_extract(df$Memory_Bandwidth, "\\d+\\.?\\d*")
df$Memory_Bandwidth_Units <- str_replace(df$Memory_Bandwidth, "\\d+\\.?\\d*", "")

df$Memory_Speed_Nums <- str_extract(df$Memory_Speed, "\\d+\\.?\\d*")
df$Memory_Speed_Units <- str_replace(df$Memory_Speed, "\\d+\\.?\\d*", "")

df$Pixel_Rate_Nums <- str_extract(df$Pixel_Rate, "\\d+\\.?\\d*")
df$Pixel_Rate_Units <- str_replace(df$Pixel_Rate, "\\d+\\.?\\d*", "")

df$Texture_Rate_Nums <- str_extract(df$Texture_Rate, "\\d+\\.?\\d*")
df$Texture_Rate_Units <- str_replace(df$Texture_Rate, "\\d+\\.?\\d*", "")

# Đặt ngày đầu tiên là mốc 0 và số ngày bắt đầu từ ngày 0 là cột Nums_days

df$Release_Date <- as.Date(sub ("^\\s*\\n", "", df$ Release_Date ), format = "%d-%b-%Y")
print(min(df$Release_Date, na.rm = TRUE))



View(df)