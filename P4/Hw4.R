---
  title: "hw4"
output: html_document
date: "2022-10-31"
---
  
  Load libraries

```{r}
library(sf)
library(here)
library(janitor)
library(tidyverse)
library(readr)
```

read in data

```{r}
world_countries <- sf::st_read(here("prac4_data", "World_Countries_(Generalized)", "World_Countries__Generalized_.shp"))

gender_inequality <- read.csv(here::here("prac4_data", "gender inequality (1990-2021).csv"))

gender_inequality <- gender_inequality %>%
  clean_names()
```

creat column
```{r}
gend_in_diff <- gender_inequality %>%
  mutate(diff1910 = gdi_2019 - gdi_2010)
```

join data
```{r}
world_gdi <- world_countries%>%
  dplyr::left_join(.,
                   gend_in_diff,
                   by = c("COUNTRY" = "country"))
```

plot map
```{r}
library(tmap)

tm_shape(world_gdi) + 
  tm_polygons("diff1910", 
              # style="pretty",
              palette="Blues",
              midpoint=NA,
              #title="Number of years",
              alpha = 0.5) + 
  tm_compass(position = c("left", "bottom"),type = "arrow") + 
  tm_scale_bar(position = c("left", "bottom")) +
  tm_layout(title = "difference in gender inequality between 2010 and 2019", 
            legend.position = c("right", "bottom"))

```