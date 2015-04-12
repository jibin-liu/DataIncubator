library(ggplot2)

## Create functions
# unitRound - This is the function used to round up/down the number of units
unitRound <- function(x) {
    unit <- x %/% 1
    mode <- x %% 1
    ifelse(mode >= 0.75, unit + 1, unit)
}

# unitCalculate - This is the function used to calculate the number of units
unitCalculate <- function(df) {
    
    # Loop through each row to find the FAR and density factor for the lot,
    # and then calculate the number of units
    for (i in 1:nrow(df)) {
        index <- match(df[i, ]$ZoneDist1, zoningDensity$Zone)
        if (!is.na(index)) {
            if ((index >= 1) && (index <= 19)) {
                df[i, ]$ResidentialCategory <- "Low Density"
            } else if ((index > 19) && (index <= 28)) {
                df[i, ]$ResidentialCategory <- "Medium Density"
            } else if ((index > 28) && (index <= 39)) {
                df[i, ]$ResidentialCategory <- "High Density"
            } else if ((index > 39) && (index <= 73)) {
                df[i, ]$ResidentialCategory <- "Commercial-Residental Mix"
            }
        }
        FAR <- zoningDensity[index, ]$FAR
        density <- zoningDensity[index, ]$DensityFactor
        df[i, ]$UnitNumber <- unitRound(df[i, ]$LotArea * FAR / density)
    }
    
    # Return data frame
    df
}


## Main body
# Donwload PLUTO data
PLUTOUrl <- "http://www.nyc.gov/html/dcp/download/bytes/nyc_pluto_14v2.zip"
download.file(PLUTOUrl, "./data/nyc_pluto_14v2.zip", mode = "wb")

# Unzip and combine data
unzip("./data/nyc_pluto_14v2.zip", files = c("BK.csv", "BX.csv", "MN.csv",
                                             "QN.csv", "SI.csv"),
      exdir = "./data/nyc_pluto_14v2")
BK <- read.csv("./data/nyc_pluto_14v2/BK.csv", stringsAsFactors = FALSE)
BX <- read.csv("./data/nyc_pluto_14v2/BX.csv", stringsAsFactors = FALSE)
MN <- read.csv("./data/nyc_pluto_14v2/MN.csv", stringsAsFactors = FALSE)
QN <- read.csv("./data/nyc_pluto_14v2/QN.csv", stringsAsFactors = FALSE)
SI <- read.csv("./data/nyc_pluto_14v2/SI.csv", stringsAsFactors = FALSE)
PLUTO <- rbind(BK, BX, MN, QN, SI)

# Subset residental-zoned vacant land (V0, V3, and V9)
PLUTO2 <- PLUTO[(PLUTO$BldgClass == "V0") |
                    (PLUTO$BldgClass == "V3") |
                    (PLUTO$BldgClass == "V9"), ]

# A table of residential zoning density (Dwelling Unit Factor) was created
# based on the regulation from "NYC DCP Zoning Handbook".
zoningDensity <- read.csv("./data/ZoningFARDensity.csv")

# Calculate number of units
PLUTO2$UnitNumber <- NA
PLUTO2$ResidentialCategory <- NA
PLUTO2 <- unitCalculate(PLUTO2)

## Explotary plot
PLUTO3 <- PLUTO2[!is.na(PLUTO2$ResidentialCategory), ]
# Potential housing unit in each borough
UnitNumber_Borough <- tapply(PLUTO3$UnitNumber, PLUTO3$Borough, sum)
barplot(UnitNumber_Borough, ylab = "Unit Number")
# Residental housing category in each borough
qplot(ResidentialCategory, UnitNumber, data = PLUTO3, 
      stat="summary", fun.y="sum", geom = "bar", facets = Borough~.,
      xlab = "Residential Category", ylab = "Unit Number")
