---
layout: post
title: "PitchRx and Animint"
author: Danny Malter
categories: [PITCHfx, interactive graphics]
tags: [pitchRx, animint]
---
{% raw %}


```r
library(devtools)
devtools::source_gist(id = "da555f08f3c9ba2c0b8e")
install_github("tdhock/animint")
library(ggplot2)
library(tidyr)
library(animint)
library(pitchRx)
library(dplyr)
library(servr)
require(animation)

mlb.data <- scrape(start="2014-5-24", end="2014-6-15")
names <- c("Chris Sale", "Clayton Kershaw")
atbats <- subset(mlb.data$atbat, pitcher_name %in% names)
pitchFX <- plyr::join(atbats, mlb.data$pitch, by=c("num", "url"), type="inner")
pitches <- subset(pitchFX, pitch_type %in% c("FF", "SI", "SL", "CU", "CH"))
dat <- getLocations(pitches, pitcher_name, pitch_type, summarise = TRUE)

counts <- ddply(pitches, c("pitch_type", "pitcher_name", "type"),
                summarise, count = length(px))
viz <- list(bars = ggplot() +
              geom_bar(aes(x = factor(pitch_type), y = count,
                           fill = pitcher_name, clickSelects = type),
                      position = "dodge", stat = "identity", data = counts),
            scatter = ggplot() +
              geom_point(aes(start_speed, end_speed, fill = pitcher_name, showSelected = type),
                         alpha = 0.65, data = pitches))
gg2animint(viz)
animint2dir(viz)
```
{% endraw %}


<iframe src="http://danmalter.github.io/pitchRx/sale_kershaw1/" width="600" height="800"> </iframe>
