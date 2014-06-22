
#read data
NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")

#create an array by year
total<-round(totalPM25ByYear/1000,2) #for better display
#create png file
png(filename='plot1.png')
#generate barplot
barplot(total, names.arg=names(total), main=expression('Total Emission of PM'[2.5]),xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()