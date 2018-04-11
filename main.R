library(tidyverse)
library(ggplot2)

beforecommercial = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Detroit_Cherry_6_months_Before_1307_Travel/Detroit_Cherry_1307_zone_traffic_commercial.csv")
beforepersonal = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Detroit_Cherry_6_months_Before_1307_Travel/Detroit_Cherry_1307_zone_traffic_personal.csv")

aftercommercial = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Cherry_Detroit_After_6_months_1276_Travel/Cherry_Detroit_1276_zone_traffic_commercial.csv")
afterpersonal = read.csv("C:/Users/fullerm/Documents/Safety/crashreport2014to2016/Cherry_Detroit_After_6_months_1276_Travel/Cherry_Detroit_1276_zone_traffic_personal.csv")

#can I combine personal and commercial
before = bind_rows(beforecommercial,beforepersonal)
after = bind_rows(aftercommercial,afterpersonal)

before <- before %>% mutate(period = 'before') %>%
  filter(Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)") 
  
  #select(Zone.Traffic..StL.Index.) 
  
#filter(julypersonal,Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)")
after <- after %>% mutate(period = 'after') %>%
  filter(Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)") 
  
  #select(Zone.Traffic..StL.Index.)
#filter(augustpersonal,Day.Type == "0: Average Day (M-Su)" & Day.Part == "0: All Day (12am-12am)")

both = bind_rows(before,after)
both$period <- factor(both$period, levels = c("before","after"))
#filter only Personal data because Commercial data is ostensibly low-quality during June-Aug 2015
ggplot(data = filter(both,Device.Type == "Personal")) +
  geom_bar(stat = "identity",
           mapping =  aes(x = Zone.Name, y = Zone.Traffic..StL.Index.,fill = period),
           position = "dodge")+
  theme(axis.text.x = element_text(angle = 45, vjust = 1,hjust = 1))
