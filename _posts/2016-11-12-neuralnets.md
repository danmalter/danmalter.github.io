---
title: "Classifying MLB Pitch Types Using Neural Nets"
layout: post
comments: true
category: R
code_folding: hide
---

{% raw %}

# Classifying Jake Arrieta's Pitch Types #

Major League Baseball currently has high definition cameras capturing everything from the release point of the ball being thrown to the amount of horizontal spin on the ball.  Rather than having a person manually write down what each pitch type is, an algorithm does this automatically.  The goal of this analysis is to use MLB's classifications to run a neural network of my own that will match that of Major League Baseball.

The training dataset being used are all of Jake Arrieta's pitches thrown in the 2016 regualar season and the model is validated against Game 2 of the 2016 World Series in which Arrieta threw 98 pitches.

Load in the required packages

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
<br>

Example of the dataset.  A glossary of the pitchFx fields can be seen <a href="https://fastballs.wordpress.com/2007/08/02/glossary-of-the-gameday-pitch-fields/">here</a>.

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

<br>

## Neural Network from nnet Package ##

This is a very simple feed-forward neural network with a single hidden layer.  More complicated methods were tested, such as Keras and Theano, but not necessary for this type of classification.

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

<br>
This image shows the layout of the neural network with 15 input nodes (features), 10 hidden nodes and 5 output nodes (pitch types).

![plot of image1](/figure/2016-11-12-neuralnet/image1.png) 

<br>
This summary gives an example of the weights and biases values between each node.  

```r
# structure (15 inputs, 10 hidden layers, 5 outputs)
nn_mod1$n

# summary of model
summary(nn_mod1)
```

![plot of image2](/figure/2016-11-12-neuralnet/image2.png) 

```r
# Validation on new data from 2016 World Series game 2
val.pred <- predict(nn_mod1, newdata = validation, type = "class")

# Misclassified Pitch number 13
table(val.pred, validation$pitch_type)
```
<br>
The confusion matrix shows that the model misclassified one pitch out of the 98 thrown by Arrieta in Game 2 of the World Series.  The thirteenth pitch he threw was a sinker and my model classified the pitch as a four-seam fastball.

```r
val.pred CH CU FF SI SL
      CH  1  0  0  0  0
      CU  0 15  0  0  0
      FF  0  0 49  1  0
      SI  0  0  0 11  0
      SL  0  0  0  0 21
```

<br>

## Analysis ##
First, let's take a look at a four-seam fastball and a sinker thrown by Arrieta to show how similar these pitches look and how difficult it  would be for a human to classify.  The below image shows one of each pitch thrown in the first inning, both in nearly the same location and almost identical pitch velocities.

<br>
![plot of chunk image3](/figure/2016-11-12-neuralnet/image3.png) 
Image from Baseball Savant

<br>
Play the videos of each pitch and see for yourself if you would have been able to identify the difference.

<b>Pitch 1: Sinker</b>
<video width="520" controls>
<source src="/figure/2016-11-12-neuralnet/pitch1_SI.mov">
</video>

<br>

<b>Pitch 4: Four-Seam Fastball</b>
<video width="520" controls>
<source src="/figure/2016-11-12-neuralnet/pitch4_FF.mov">
</video>

<br>

## Misclassified Pitch ##

Pitch 13 in the video below was misclassified as a four-seam fastball.  Arrieta misses his spot by throwing the ball outside of the strike zone.  It appears that there may be a very small cut on the pitch, thus identifying the ball as a sinker, but it is very difficult to detect with the naked eye.  The table below shows how subtle the differences can be by looking at the mean of various factors grouped by pitch type.  Arrieta gets more spin on his sinker than compared to his four-seam fastball, but only a computer can pick up that information.

```r
detach(package:plyr)
mean.group <- validation %>% 
  group_by(pitch_type) %>% 
  summarise (mean_break_angle = mean(break_angle), 
  mean_break_length = mean(break_length),
  mean_spin_rate = mean(spin_rate), 
  mean_spin_dir = mean(spin_dir))
as.data.frame(mean.group)
```

```r
  pitch_type mean_break_angle mean_break_length mean_spin_rate mean_spin_dir
1         CH         26.60000          5.800000       1957.302     228.09300
2         CU        -16.50667         13.326667       1976.298      50.75767
3         FF         26.34082          4.057143       2162.419     209.88673
4         SI         31.75000          5.125000       2132.878     226.50800
5         SL        -18.04286          7.695238       1120.785     107.67705
```

<b>Pitch 13: Sinker</b>
<video width="520" controls>
<source src="/figure/2016-11-12-neuralnet/pitch13_SI.mov">
</video>

<br>
<br>

{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57468410-2', 'auto');
  ga('send', 'pageview');

</script>
