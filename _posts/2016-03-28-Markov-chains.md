---
title: "Using Markov Chains to Predict Pitches"
layout: post
code_folding: hide
comments: true
category: R
---
  
{% raw %}

<br>

#### Quick Introdcution to Markov Chains ####

Markov chains are mathematical systems that hop from one "state" to another.  In this demonstration, I will look at how Markov chains can be used to help determine the probability of a specific type of pitch being thrown given the pitch type of the previous pitch. States will restart after each game, meaning that the last pitch of each game will not be used to predict the first pitch of the next game. Additionally, all data used is from the 2015 season and comes from MLB Gameday. 


```{r, message=FALSE, warning=FALSE}
library(pitchRx)
library(RSQLite)
library(dplyr)
library(knitr)
library(rmarkdown)
library(msm)
library(data.table)
library(pander)

setwd("~/pitchRx")
#db2015_All <- src_sqlite("MLB2015_All.sqlite3", create = TRUE)
#scrape(start = "2015-04-05", end = "2015-10-09", connect = db2015_All$con)
db2015_All <- src_sqlite("MLB2015_All.sqlite3", create = FALSE)

# Join the location and names table into a new que table.
locations <- select(tbl(db2015_All, "pitch"), 
                    pitch_type, px, pz, des, num, gameday_link, inning)
names <- select(tbl(db2015_All, "atbat"), pitcher_name, batter_name, 
                num, b_height, gameday_link, event, stand)
que <- inner_join(locations, filter(names, pitcher_name == "Jake Arrieta"),
                  by = c("num", "gameday_link"))
pitchfx <- as.data.frame(collect(que))
pitchfx <- data.table(pitchfx[ do.call(order, pitchfx[ , c("gameday_link","inning", "num") ] ), ])
pitchfx[, batter_num:=as.numeric(factor(num)), by=gameday_link]
pitchfx <- as.data.frame(pitchfx)
pitchfx$batter_num <- ifelse(pitchfx$batter_num %% 9 == 0, 9, (pitchfx$batter_num %% 9))
pitchfx$batter_num <- as.factor(pitchfx$batter_num)
pitchfx$pitch_type <- as.factor(pitchfx$pitch_type)

# table(pitchfx$pitch_type)
pitchfx$pitch_type_full <- factor(pitchfx$pitch_type,
                                  levels=c("FF", "SI", "CH", "CU", "SL", "IN"),
                                  labels=c("4-seam FB","Sinker","Changeup", 
                                           "Curveball", "Slider", "Int. Ball"))

pitcher <- as.data.frame(pitchfx[c(1,5:6,13:14)])
pitcher$uniqueID <- paste(pitcher$num, pitcher$gameday_link, pitcher$inning, sep='') 
```
 
<br>
 
## Jake Arrieta ## 

In this example, we will start off by looking at the overall pitch proportions from Jake Arrieta.  The below table shows us the distribution of Arrieta's pitch choices.  In 2015, Arrieta threw a four-seam fastball 18% of the time, a sinker 32% of all pitches, a slider 29%, etc.  This is good information, but does not give much predictive power for the batter.  We know that Arrieta is most likely to throw a sinker, but I don't think any batter will be going up to the plate sitting on that pitch given only this information.

<br>

#### Jake Arrieta - Overall Pitch Proportions ####

```{r, results='asis'}
pitcher.table <- table(pitcher$pitch_type_full)
prop <- prop.table(pitcher.table)
pitch.prop <- round(prop,3)
pandoc.table(pitch.prop)
```

<br>

Next, we will look at the multi-class transition matrix for Jake Arrieta.  With now more information, the below table tells us the probability of a specific pitch given the previous pitch.  The transition matrix shows that when Arrieta threw a four-seam fastball on the previous pitch, he would also throw a four-seam fastball on the next pitch 23.2% of the time. We now have more information than previously, which was that Arrieta threw a four-seam fastball 18% of the time.  However, not too much information was gained through the use of Markov Chains, so maybe Arrieta just really is that good.  Let's find an example where Markov chains can significantly help a batter.

<br>

#### Jake Arrieta - Multi-class Markov Chain ####

```{r}
## Multi-class ##

# Include date as to not include last pitch of previous game and first pitch of next game.
pitcher.matrix <- statetable.msm(pitch_type_full, uniqueID, data=pitcher)
transition.matrix <- round(t(t(pitcher.matrix) / rep(rowSums(pitcher.matrix), each=ncol(pitcher.matrix))),3)
transition.matrix
```

<br> 

#### Jake Arrieta - First Pitch of an At-Bat ####

Example of pitch proportions only for the first pitch of an at-bat.

```{r, results='asis'}
first.pitch <- pitcher %>% 
  group_by(num, gameday_link) %>% 
  filter(row_number() <= 1) 

first.pitch.table <- table(first.pitch$pitch_type_full)
prop.first.pitch <- round(prop.table(first.pitch.table),3)
pandoc.table(prop.first.pitch)
```


<br>

## Chris Sale ##

In this example, let's take a look at White Sox starting pitcher, Chris Sale.  

<br>

#### Chris Sale - Overall Pitch Proportions ####

Chris Sale's 2015 pitch proportions are shown below.  His two main pitches, a two-seam fastball and a changeup are thrown for roughly 53% and 28%, respectively.

<br>

When analyzing Sale, Markov chains give a bit more insight into predicting his next pitch than of that for Arrieta.  Even though a two-seam fastball is Sale's most thrown pitch, when he threw a changeup on the previous pitch, he is more likely to come back with another offspead pitch (37% + 16.4%).  This type of information shows the importance of Markov chains because it is simly missed when only looking at overall pitch proportions.  Still not necessarily enough information to confidently assume one pitch or another, but enough information to give the batter an edge against one of baseball's most dominant pitchers.

<br>

#### Chris Sale - Multi-class Markov Chain ####

<br>

## Joe Kelly ##

Finally, we'll look at one more example from a starting pitcher where Markov chains give more information to a batter than the overall pitch proportions.  Below, let's take a look at Red Sox starting pitcher, Joe Kelly.

<br>

#### Joe Kelly - Overall Pitch Proportions ####

In 2015, Joe Kelly threw a four-seam fastball 32% of pitches, a 2-seam fastball 34% of pitchers, etc.

<br>

When looking at the transition matrix for Joe Kelly, we find much more information than we did from Jake Arrieta.  In this case, when Kelly threw a four-seam fastball on the previous pitch, we now know that there is a 48% chance he'll throw a four-seam fastball on the next pitch.  A significant jump from the 32% overall probability of a four-seam fastball.

<br>

#### Joe Kelly - Multi-class Markov Chain ####

<br>

## Results ##

When I use the word significance, it should be noted that I do not test for statistical significance, but did use a full season worth of pitches for each pitcher and felt that it was a decent amount of data for a fair representation.  Overall, Markov chains are easy to use in R thanks to packages like <a href="https://cran.r-project.org/web/packages/msm/index.html" target="_blank">msm</a> 
and <a href="https://cran.r-project.org/web/packages/markovchain/" target="_blank">markovchain</a>.  Further, Markov chains can help a batter gain insights that cannot be found on sites like FanGraphs or MLB.com.  Potential for a further analysis can be done to enhance the accuracy of the Markov model by not only using pitch type, but the pitch location too.  An example of this would be that if Sale threw a fastball in the bottom third of the zone on the previous pitch, then he is going to come back with a high fastball x% of the time on the next pitch.

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
  