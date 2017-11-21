plot5 <- function(...){
     library(dplyr)
     library(data.table)
     library(ggplot2)
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     SCC$SCC <- as.character(SCC$SCC)
     NEI_SCC <- left_join(NEI, SCC, by="SCC")
     NEI_SCC <- data.table(NEI_SCC)
     ## filter to vehicle sources in baltimorecity
     baltimorecity <- NEI_SCC[fips == "24510"]
     ## Manipulate from main data table to subset
     mobilesources <- baltimorecity[SCC.Level.One %in% "Mobile Sources"]
     vehicleleveltwo <- c("Off-highway Vehicle Gasoline, 4-Stroke", "Off-highway Vehicle Gasoline, 2-Stroke", "Off-highway Vehicle Diesel", "Highway Vehicles - Diesel", "Highway Vehicles - Gasoline")
     vehiclesourcesbc <- mobilesources[SCC.Level.Two %in% vehicleleveltwo]
     ## make plot
     totals <- vehiclesourcesbc[,.(Emissions.Sum=sum(Emissions)), by=year]
     qplot(year, Emissions.Sum, data=totals, xlab="Observation Year", ylab="Total Emissions in Tons", main="Vehicle Related Emissions in Baltimore City") + geom_smooth(method=lm)
     ## Create plot file
     ggsave("plot5.png", width=7, height=5)
}