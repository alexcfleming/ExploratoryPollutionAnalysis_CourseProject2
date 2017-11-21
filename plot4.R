plot4 <- function(...){
     library(dplyr)
     library(data.table)
     library(ggplot2)
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     SCC$SCC <- as.character(SCC$SCC)
     NEI_SCC <- left_join(NEI, SCC, by="SCC")
     NEI_SCC <- data.table(NEI_SCC)
     ## filter to coal specific type labels in SCC Level Three
     subtypes <- unique(SCC$SCC.Level.Three)
     coalsubtypes <- grep("Coal", subtypes)
     subtypes <- data.table(subtypes)
     coaltypenames <- subtypes[coalsubtypes,]
     coaltypenames2 <- as.character(coaltypenames$subtypes)
     ## Manipulate from main data table to subset
     coalsources <- NEI_SCC[SCC.Level.Three %in% coaltypenames2]
     totals <- coalsources[,.(Emissions.Sum=sum(Emissions)), by=year]
     qplot(year, Emissions.Sum, data=totals, xlab="Observation Year", ylab="Total PM2.5 Emissions in Tons", main="Emissions from Coal Sources") + geom_smooth(method=lm)
     ## Crate plot file
     ggsave("plot4.png", width=8, height=5)
}