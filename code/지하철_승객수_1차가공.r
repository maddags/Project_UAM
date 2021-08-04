library(dplyr)
library(writexl)

subway_201501_data <- read.csv("./CARD_SUBWAY_MONTH_201501.csv")
subway_201502_data <- read.csv("./CARD_SUBWAY_MONTH_201502.csv")
subway_201503_data <- read.csv("./CARD_SUBWAY_MONTH_201503.csv")
subway_201504_data <- read.csv("./CARD_SUBWAY_MONTH_201504.csv")
subway_201505_data <- read.csv("./CARD_SUBWAY_MONTH_201505.csv")
subway_201506_data <- read.csv("./CARD_SUBWAY_MONTH_201506.csv")
subway_201507_data <- read.csv("./CARD_SUBWAY_MONTH_201507.csv")
subway_201508_data <- read.csv("./CARD_SUBWAY_MONTH_201508.csv")
subway_201509_data <- read.csv("./CARD_SUBWAY_MONTH_201509.csv")
subway_201510_data <- read.csv("./CARD_SUBWAY_MONTH_201510.csv")
subway_201511_data <- read.csv("./CARD_SUBWAY_MONTH_201511.csv")
subway_201512_data <- read.csv("./CARD_SUBWAY_MONTH_201512.csv")

subway_201601_data <- read.csv("./CARD_SUBWAY_MONTH_201601.csv")
subway_201602_data <- read.csv("./CARD_SUBWAY_MONTH_201602.csv")
subway_201603_data <- read.csv("./CARD_SUBWAY_MONTH_201603.csv")
subway_201604_data <- read.csv("./CARD_SUBWAY_MONTH_201604.csv")
subway_201605_data <- read.csv("./CARD_SUBWAY_MONTH_201605.csv")
subway_201606_data <- read.csv("./CARD_SUBWAY_MONTH_201606.csv")
subway_201607_data <- read.csv("./CARD_SUBWAY_MONTH_201607.csv")
subway_201608_data <- read.csv("./CARD_SUBWAY_MONTH_201608.csv")
subway_201609_data <- read.csv("./CARD_SUBWAY_MONTH_201609.csv")
subway_201610_data <- read.csv("./CARD_SUBWAY_MONTH_201610.csv")
subway_201611_data <- read.csv("./CARD_SUBWAY_MONTH_201611.csv")
subway_201612_data <- read.csv("./CARD_SUBWAY_MONTH_201612.csv")


subway_201701_data <- read.csv("./CARD_SUBWAY_MONTH_201701.csv")
subway_201702_data <- read.csv("./CARD_SUBWAY_MONTH_201702.csv")
subway_201703_data <- read.csv("./CARD_SUBWAY_MONTH_201703.csv")
subway_201704_data <- read.csv("./CARD_SUBWAY_MONTH_201704.csv")
subway_201705_data <- read.csv("./CARD_SUBWAY_MONTH_201705.csv")
subway_201706_data <- read.csv("./CARD_SUBWAY_MONTH_201706.csv")
subway_201707_data <- read.csv("./CARD_SUBWAY_MONTH_201707.csv")
subway_201708_data <- read.csv("./CARD_SUBWAY_MONTH_201708.csv")
subway_201709_data <- read.csv("./CARD_SUBWAY_MONTH_201709.csv")
subway_201710_data <- read.csv("./CARD_SUBWAY_MONTH_201710.csv")
subway_201711_data <- read.csv("./CARD_SUBWAY_MONTH_201711.csv")
subway_201712_data <- read.csv("./CARD_SUBWAY_MONTH_201712.csv")

subway_201801_data <- read.csv("./CARD_SUBWAY_MONTH_201801.csv")
subway_201802_data <- read.csv("./CARD_SUBWAY_MONTH_201802.csv")
subway_201803_data <- read.csv("./CARD_SUBWAY_MONTH_201803.csv")
subway_201804_data <- read.csv("./CARD_SUBWAY_MONTH_201804.csv")
subway_201805_data <- read.csv("./CARD_SUBWAY_MONTH_201805.csv")
subway_201806_data <- read.csv("./CARD_SUBWAY_MONTH_201806.csv")
subway_201807_data <- read.csv("./CARD_SUBWAY_MONTH_201807.csv")
subway_201808_data <- read.csv("./CARD_SUBWAY_MONTH_201808.csv")
subway_201809_data <- read.csv("./CARD_SUBWAY_MONTH_201809.csv")
subway_201810_data <- read.csv("./CARD_SUBWAY_MONTH_201810.csv")
subway_201811_data <- read.csv("./CARD_SUBWAY_MONTH_201811.csv")
subway_201812_data <- read.csv("./CARD_SUBWAY_MONTH_201812.csv")


