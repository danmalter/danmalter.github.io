---
title: "Classifying MLB Pitch Types Using Neural Nets"
layout: post
comments: true
category: R
---

{% raw %}

# Classifying Jake Arrieta's Pitch Types #

Major League Baseball currently has high definition camera's capturing everything from the release point of the ball being thrown to the amount of horizontal spin on the ball.  Rather than having a person manually write down what each pitch type is, an algorithm does this automatically.  The goal of this project is to use MLB's classifications to create run a neural network of my own that will match that of MLB.

The training dataset being used are all of Jake Arrieta's pitches thrown in the 2016 regualar season and the model is validated on Game 2 of the 2016 world series in which Arrieta threw 98 pitches.


- Load in the required packages

```r
library(nnet)
library(caret)
library(pitchRx)
library(dplyr)
library(plyr)
library(RSQLite)
library(devtools)
```

The following script was used to scrape data from the 2016 season and filtered for Jake Arrieta's pitches.  A similar script was ran for only data on 10/26/16, the date of Game 2 from the 2016 World Series.

```r
db2016 <- src_sqlite("MLB2015_All.sqlite3", create = FALSE)
scrape(start = "2016-04-01", end = "2016-10-01", connect = db2016$con)

locations <- select(tbl(db2016, "pitch"), 
                    pitch_type, start_speed, end_speed, num, gameday_link,
                    pfx_x, pfx_z, vx0, vy0, vz0, ax, ay, az, break_y, 
                    break_angle, break_length, spin_dir, spin_rate)
names <- select(tbl(db2016, "atbat"), pitcher_name, batter_name, 
                num, gameday_link, stand)
que <- inner_join(locations, filter(names, pitcher_name == "Jake Arrieta"),
                  by = c("num", "gameday_link"))

pitchfx <- collect(que, n=Inf)
pitchfx <- as.data.frame(pitchfx)
arrieta <- subset(pitchfx, select = -c(pitcher_name, batter_name, stand, num, gameday_link))
```

```r
# import function for plotting nnet
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

# Read in 2016 season data and Game 2 of the World Series
arrieta <- read.csv('~/arrieta.csv')
validation <- read.csv('~/world_series.csv')

# Split the regular season data into a new training and testing set.
intrain <- createDataPartition(arrieta$pitch_type, p=0.7, list=FALSE)
myTrain <- arrieta[intrain,]
myTest <- arrieta[-intrain,]
head(myTrain)
```

## Example of the dataset ##

```r
  pitch_type start_speed end_speed pfx_x pfx_z    vx0      vy0     vz0      ax     ay      az
2         SL        91.2      85.3  4.30  4.92  6.892 -133.311  -7.881   7.829 25.485 -23.139
3         SI        94.6      87.4 -9.14  5.68  9.580 -138.194  -7.213 -17.751 29.649 -21.066
4         FF        92.6      84.7 -7.68  9.66 12.007 -135.195  -4.506 -14.149 30.639 -14.305
5         SI        92.5      84.2 -8.14  7.79 11.627 -134.928  -7.360 -14.827 32.771 -17.919
6         SI        94.0      85.1 -9.72  8.95 12.134 -137.136  -5.906 -18.203 35.086 -15.348
9         FF        94.1      87.3 -6.69  9.64 10.836 -136.968 -12.245 -12.816 27.952 -13.644
  break_y break_angle break_length spin_dir spin_rate
2    23.9       -20.1          5.8  139.091  1301.037
3    23.8        35.0          5.7  237.962  2198.319
4    23.8        36.8          4.2  218.372  2445.865
5    23.7        31.6          5.2  226.126  2211.533
6    23.7        42.0          4.9  227.250  2622.399
9    23.8        33.7          4.1  214.668  2386.429
```

## Neural Net from nnet Package ##

```r
set.seed(353)
nn_mod1 <- nnet(pitch_type ~ ., data = myTrain, 
           size = 10, rang = 0.1, decay = 5e-04, 
           maxit = 1000)

test.pred <- predict(nn_mod1, newdata = myTest, type = "class")
table(test.pred, myTest$pitch_type)
```

```r
test.pred  CH  CU  FF  SI  SL
       CH  41   0   0   0   0
       CU   2 113   0   1   2
       FF   1   0 189   2   1
       SI   0   0   2 411   0
       SL   0   1   1   0 165
```

```r
# plot each model
plot.nnet(nn_mod1)
```

![plot of chunk unnamed-chunk-9](/figure/2016-11-12-neuralnet/image1.png) 

```r
# structure (15 inputs, 10 hidden layers, 5 outputs)
nn_mod1$n

# summary of model
summary(nn_mod1)
```

![plot of chunk unnamed-chunk-9](/figure/2016-11-12-neuralnet/image2.png) 

```r
# Validation on new data from 2016 World Series game 2
val.pred <- predict(nn_mod1, newdata = validation, type = "class")

# Misclassified Pitch number 13
table(val.pred, validation$pitch_type)
```

```r
val.pred CH CU FF SI SL
      CH  1  0  0  0  0
      CU  0 15  0  0  0
      FF  0  0 49  1  0
      SI  0  0  0 11  0
      SL  0  0  0  0 21
```

## Analysis ##

The above confusion matrix shows that the model misclassified one pitch out of the 98 thrown in Game 2 of the World Series.  My model predicted that the pitch was a four-seam fastball when in fact Major League Baseball classified the pitch as a sinker.  First, let's take a look at a four-seam fastball and a sinker thrown by Arrieta to show how similar this would be for a human to classify.  The below image shows one of each pitch thrown in the first inning, both in nearly the same location and almost identical pitch velocities.

Pitch 1: Sinker
<video width="520" height="440" controls>
<source src="/figure/2016-11-12-neuralnet/pitch1_SI.mov">
</video>

<br>

Pitch 4: Four-Seam Fastball
<video width="520" height="440" controls>
<source src="/figure/2016-11-12-neuralnet/pitch4_FF.mov">
</video>

{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57468410-2', 'auto');
  ga('send', 'pageview');

</script>
