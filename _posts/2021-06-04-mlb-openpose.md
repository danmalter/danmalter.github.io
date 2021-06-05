---
title: "Using OpenPose with MLB Players"
layout: post
comments: true
category: R
---

{% raw %}

# Using OpenPose with MLB Players

  
MLB StatCast has done a lot to improve how player’s movements are analyzed, but little public research has been done using video and image processing to improve mechanics amongst players and to help prevent injuries.  This analysis will demonstrate how to use video and image processing techniques to improve how Major League Baseball players perform various actions, such as pitching and hitting.  Implementation of work uses a combined method of MIT’s open-source algorithm, OpenPose, as well as various data analysis and machine learning techniques.  Further information about OpenPose can be seen [here](https://github.com/CMU-Perceptual-Computing-Lab/openpose).

  
### Data Capture

Data for this project was captured by collecting various video clips of a given player from both a side and center field point of view.  A team can utilize this method of analysis by having a still camera directed at a pitcher throughout a game or during a bullpen/batting practice session.  For simplicity of this analysis, a few different pitches/swings are shown for a given player, but the ideal situation would be to have hundreds of pitches to draw further conclusions from the data.
  
  
### Analysis 
To start, we’ll look at a still image of the OpenPose algorithm applied to a side-view of Walker Buehler pitching.  OpenPose captures 25 data points (keypoints) of a human body, such as “Right Wrist”, “Neck”, “Left Knee”, etc. for both still images and video.  When a keypoint is not found in the image, OpenPose uses machine learning to estimate where the body part is located. The OpenPose algorithm works with multiple people within one view, but it works best with only one person. In cases where non-relevant people are in the background, image processing techniques such as blurring or cropping can be used to filter those people out.


![Walker Beuhler Image](/figure/2021-06-04-mlb-openpose/beuhler1.png)  
  
<br>

By feeding in a video through the OpenPose algorithm, we get an output like the video below.  Here we see the OpenPose algorithm in action throughout the duration of a full pitch for Walker Buehler. During this particular clip, 101 snapshots were taken by the algorithm, which essentially means that the video is turned into a sequence of 101 still images.  For each snapshot, the x-coordinates, y-coordinates and confidence (0-1) are given for each of the 25 keypoints. 

<b>Walker Beuhler Side View</b>
<video width="520" controls>
<source src="/figure/2021-06-04-mlb-openpose/walker_beuhler2.mp4">
</video>  

<br>
  
Using the output data from each of the 101 images, a plot for a given keypoint (body part) can be mapped out over time.  From a windup approach, the below chart shows an example of Buehler’s right shoulder movement over the duration of the above pitch.  As Buehler approaches the pitch, his shoulder drops and then elevates again after releasing the ball.

![Walker Beuhler Image](/figure/2021-06-04-mlb-openpose/beuhler2.png)  

<br>

Valuable information can be shown from one unique pitch, but deeper analysis can start to be made from taking multiple pitches of the same pitcher.  The first chart shows an analysis from five different pitches.  Each clip is initiated at a slightly different time prior to Buehler starting his motion, so in order to make more meaning of these five pitchers, the second chart shows the same five pitches overlayed on top of each other starting from the same point in time.  It’s clear that Buehler has a slightly different motion for off-speed pitches than for his four-seam fastball. However, it’s important to note here that the distance is measured in pixels, so in order to know how much of a difference Buehler’s shoulder drops, we’d need to convert those pixels into inches.  With technology such as MLB’s Statcast, this should not be an issue implementing into gameday data.  
<br>

![Walker Beuhler Image](/figure/2021-06-04-mlb-openpose/beuhler5.png)  

<br>

Further research still can be done in this area, but the difficulty is having the appropriate input data, whether it be an enhancement to Statcast or video feeds provided by specific players or teams.  Below are a few examples of how to use this data.

Player Scouting:
  - OpenPose can be used to measure how closely one player’s pitching or hitting mechanics are relative to another known player. By collecting data like angles of body parts, movement, etc. clustering algorithms can be used to measure the similarity between two player’s pitches or swings.


Tacking Mechanics:
  - Rather than a player or coach going through video one by one, OpenPose technology can be used to better align hundreds of videos all at once. If a pitcher is tweaking their mechanics, data from OpenPose can be overlayed to determine how much of a change is occurring and where specifically the change is.


Injury Prevention:
  - By using player movement tracking data, potential models like outlier detection algorithms can be used to detect if a pitcher’s mechanics are differing too much from the norm. In this case, some type of alert system can be programmed to allow a pitcher to know that their mechanics have changed. This type of data can also be used to measure a given pitcher’s mechanics to those that have previously suffered from pitching related injuries.


Example code to run the above examples can be seen [here](https://github.com/malteranalytics/malteranalytics.github.io/blob/master/research/OpenPose.ipynb){:target="_blank"}.



{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57468410-2', 'auto');
  ga('send', 'pageview');

</script>
