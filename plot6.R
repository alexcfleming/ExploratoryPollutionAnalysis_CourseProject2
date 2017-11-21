plot6 <- function(...){
     library(dplyr)
     library(data.table)
     library(ggplot2)
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     SCC$SCC <- as.character(SCC$SCC)
     NEI_SCC <- left_join(NEI, SCC, by="SCC")
     NEI_SCC <- data.table(NEI_SCC)
     ## filter to vehicle sources in baltimorecity
     baltimorela <- NEI_SCC[fips %in% c("24510","06037")]
     ## Manipulate from main data table to subset
     mobilesources <- baltimorela[SCC.Level.One %in% "Mobile Sources"]
     vehicleleveltwo <- c("Off-highway Vehicle Gasoline, 4-Stroke", "Off-highway Vehicle Gasoline, 2-Stroke", "Off-highway Vehicle Diesel", "Highway Vehicles - Diesel", "Highway Vehicles - Gasoline")
     vehiclesourcesbl <- mobilesources[SCC.Level.Two %in% vehicleleveltwo]
     ## make plot
     totals <- vehiclesourcesbl[,.(Emissions.Sum=sum(Emissions)), by=.(fips, year)]
     qplot(year, Emissions.Sum, data=totals, facets=fips~., xlab="Observation Year", ylab="Total Emissions in Tons", main="Change in Vehicle Emissions - Los Angeles (06037) vs. Baltimore City(24510)") + geom_col()
     ## Create plot file
     ggsave("plot6.png", width=8, height=5)
}