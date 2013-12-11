library(gdata)
library(stringr)
#India Data

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
setwd("~/Dropbox/ENI/ENI-slides/EnergyDemandModeling")

#Sub-Saharan Agrica Data
ago <- scrape_WB_country_data('AGO') #angola
ben <- scrape_WB_country_data('BEN') #Benin
bwa <- scrape_WB_country_data('BWA') # Botswana
bfa <- scrape_WB_country_data('BFA') # Burkina Faso
bdi <- scrape_WB_country_data('BDI') # Burundi
cmr <- scrape_WB_country_data('CMR') # Cameroon
cpv <- scrape_WB_country_data('CPV') #Cape Verde
caf <- scrape_WB_country_data('CAF') # Central Africa Republic
tcd <- scrape_WB_country_data('TCD') #Chad Republic
com <- scrape_WB_country_data('COM') #Comoros
cog <- scrape_WB_country_data('COG') #Congo
cod <- scrape_WB_country_data('COD') #Congo Dem Rep
civ <- scrape_WB_country_data('CIV') # Cote de'Ivoire 
civ <- scrape_WB_country_data('CIV') # Cote de'Ivoire 
dji <- scrape_WB_country_data('DJI') #Djibouti
eri <- scrape_WB_country_data('ERI') #Eritrea
eth <- scrape_WB_country_data('ETH') #Ethiopia
gab <- scrape_WB_country_data('GAB') #Gabon
gmb <- scrape_WB_country_data('GMB') #Gambia
gha <- scrape_WB_country_data('GHA') # Ghana
gnb <- scrape_WB_country_data('GNB') #Guinea-Bissau
ken <- scrape_WB_country_data('KEN') #kenya
lso <- scrape_WB_country_data('LSO') #Lesotho
lbr <- scrape_WB_country_data('LBR') #Liberia
mdg <- scrape_WB_country_data('MDG') #Madagascar
mwi <- scrape_WB_country_data('MWI') #Malawi
mli <- scrape_WB_country_data('MLI') #Mali
mrt <- scrape_WB_country_data('MRT') #Mauritania
mus <- scrape_WB_country_data('MUS') #Mauritius
moz<- scrape_WB_country_data('MOZ') #Mozambique
nam<- scrape_WB_country_data('NAM') #Nambia
ner <- scrape_WB_country_data('NER') #Niger Republic
nga <- scrape_WB_country_data('NGA') #Nigeria
rwa <- scrape_WB_country_data('RWA') #Rwanda
stp <- scrape_WB_country_data('STP') #Sao Tome
sen <- scrape_WB_country_data('SEN') #Senegal
syc <- scrape_WB_country_data('SYC') #Seychelles
sle <- scrape_WB_country_data('SLE') #sierra Leone
som <- scrape_WB_country_data('SOM') #Somalia
zaf <- scrape_WB_country_data('ZAF') #South Africa
ssd <- scrape_WB_country_data('SSD') #south Sudan
sdn <- scrape_WB_country_data('SDN') #Sudan
swz <- scrape_WB_country_data('SWZ') #Swaziland
tza <- scrape_WB_country_data('TZA') #Tanzania
tgo <- scrape_WB_country_data('TGO') #Togo
uga <- scrape_WB_country_data('UGA') #Uganda
zmb <- scrape_WB_country_data('ZMB') #Zambia
zwe <- scrape_WB_country_data('ZWE') #Zimbabwe

myt <- scrape_WB_country_data('MYT') #Myayotte
gin <- scrape_WB_country_data('GIN') #Guinea 
gnq <- scrape_WB_country_data('GNQ') #Equatorial Guinea 

#USA Data
usa <- scrape_WB_country_data('USA')


#combine and export
year <- 'X2010'
wb.data <- cbind(ago[,c('Indicator.Name','Indicator.Code',year)],
                 ben[,year],
                 bwa[,year],
                 bfa[,year],
                 bdi[,year],
                 cmr[,year],
                 cpv[,year],
                 caf[,year],
                 tcd[,year],
                 com[,year],
                 cog[,year],
                 cod[,year],
                 civ[,year],
                 dji[,year],
                 eri[,year],
                 eth[,year],
                 gab[,year],
                 gmb[,year],
                 gha[,year],
                 gnb[,year],
                 ken[,year],
                 lso[,year],
                 lbr[,year],
                 mdg[,year],
                 mwi[,year],
                 mli[,year],
                 mrt[,year],
                 mus[,year],
                 moz[,year],
                 nam[,year],
                 ner[,year],
                 nga[,year],
                 rwa[,year],
                 stp[,year],
                 sen[,year],
                 syc[,year],
                 sle[,year],
                 som[,year],
                 zaf[,year],
                 ssd[,year],
                 sdn[,year],
                 swz[,year],
                 tza[,year],
                 tgo[,year],
                 uga[,year],
                 zmb[,year],
                 zwe[,year],
                 myt[,year],
                 gin[,year],
                 gnq[,year],
                 usa[,year]
)
             
write.csv(wb.data, "WorldBankKeyEnergyUsage-SubSaharanAfrica-1990-20131211.csv", row.names=F)