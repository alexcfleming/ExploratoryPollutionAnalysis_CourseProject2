plot1 <- function(...){
     library(dplyr)
     library(data.table)
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     SCC$SCC <- as.character(SCC$SCC)
     NEI_SCC <- left_join(NEI, SCC, by="SCC")
     NEI_SCC <- data.table(NEI_SCC)
     totals <- NEI_SCC[,.(Emissions.Sum=sum(Emissions)), by=year]
     png(filename="plot1.png")
     ## insert plot command here
     barplot(totals$Emissions.Sum, names.arg=totals$year, xlab="Observation Year", ylab="Total PM2.5 Emissions in Tons")
     dev.off()
}