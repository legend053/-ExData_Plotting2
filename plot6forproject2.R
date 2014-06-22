library(ggplot2)
#read data
NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

BaltimoreCitybyonroad <- subset(NEI, fips == '24510'' & type == 'ON-ROAD')
losangelesbyonroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')
BaltimoreCity <- aggregate(BaltimoreCitybyonroad[, 'Emissions'], by=list(BaltimoreCitybyonroad$year), sum)
colnames(BaltimoreCity) <- c('year', 'Emissions')
BaltimoreCity$State <- paste(rep('MD', 4))

losangeles <- aggregate(losangelesbyonroad[, 'Emissions'], by=list(losangelesbyonroad$year), sum)
colnames(losangeles) <- c('year', 'Emissions')
losangeles$State <- paste(rep('CA', 4))

Twocity<-rbind(BaltimoreCity,losangeles)

png(filename='plot6.png')

ggplot(data=Twocity, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year),stat="identity") + facet_grid(. ~ State) + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none')  + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()