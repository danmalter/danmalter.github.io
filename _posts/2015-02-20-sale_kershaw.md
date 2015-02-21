---
layout: post
title: "Blog with Knitr and Jekyll"
description: ""
category: r
tags: [knitr, jekyll, tutorial]
---
{% include JB/setup %}


```r
setwd("~/pitchRx/ChiSox")
library(devtools)
install_github("tdhock/animint")
library(ggplot2)
library(tidyr)
library(animint)
library(pitchRx)
library(dplyr)
library(servr)
require(animation)
```


```r
mlb.data <- scrape(start="2014-09-24", end="2014-10-1")
names <- c("Chris Sale", "Clayton Kershaw")
atbats <- subset(mlb.data$atbat, pitcher_name %in% names)
pitchFX <- plyr::join(atbats, mlb.data$pitch, by=c("num", "url"), type="inner")
pitches <- subset(pitchFX, pitch_type %in% c("FF", "SI", "SL", "CU", "CH"))
dat <- getLocations(pitches, pitcher_name, pitch_type, summarise = TRUE)
```

```
## Error in eval(expr, envir, enclos): could not find function "getLocations"
```

```r
p <- ggplot() + 
  geom_point(aes(x = x, y = z, color = pitch_type, 
                 showSelected = frame), data = dat) + 
  facet_grid(. ~ pitcher_name) + ylim(0, 7) + xlim(-3, 3) +
  coord_equal() + xlab("") + ylab("Height from ground") 
```

```
## Error in do.call("layer", list(mapping = mapping, data = data, stat = stat, : object 'dat' not found
```

```r
p
```

```
## Error in eval(expr, envir, enclos): object 'p' not found
```


```r
plist <- list(strikezone = p + theme_animint(width = 800),            
              # 'animate' over the frame variable
              time = list(variable = "frame", ms = 100),
              # use smooth transitions
              duration = list(frame = 250))
```

```
## Error in eval(expr, envir, enclos): object 'p' not found
```

```r
structure(plist, class = "animint")
```

```
## Error in structure(plist, class = "animint"): object 'plist' not found
```


```r
ggstrike <- function() {
  ggplot() + facet_grid(pitcher_name ~ stand) +
  ylim(0, 7) + xlim(-3, 3) + coord_equal() + xlab("") + 
  ylab("")
}

# overview (not filtered by anything)
strike <- ggstrike() + theme(legend.position = "none") +
          geom_point(data = pitches,
                    aes(x = px, y = pz, color = pitch_type))

# filter by date
strike_date <- ggstrike() + geom_point(data = pitches,
                        aes(x = px, y = pz, color = pitch_type, 
                            showSelected = date))
```


```r
n_pitches <- pitches %>%
  group_by(pitch_type, pitcher_name, date) %>%
  summarise(count = n()) %>% 
  mutate(group = paste(pitcher_name, pitch_type, sep = ": ")) %>%
  mutate(dated = as.Date(date, format = "%Y_%m_%d")) %>%
  data.frame %>% mutate(max_n = max(count))

# time series plot with clickSelects
series <- ggplot() + 
  geom_line(aes(x = dated, y = count, colour = pitch_type, 
                linetype = pitcher_name, group = group), data = n_pitches) + 
  stat_identity(aes(x = dated, y = max_n, clickSelects = date, alpha = 0.2), 
                geom = "bar", data = n_pitches) + scale_alpha(guide = 'none') +
  xlab("") + ylab("Number of pitches") + theme_animint(width = 800, height = 200)

plist2 <- list(strike = strike,
               strikeDate = strike_date,
               series = series,
               selector.types = list(date = "multiple"))

structure(plist2, class = "animint")
```

<script type="text/javascript" src="unnamedchunk5/vendor/d3.v3.js"></script>
<script type="text/javascript" src="unnamedchunk5/animint.js"></script><p></p>
<div id='unnamedchunk5'></div>
<script>var plot = new animint("#unnamedchunk5", "unnamedchunk5/plot.json");</script>
