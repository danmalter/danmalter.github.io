---
title: "Jon Lester June 28, 2014 Pitches vs. NY Yankeees"
author: "Danny Malter"
date: "December 22, 2014"
output: html_document
---


{% highlight r %}
setwd("~/pitchRx/Jon Lester")
{% endhighlight %}

Load in the required packages

{% highlight r %}
require(mosaic)
require(ggplot2)
require(dplyr)
library(plyr)
require(ggplot2)
require(RSQLite)
require(pitchRx)
require(knitr)
require(animation)
{% endhighlight %}

Create a pitchRx database between the date ranges

{% highlight r %}
db20140628 <- src_sqlite("MLB20140628.sqlite3", create = TRUE)
scrape(start = "2014-06-28", end = "2014-06-28", connect = db20140628$con)
{% endhighlight %}

Join the location and names table into a new que table.  Select Jon Lester.

{% highlight r %}
locations <- select(tbl(db20140628, "pitch"), 
                    pitch_type, px, pz, des, num, gameday_link, inning)
names <- select(tbl(db20140628, "atbat"), pitcher_name, batter_name, 
                num, b_height, gameday_link, event, stand)
que <- inner_join(locations, filter(names, 
                                    pitcher_name == "Jon Lester"),
                  by = c("num", "gameday_link"))
pitchfx <- collect(que)

# Last pitch of an at-bat
last.pitch <- ddply(pitchfx, .(num), function(x) x[nrow(x), ])
{% endhighlight %}

Create a new column with the full pitch type name.  Full pitch type is not to be used in strikeFX.

{% highlight r %}
pitchfx$pitch_type_full <- factor(pitchfx$pitch_type,
                  levels=c("FF", "FC", "SI", "CH", "CU"),
                  labels=c("Four-seam FB","Fastball (cutter)",
                           "Sinker","Changeup", "Curveball"))
{% endhighlight %}

Count of each type of pitch

{% highlight r %}
table(pitchfx$pitch_type_full)
{% endhighlight %}



{% highlight text %}
## 
##      Four-seam FB Fastball (cutter)            Sinker          Changeup 
##                53                30                13                 4 
##         Curveball 
##                18
{% endhighlight %}

Count of each type of pitch by batter stand and inning

{% highlight r %}
with(pitchfx, table(pitch_type_full, stand))
{% endhighlight %}



{% highlight text %}
##                    stand
## pitch_type_full      L  R
##   Four-seam FB      19 34
##   Fastball (cutter) 13 17
##   Sinker             2 11
##   Changeup           1  3
##   Curveball          6 12
{% endhighlight %}



{% highlight r %}
with(pitchfx, table(pitch_type_full, inning))
{% endhighlight %}



{% highlight text %}
##                    inning
## pitch_type_full      1  2  3  4  5  6  7  8
##   Four-seam FB      10  5 13  4  3  8  4  6
##   Fastball (cutter)  3  3  4  3  5  6  3  3
##   Sinker             2  1  1  1  1  2  1  4
##   Changeup           0  1  0  1  1  1  0  0
##   Curveball          2  3  1  2  0  3  2  5
{% endhighlight %}

Count of pitch type by umpire call

{% highlight r %}
ball.strike <- subset(pitchfx, des == "Ball" | des == "Swinging Strike" | des == "Called Strike")
ggplot(ball.strike, aes(x = pitch_type_full, fill = des)) +
    geom_bar(position = "dodge") +
    guides(fill=guide_legend(title='Call')) +
    ggtitle("Count of Pitch Type") +
    xlab('Pitch Type') +
    ylab('Count')
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-8-1.png) 

Pitch type thrown to each type of batter

{% highlight r %}
# Overlay a strike zone
topKzone <- 3.5
botKzone <- 1.6
inKzone <- -0.95
outKzone <- 0.95
kZone <- data.frame(
  x=c(inKzone, inKzone, outKzone, outKzone, inKzone),
  y=c(botKzone, topKzone, topKzone, botKzone, botKzone)
)

