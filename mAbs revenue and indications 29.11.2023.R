# mAbs revenue and indications visualisation

library(tidyverse)
library(plotly)

# get data
mabs.rev <- read_csv('mAb revenue.csv')
mabs.rev <- mabs.rev %>% pivot_longer(cols=c(2:18),
                          names_to ='mab',
                          values_to ='revenue')
str(mabs.rev) # should now have a Year, mab, and revenue column

mabs.ind <- read_csv('mAb indications.csv')
mabs.ind <- mabs.ind %>% pivot_longer(cols = c(2:19),
                                      names_to ='mab',
                                      values_to ='indication')
str(mabs.ind) # should now have a Year, mab, and indication column

# merge the two dataframes
mabs <- merge(mabs.rev, mabs.ind, by = c('Year','mab'), all = T)
range(mabs$Year) # check if years span 1997-2021

# visualise
fig <- plot_ly(mabs, x = ~`Year`, y = ~`revenue`, color = ~mab,
               type = 'scatter', mode = 'lines+markers',
               colors = "Set3",
               text = ~paste('Indication: ', indication, 
                             '</br>Product: ', mab)) %>%
  layout(title = list(text = "Blockbuster mAbs Revenue from 1997-2021 Annotated with Indication Approvals", x = 0.7, y = 0.96),
         xaxis = list(title = ""),
         yaxis = list(title = "Revenue (USD)"))

fig
# save as web page to keep the formatting and interactivity