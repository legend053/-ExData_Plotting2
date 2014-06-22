library(ggplot2)
#read data
NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")

SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
total <- merge(x=NEI, y=SCC.coal, by='SCC')
totalByYear <- tapply(total$Emissions, total$year, sum)

totalByYear_data<-data.frame(Year=names(totalByYear),Emissions=c(totalByYear[[1]],totalByYear[[2]],totalByYear[[3]],totalByYear[[4]]))

png(filename='plot4.png')

ggplot(data=totalByYear_data, aes(x=Year, y=Emissions/1000)) + 
     geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
     ggtitle(expression('Total Emissions of PM'[2.5])) + 
     ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
     geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
     theme(legend.position='none') + scale_colour_gradient(low='black', high='red')

dev.off()