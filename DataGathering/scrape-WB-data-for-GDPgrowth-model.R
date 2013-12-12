library(gdata)
library(stringr)
require(plyr); require(reshape2) # Prabhas says @hadley is awesome!

setwd("~/Dropbox/ENI/ENI-slides/EnergyDemandModeling")

scrape_WB_country_data <- function(CODE)
{
  #build URL string with appropriate country code to pull World Bank database from 
  country.db <- read.xls(str_c('http://api.worldbank.org/datafiles/',CODE,'_Country_MetaData_en_EXCEL.xls'), sheet=1)
  #subset country database of interest to only pull indicators of interest with for year 2009
  short <- country.db[country.db$Indicator.Code %in% (c('EG.USE.COMM.KT.OE', #primary energy demand
                                                        'SP.POP.GROW', ##Population growth (annual %)
                                                        'SP.POP.TOTL', #Population, total
                                                        'EG.USE.COMM.GD.PP.KD', #Energy use (kg of oil equivalent) per $1,000 GDP (constant 2005 PPP)
                                                        'EG.USE.COMM.KT.OE', #Energy use (kt of oil equivalent)
                                                        'NY.GDP.MKTP.PP.CD', #GDP, PPP (current international $)
                                                        'NY.GDP.PCAP.PP.CD', #GDP per capita, PPP (current international $)
                                                        'NY.GDP.MKTP.KD.ZG' #GDP growth (annual %)
                                                        )),]
  return(short)
}

#Sub-Saharan Africa Countries
countries <- list("AGO" = "Angola", 
                  "BEN" = "Benin",
                  "BWA" = "Botswana",
                  "BFA" = "Burkina Faso",
                  "BDI" = "Burundi",
                  "CMR" =  "Cameroon",
                  "CPV" = "Cape Verde",
                  "CAF" = "Central Africa Republic",
                  "TCD" = "Chad Republic",
                  "COM" = "Comoros",
                  "COG" = "Congo",
                  "COD" = "Congo Dem Rep",
                  "CIV" = "Cote de'Ivoire",
                  "CIV" = "Cote de'Ivoire",
                  "DJI" = "Djibouti",
                  "ERI" =  "Eritrea",
                  "ETH" = "Ethiopia",
                  "GAB" = "Gabon",
                  "GMB" = "Gambia",
                  "GHA" = "Ghana",
                  "GNB" = "Guinea-Bissau",
                  "KEN" = "Kenya",
                  "LSO" = "Lesotho",
                  "LBR" = "Liberia",
                  "MDG" = "Madagascar",
                  "MWI" = "Malawi",
                  "MLI" = "Mali",
                  "MRT" = "Mauritania",
                  "MUS" = "Mauritius",
                  "MOZ" = "Mozambique",
                  "NAM" = "Nambia",
                  "NER" = "Niger Republic",
                  "NGA" = "Nigeria",
                  "RWA" = "Rwanda",
                  "STP" = "Sao Tome",
                  "SEN" = "Senegal",
                  "SYC" = "Seychelles",
                  "SLE" = "sierra Leone",
                  "SOM" = "Somalia",
                  "ZAF" = "South Africa",
                  "SSD" = "south Sudan",
                  "SDN" = "Sudan",
                  "SWZ"= "Swaziland",
                  "TZA" = "Tanzania",
                  "TGO" =  "Togo",
                  "UGA" = "Uganda",
                  "ZMB" = "Zambia",
                  "ZWE" = "Zimbabwe",
                  #Initially Omitted Countries
                  "MYT" = "Myayotte",
                  "GIN" = "Guinea",
                  "GNQ" = "Equatorial Guinea",
                  #USA Data
                  "USA" = "USA"
)

scraped_data <- llply(names(countries), 
                      scrape_WB_country_data) # boom! a list of dataframes. will take forever to run though!

names(scraped_data) <- names(countries)

#combine and export
year <- 'X2010'

wb_data_flat <- ldply(scraped_data, function(df) { df[[year]]}) # unfortunately, ldply uses an rbind at the end, so our data is flipped around
wb_data_tall <- melt(wb_data_flat, id.vars='.id', value.name=year) # flip the data.frame
wb_data_tall <- cbind(scraped_data$AGO[,c("Indicator.Name","Indicator.Code")], wb_data_tall) # bring in indicator name and code
wb_data_tall$variable <- NULL

             
write.csv(wb_data_tall, "WorldBankKeyEnergyUsage-SubSaharanAfrica-1990-20131211.csv", row.names=F)