ggplot(pitchfx, aes(px, pz, color=pitch_type_full)) + geom_point() +
  geom_path(aes(x, y), data=kZone, lwd=2, col="red") +
  ylim(0, 5) + facet_wrap(~ batter_name, ncol=3) +
  scale_color_discrete(name="Pitch Type") +
  ggtitle("Pitch Type by Player (Catcher's Perspective)")
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-9-1.png) 

Derek Jeter's pitches broken down

{% highlight r %}
jeter <- subset(pitchfx, batter_name=="Derek Jeter")
jeter.last <- ddply(jeter, .(num), function(x) x[nrow(x), ])

ggplot(jeter.last, aes(px, pz, color=pitch_type_full)) + geom_point() +
  geom_path(aes(x, y), data=kZone, lwd=2, col="red") +
  ylim(0, 5) + facet_wrap(~ event, ncol=3) +
  scale_color_discrete(name="Pitch Type") +
  ggtitle("Derek Jeter's Events by Pitch (Catcher's Perspective)")
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-10-1.png) 

{% highlight r %}
ggplot(jeter, aes(px, pz, color=pitch_type_full)) + geom_point() +
  geom_path(aes(x, y), data=kZone, lwd=2, col="red") +
  ylim(0, 5) + facet_wrap(~ des, ncol=3) +
  scale_color_discrete(name="Pitch Type") +
  ggtitle("Derek Jeter's Description by All Pitches (Catcher's Perspective)")
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-10-2.png) 

Visualize Pitches
All pitches

{% highlight r %}
strikeFX(pitchfx, geom="tile", layer=facet_grid(.~stand))
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-11-1.png) 

Just Called Strikes

{% highlight r %}
lester.called.strikes <- subset(pitchfx, des == "Called Strike")
strikeFX(lester.called.strikes, geom="tile", layer=facet_grid(.~stand))
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-12-1.png) 

Just Balls

{% highlight r %}
lester.balls <- subset(pitchfx, des == "Ball")
strikeFX(lester.balls, geom="tile", layer=facet_grid(.~stand))
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-13-1.png) 

Probability of a strike

{% highlight r %}
require(mgcv)
{% endhighlight %}


{% highlight r %}
noswing <- subset(pitchfx, des %in% c("Ball", "Called Strike"))
noswing$strike <- as.numeric(noswing$des %in% "Called Strike")
m1 <- bam(strike ~ s(px, pz, by=factor(stand)) +
          factor(stand), data=noswing, family = binomial(link='logit'))
strikeFX(noswing, model=m1, layer=facet_grid(.~stand))
{% endhighlight %}

![center](/figs/lester2014/unnamed-chunk-15-1.png) 

Animation of pitches

{% highlight r %}
data <- scrape(start="2014-06-28", end="2014-06-28")
{% endhighlight %}



{% highlight r %}
names <- c("Jon Lester")
atbats <- subset(data$atbat, pitcher_name %in% names)
pitchFX <- plyr::join(atbats, data$pitch, by=c("num", "url"), type="inner")
pitch.fast <- subset(pitchFX, pitch_type %in% c("FF", "FC", "SI"))
pitch.offspeed <- subset(pitchFX, pitch_type %in% c("CU", "CH"))

require(animation)

setwd("~/pitchRx")
animateFX(pitch.fast, layer=list(facet_grid(pitcher_name~stand, labeller = label_both), theme_bw(), coord_equal()))
animateFX(pitch.offspeed, layer=list(facet_grid(pitcher_name~stand, labeller = label_both), theme_bw(), coord_equal()))
ani.options(interval = 0.1)
saveHTML({animateFX(pitch.fast, layer=list(facet_grid(pitch_type~stand, labeller = label_both), theme_bw(), coord_equal()))}, img.name="lester_fast_pitches")
saveHTML({animateFX(pitch.offspeed, layer=list(facet_grid(pitch_type~stand, labeller = label_both), theme_bw(), coord_equal()))}, img.name="lester_slow_pitches")
{% endhighlight %}
Full Animation: http://www.ariball.com/news/12232014lester.html

