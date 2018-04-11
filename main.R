library(tidyverse)
library(ggplot2)

julycommercial = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Detroit_Cherry_July_2015/Detroit_and_Cherry_Crashes_5995_Travel/Detroit_and_Cherry_5995_zone_traffic_commercial.csv")
julypersonal = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Detroit_Cherry_July_2015/Detroit_and_Cherry_Crashes_5995_Travel/Detroit_and_Cherry_5995_zone_traffic_personal.csv")

augustcommercial = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Detroit_Cherry_August_2015/Detroit_and_Cherry_Crashes_1002_Travel/Detroit_and_Cherry_1002_zone_traffic_commercial.csv")
augustpersonal = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Detroit_Cherry_August_2015/Detroit_and_Cherry_Crashes_1002_Travel/Detroit_and_Cherry_1002_zone_traffic_personal.csv")

#can I combine personal and commercial
july = bind_rows(julycommercial,julypersonal)
august = bind_rows(augustcommercial,augustpersonal)

july <- july %>% mutate(month = 'July') %>%
  filter(Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)") 
  
  #select(Zone.Traffic..StL.Index.) 
  
#filter(julypersonal,Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)")
august <- august %>% mutate(month = 'August') %>%
  filter(Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)") 
  
  #select(Zone.Traffic..StL.Index.)
#filter(augustpersonal,Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)")

both = bind_rows(july,august)
both$month <- factor(both$month, levels = c("July","August"))
#filter only Personal data because Commercial data is ostensibly low-quality during June-Aug 2015
ggplot(data = filter(both,Device.Type == "Personal")) +
  geom_bar(stat = "identity",
           mapping =  aes(x = Zone.Name, y = Zone.Traffic..StL.Index.,fill = month),
           position = "dodge")+
  theme(axis.text.x = element_text(angle = 45, vjust = 1,hjust = 1))