subway_201901_data <- read.csv("./CARD_SUBWAY_MONTH_201901.csv")
subway_201902_data <- read.csv("./CARD_SUBWAY_MONTH_201902.csv")
subway_201903_data <- read.csv("./CARD_SUBWAY_MONTH_201903.csv")
subway_201904_data <- read.csv("./CARD_SUBWAY_MONTH_201904.csv")
subway_201905_data <- read.csv("./CARD_SUBWAY_MONTH_201905.csv")
subway_201906_data <- read.csv("./CARD_SUBWAY_MONTH_201906.csv")
subway_201907_data <- read.csv("./CARD_SUBWAY_MONTH_201907.csv")
subway_201908_data <- read.csv("./CARD_SUBWAY_MONTH_201908.csv")
subway_201909_data <- read.csv("./CARD_SUBWAY_MONTH_201909.csv")
subway_201910_data <- read.csv("./CARD_SUBWAY_MONTH_201910.csv")
subway_201911_data <- read.csv("./CARD_SUBWAY_MONTH_201911.csv")
subway_201912_data <- read.csv("./CARD_SUBWAY_MONTH_201912.csv")


subway_202001_data <- read.csv("./CARD_SUBWAY_MONTH_202001.csv")
subway_202002_data <- read.csv("./CARD_SUBWAY_MONTH_202002.csv")
subway_202003_data <- read.csv("./CARD_SUBWAY_MONTH_202003.csv")
subway_202004_data <- read.csv("./CARD_SUBWAY_MONTH_202004.csv")
subway_202005_data <- read.xlsx("./202005.xlsx")
subway_202006_data <- read.xlsx("./202006.xlsx")
subway_202007_data <- read.xlsx("./202007.xlsx")
subway_202008_data <- read.xlsx("./202008.xlsx")
subway_202009_data <- read.xlsx("./202009.xlsx")
subway_202010_data <- read.xlsx("./202010.xlsx")
subway_202011_data <- read.xlsx("./202011.xlsx")
subway_202012_data <- read.xlsx("./202012.xlsx")


subway_202101_data <- read.xlsx("./202101.xlsx")
subway_202102_data <- read.xlsx("./202102.xlsx")
subway_202103_data <- read.xlsx("./202103.xlsx")
subway_202104_data <- read.xlsx("./202104.xlsx")
subway_202105_data <- read.xlsx("./202105.xlsx")
subway_202106_data <- read.xlsx("./202106.xlsx")








subway_2015_data <- bind_rows(subway_201501_data,
                              subway_201502_data,
                              subway_201503_data,
                              subway_201504_data,
                              subway_201505_data,
                              subway_201506_data,
                              subway_201507_data,
                              subway_201508_data,
                              subway_201509_data,
                              subway_201510_data,
                              subway_201511_data,
                              subway_201512_data)



subway_2016_data <- bind_rows(subway_201601_data,
                              subway_201602_data,
                              subway_201603_data,
                              subway_201604_data,
                              subway_201605_data,
                              subway_201606_data,
                              subway_201607_data,
                              subway_201608_data,
                              subway_201609_data,
                              subway_201610_data,
                              subway_201611_data,
                              subway_201612_data)



subway_2017_data <- bind_rows(subway_201701_data,
                              subway_201702_data,
                              subway_201703_data,
                              subway_201704_data,
                              subway_201705_data,
                              subway_201706_data,
                              subway_201707_data,
                              subway_201708_data,
                              subway_201709_data,
                              subway_201710_data,
                              subway_201711_data,
                              subway_201712_data)


subway_2018_data <- bind_rows(subway_201801_data,
                              subway_201802_data,
                              subway_201803_data,
                              subway_201804_data,
                              subway_201805_data,
                              subway_201806_data,
                              subway_201807_data,
                              subway_201808_data,
                              subway_201809_data,
                              subway_201810_data,
                              subway_201811_data,
                              subway_201812_data)



subway_2019_data <- bind_rows(subway_201901_data,
                              subway_201902_data,
                              subway_201903_data,
                              subway_201904_data,
                              subway_201905_data,
                              subway_201906_data,
                              subway_201907_data,
                              subway_201908_data,
                              subway_201909_data,
                              subway_201910_data,
                              subway_201911_data,
                              subway_201912_data)





subway_2020_data <- bind_rows(subway_202001_data,
                              subway_202002_data,
                              subway_202003_data,
                              subway_202004_data,
                              subway_202005_data,
                              subway_202006_data,
                              subway_202007_data,
                              subway_202008_data,
                              subway_202009_data,
                              subway_202010_data,
                              subway_202011_data,
                              subway_202012_data)





subway_2021_data <- bind_rows(subway_202101_data,
                              subway_202102_data,
                              subway_202103_data,
                              subway_202104_data,
                              subway_202105_data,
                              subway_202106_data)






write_xlsx(subway_2015_data,"./2015년_지하철_승객수.xlsx")
write_xlsx(subway_2016_data,"./2016년_지하철_승객수.xlsx")
write_xlsx(subway_2017_data,"./2017년_지하철_승객수.xlsx")
write_xlsx(subway_2018_data,"./2018년_지하철_승객수.xlsx")
write_xlsx(subway_2019_data,"./2019년_지하철_승객수.xlsx")
write_xlsx(subway_2020_data,"./2020년_지하철_승객수.xlsx")
write_xlsx(subway_2021_data,"./2021년_지하철_승객수.xlsx")