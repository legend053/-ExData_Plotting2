library(ggplot2)
#read data
NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

BaltimoreCitybyonroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
BaltimoreCity <- aggregate(BaltimoreCitybyonroad[, 'Emissions'], by=list(BaltimoreCitybyonroad$year), sum)
colnames(BaltimoreCity) <- c('year', 'Emissions')

png('plot5.png')

ggplot(data=BaltimoreCity, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year),stat="identity") + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()