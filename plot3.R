plot3 <- function(...){
     library(dplyr)
     library(data.table)
     library(ggplot2)
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     SCC$SCC <- as.character(SCC$SCC)
     NEI_SCC <- left_join(NEI, SCC, by="SCC")
     NEI_SCC <- data.table(NEI_SCC)
     ## Manipulate from main data table to subset
     baltimorecity <- NEI_SCC[fips == "24510"]
     qplot(year, Emissions, data=baltimorecity, facets=.~type, ylim=c(0,400), xlab="Observation Year in Baltimore City", ylab="Emissions Observations in Tons") + geom_smooth(method=lm)
     ## Crate plot file
     ggsave("plot3.png", width=10, height=5)
}