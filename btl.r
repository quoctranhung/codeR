library(tidyr)
library(stringr)
setwd("C:/codeR")
df <- read.csv("All_GPUs.csv")
View(df)

# Chọn biến

df <- df[ , c("Name", "Max_Power", "Memory_Bandwidth", "Memory_Speed", "Pixel_Rate", "Release_Date", "Texture_Rate")]
View(df)

# Xử lý dữ liệu

str(df)

#Tách dữ liệu làm 2 phần giá trị và đơn vị

df$Max_Power_Nums <- as.numeric(str_extract(df$Max_Power ,"\\d+\\.?\\d*"))
df$Max_Power_Units <- str_replace(df$Max_Power, "\\d+\\.?\\d*", "")
print(table(df$Max_Power_Units))

df$Memory_Bandwidth_Nums <- as.numeric(str_extract(df$Memory_Bandwidth, "\\d+\\.?\\d*"))
df$Memory_Bandwidth_Units <- str_replace(df$Memory_Bandwidth, "\\d+\\.?\\d*", "")
print(table(df$Memory_Bandwidth_Units))

df$Memory_Speed_Nums <- as.numeric(str_extract(df$Memory_Speed, "\\d+\\.?\\d*"))
df$Memory_Speed_Units <- str_replace(df$Memory_Speed, "\\d+\\.?\\d*", "")
print(table(df$Memory_Speed_Units))

df$Pixel_Rate_Nums <- as.numeric(str_extract(df$Pixel_Rate, "\\d+\\.?\\d*"))
df$Pixel_Rate_Units <- str_replace(df$Pixel_Rate, "\\d+\\.?\\d*", "")
print(table(df$Pixel_Rate_Units))

df$Texture_Rate_Nums <- as.numeric(str_extract(df$Texture_Rate, "\\d+\\.?\\d*"))
df$Texture_Rate_Units <- str_replace(df$Texture_Rate, "\\d+\\.?\\d*", "")
print(table(df$Texture_Rate_Units))

# Đổi Memory_Bandwidth cho cùng đơn vị và kiểm tra lại dữ liệu

df$Memory_Bandwidth_Nums <- round(df$Memory_Bandwidth_Nums / 1024, 2)
df$Memory_Bandwidth_Units <- "GB"
print(table(df$Memory_Bandwidth_Units))

# Đặt ngày đầu tiên là mốc 0 và số ngày bắt đầu từ ngày 0 là cột Nums_days

df$Release_Date <- as.Date(sub ("^\\s*\\n", "", df$ Release_Date ), format = "%d-%b-%Y")
print(min(df$Release_Date, na.rm = TRUE))
df$Release_Date_Nums <- as.numeric((df$Release_Date - min(df$Release_Date, na.rm = TRUE)))

View(df)

# Xử lý dữ liệu khuyết

dfNums <- data.frame(df$Max_Power_Nums, df$Memory_Bandwidth_Nums, df$Memory_Speed_Nums, df$Pixel_Rate_Nums, df$Texture_Rate_Nums, df$Release_Date_Nums)
print((colSums(is.na(dfNums))))
print((colMeans(is.na(dfNums))))
print(summary(dfNums))

# Vì tỉ lệ khuyết dữ liệu cao nên thêm vào dữ liệu khuyết giá trị trung vị

df$Max_Power_Nums[is.na(df$Max_Power_Nums)] <- median(df$Max_Power_Nums, na.rm = TRUE)
df$Memory_Bandwidth_Nums[is.na(df$Memory_Bandwidth_Nums)] <- median(df$Memory_Bandwidth_Nums, na.rm = TRUE)
df$Memory_Speed_Nums[is.na(df$Memory_Speed_Nums)] <- median(df$Memory_Speed_Nums, na.rm = TRUE)
df$Pixel_Rate_Nums[is.na(df$Pixel_Rate_Nums)] <- median(df$Pixel_Rate_Nums, na.rm = TRUE)
df$Texture_Rate_Nums[is.na(df$Texture_Rate_Nums)] <- median(df$Texture_Rate_Nums, na.rm = TRUE)
df$Release_Date_Nums[is.na(df$Release_Date_Nums)] <- median(df$Release_Date_Nums, na.rm = TRUE)

# Thêm giá trị vô data frame mới để phân tích

dfNums <- data.frame(df$Max_Power_Nums, df$Memory_Bandwidth_Nums, df$Memory_Speed_Nums, df$Pixel_Rate_Nums, df$Texture_Rate_Nums, df$Release_Date_Nums)
print(summary(dfNums))

# Vậy khi không còn giá trị khuyết ta thống kê mô tả dữ liệu

hist(dfNums$df.Max_Power_Nums, xlab = df$Max_Power_Units, main = 'Histogram of Max Power')
hist(dfNums$df.Memory_Bandwidth_Nums, xlab = df$Memory_Bandwidth_Units, main = 'Histogram of Memory Bandwidth')
hist(dfNums$df.Memory_Speed_Nums, xlab = df$Memory_Speed_Units, main = 'Histogram of Memory Speed')
hist(dfNums$df.Pixel_Rate_Nums, xlab = df$Pixel_Rate_Units, main = 'Histogram of Pixel Rate')
hist(dfNums$df.Texture_Rate_Nums, xlab = df$Texture_Rate_Units, main = 'Histogram of Texture Rate')
hist(dfNums$df.Release_Date_Nums, xlab = 'Days', main = 'Release Date')