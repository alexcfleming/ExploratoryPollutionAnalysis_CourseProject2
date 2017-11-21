plot2 <- function(...){
     library(dplyr)
     library(data.table)
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     SCC$SCC <- as.character(SCC$SCC)
     NEI_SCC <- left_join(NEI, SCC, by="SCC")
     NEI_SCC <- data.table(NEI_SCC)
     ## Manipulate from main data table to subset
     baltimorecity <- NEI_SCC[fips == "24510"]
     totals <- baltimorecity[,.(Emissions.Sum=sum(Emissions)), by=year]
     ## Crate plot
     png(filename="plot2.png")
     ## insert plot command here
     barplot(totals$Emissions.Sum, names.arg=totals$year, xlab="Observation Year - Baltimore City", ylab="Total PM2.5 Emissions in Tons")
     dev.off()
}