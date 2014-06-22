
#read data
NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")
#create an array by year
BaltimoreCity <- subset(NEI, fips == "24510") #find the data of BaltimoreCity
cityemissionbyyear<-tapply(BaltimoreCity$Emissions, BaltimoreCity$year, sum)

#create png file
png(filename='plot2.png')
#generate barplot
barplot(cityemissionbyyear, names.arg=names(cityemissionbyyear), main=expression('Total Emission of PM'[2.5]),xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()