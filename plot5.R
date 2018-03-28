## Data preparation
### Download the data file
#url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#fname = "Projek2_exploratorydata_05.zip"
#download.file(url,fname)

### Unzip the file
#unzip(fname)
### Read the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Plot 5
library(ggplot2)
### Motor vehicle emission in Baltimore city over the years
Baltimore.NEI <- subset(NEI, fips=="24510" & type=="ON-ROAD")

# Aggregate emissions
Baltimore.Emissions.motor <- aggregate(Baltimore.NEI$Emissions, 
                                       by=list(Baltimore.NEI$year), 
                                       FUN=sum)
names(Baltimore.Emissions.motor)[1] <- "year"

# Make the plot with histogram
png("plot5.png", width = 750, height = 450)
ggplot(Baltimore.Emissions.motor,
       aes(as.factor(year), x,
           label = round(x,digits = 0),
           fill = as.factor(year)))+
  xlab("Year") +
  ylab("PM2.5 emissions") +
  ggtitle("Total vehicle PM 2.5 emission from 1999 to 2008\nBaltimore, MD") +
  geom_histogram(stat = "identity") +
  geom_text(vjust = 2) +
  scale_fill_discrete(name = "Year")
dev.off()
