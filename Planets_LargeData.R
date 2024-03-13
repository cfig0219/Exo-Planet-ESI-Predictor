#installs the necessary packages to read .csv files
#install.packages("tidyverse")
library(tidyverse)

#creates a planets variable to read the .csv file into a large data table
planets <- read.csv(file="PS_2022.11.09_09.55.33.csv", skip=96, sep=",")

#creates a filtered variant of table above, -c skips over certain columns
filtered <- read.csv(file="PS_2022.11.09_09.55.33.csv", skip=96, sep=",")[-c(2:11,13:19,21:27,29:40,42:44,46:51,53:55,56:59,61:92)]

#generates a .csv file from the filtered data
write.csv(filtered, "Planets_Filtered.csv", row.names=FALSE)
#reads the .csv file of filtered data
averages <- read.csv(file="Planets_filtered.csv", sep=",")

#filters out any nulls or zeros one column at a time
library(dplyr)
orbit <- subset(averages, !is.na(pl_orbper))
radius <- subset(orbit, !is.na(pl_rade))
mass <- subset(radius, !is.na(pl_bmasse))
flux <- subset(mass, !is.na(pl_insol))
temperature <- subset(flux, !is.na(pl_eqt))
startemp <- subset(temperature, !is.na(st_teff))
starmass <- subset(startemp, !is.na(st_mass))

#imports smaller .csv file with habitable planets
habitable <- read.csv(file="Habitable_Planets.csv", sep=",")
#appends habitable graph to star mass graph
organized <- rbind(habitable, starmass)

#exports organized .csv data
write.csv(organized, "Planets_Organized.csv", row.names=FALSE)

#creates renamed table
oldnames = c("pl_name", "pl_orbper", "pl_rade", "pl_bmasse", "pl_insol", "pl_eqt", "st_teff", "st_mass")
newnames = c("Planet_Name", "Orbit_Period", "Planet_Radius", "Planet_Mass", "Stellar_Flux", "Temperature", "Star_Temperature", "Star_Mass")
renamed <- organized %>% rename_at(vars(oldnames), ~ newnames)
#removes duplicates
nodups <- renamed %>% distinct(Planet_Name, .keep_all=TRUE)

#adds columns based on calculations
planetdensity <- nodups %>% mutate(Planet_Density=(5.51*(4.19*(Planet_Mass/((4/3)*(22/7)*(Planet_Radius^3))))))
escape <- planetdensity %>% mutate(Escape_Velocity=(11.186*(0.7072*sqrt((Planet_Mass*2)/Planet_Radius))))
gravity <- escape %>% mutate(Gravity=(9.82*(Planet_Mass/(Planet_Radius)^2)))

#ESI variants analysis
#ESI Standard
standard <- gravity %>% mutate(ESI_Standard=
(1-sqrt((1/2)*(((Stellar_Flux-1)/(Stellar_Flux+1))^2+
               ((Planet_Radius-1)/(Planet_Radius+1))^2))))
#ESI Weighted
weighted <- standard %>% mutate(ESI_Weighted=
(1-sqrt((1/5)*(((Stellar_Flux-1)/(Stellar_Flux+1))^2+
         (0.57*((Planet_Radius-1)/(Planet_Radius+1))^2)+
         (1.07*((Planet_Density-5.51)/(Planet_Density+5.51))^2)+
          (0.7*((Escape_Velocity-11.186)/(Escape_Velocity+11.186))^2)+
         (5.58*((Temperature-288)/(Temperature+288))^2)))))
#ESI Custom
custom <- weighted %>% mutate(ESI_Custom=
(1-sqrt((1/9)*(((Stellar_Flux-1)/(Stellar_Flux+1))^2+
               ((Planet_Radius-1)/(Planet_Radius+1))^2+
               ((Gravity-9.82)/(Gravity+9.82))^2+
               ((Planet_Mass-1)/(Planet_Mass+1))^2+
               ((Temperature-288)/(Temperature+288))^2+
               ((Star_Temperature-5778)/(Star_Temperature+5778))^2+
               ((Star_Mass-1)/(Star_Mass+1))^2+
               ((Orbit_Period-365)/(Orbit_Period+365))^2+
               ((Planet_Density-5.51)/(Planet_Density+5.51))^2))))
#ESI Revised
revised <- custom %>% mutate(ESI_Revised=
(1-sqrt((1/9)*((3.2*((Stellar_Flux-1)/(Stellar_Flux+1))^2)+
               (0.57*((Planet_Radius-1)/(Planet_Radius+1))^2)+
               (4.75*((Gravity-9.82)/(Gravity+9.82))^2)+
               (0.2*((Planet_Mass-1)/(Planet_Mass+1))^2)+
               (10.58*((Temperature-288)/(Temperature+288))^2)+
               ((Star_Temperature-5778)/(Star_Temperature+5778))^2+
               ((Star_Mass-1)/(Star_Mass+1))^2+
               ((Orbit_Period-365)/(Orbit_Period+365))^2+
               (2.8*((Planet_Density-5.51)/(Planet_Density+5.51))^2)))))

#exports all usable .csv data
write.csv(revised, "All_Data.csv", row.names=FALSE)

#gets top 10 from each analysis
topstandard <- revised[-c(13:15)] %>% arrange(desc(ESI_Standard)) %>% slice(1:11)
topweighted <- revised[-c(12,14:15)] %>% arrange(desc(ESI_Weighted)) %>% slice(1:11)
topcustom <- revised[-c(12:13,15)] %>% arrange(desc(ESI_Custom)) %>% slice(1:11)
toprevised <- revised[-c(12:14)] %>% arrange(desc(ESI_Revised)) %>% slice(1:11)

#generates .csv files from top 10s
write.csv(topstandard, "Top_Standard.csv", row.names=FALSE)
write.csv(topweighted, "Top_Weighted.csv", row.names=FALSE)
write.csv(topcustom, "Top_Custom.csv", row.names=FALSE)
write.csv(toprevised, "Top_Revised.csv", row.names=FALSE)

#rm (remaned) #removes any unneeded table

#import for exportation of data into SQL server
#install.packages("RODBC")
library(RODBC)

#writes tables into SQL database
#sqlSave(revised, all_data, rownames = FALSE)
#revised <- DBI::dbConnect("Driver={SQLServer};Server=10.156.192.30;Uid=figuerc1;Pwd=U00342906")
