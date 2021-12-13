setwd("/Users/davidhughes/R/map_routes/001_map_my_route/")
getwd()

#Get data
library(plotKML)
?plotKML

edale_skyline <- readGPX("Edale Skyline.gpx")
str(edale_skyline)

#Visualize data 1
#REF: https://scriptsandstatistics.wordpress.com/2018/03/29/how-to-plot-gps-data-using-r-ggplot2-and-ggmaps/

es_df <- edale_skyline$tracks[[1]][[1]]
head(es_df)


ggplot(es_df, aes(x = lon, y = lat)) +
  coord_quickmap() +
  geom_point()


#Visualize data 2
#REF: https://scriptsandstatistics.wordpress.com/2018/03/29/how-to-plot-gps-data-using-r-ggplot2-and-ggmaps/

install.packages("ggmap")
library(ggmap)

#Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
# Please cite ggmap if you use it! See citation("ggmap") for details.

mapImageData <- get_googlemap(center = c(lon = mean(es_df$lon), lat = mean(es_df$lat)),
                              zoom = 10,
                              color = 'bw',
                              scale = 1,
                              maptype = "terrain")

#Error: Google now requires an API key.
#See ?register_google for details.


ggmap(mapImageData, extent = "device") + # removes axes, etc.
  geom_point(aes(x = lon,
                 y = lat),
             data = es_df,
             colour = "red3",
             alpha = .1,
             size = .1)