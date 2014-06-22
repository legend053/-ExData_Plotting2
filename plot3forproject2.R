
library(ggplot2)
#read data
NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")

BaltimoreCity <- subset(NEI, fips == '24510')
BaltimoreCity$year <- factor(BaltimoreCity$year, levels=c('1999', '2002', '2005', '2008'))

png('plot3.png', width=800, height=500, units='px')
ggplot(data=BaltimoreCity, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F)+geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha=0.10)

dev.off()