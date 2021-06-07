---
title: "Using AI with MLB Video to Detect Changes in Mechanics"
layout: post
comments: true
category: R
---

{% raw %}

# Using AI with MLB Video to Detect Changes in Mechanics

MLB’s Statcast has done a lot to improve how player’s movements are analyzed, but little public research has been done using video and image processing to improve mechanics amongst players and to help prevent injuries.  In part, this is due to the fact that machine learning related to images and videos requires lots of storage and high computing.  Even though storage and computing are relatively cheap, there is a small cost and high complexity associated to working with this type of data, which creates a barrier to entry working with it. Additionally, MLB and individual teams own video rights making accessibility of data difficult. 

In this article, I will demonstrate how sample image and video data can be used in different ways to help pitchers improve their mechanics, prevent future injuries as well as some other use cases. All of the concepts shown below can be used at a larger scale to make more significant impacts.  This analysis will focus on how to use image and video processing techniques to improve how Major League Baseball players perform various actions, such as pitching and hitting.  Implementation of work uses a combined method of MIT’s open-source algorithm, OpenPose, as well as various data analysis and machine learning techniques.  Further information about OpenPose can be seen [here](https://github.com/CMU-Perceptual-Computing-Lab/openpose).

An example of the final algorithm in action is shown below.

<video width="520" controls>
<source type="video/mp4" src="/figure/2021-06-07-mlb-openpose/buehler_side_output.mp4">
</video>  
Walker Buehler Side View

<br>
  
### Data Capture

Data for this project was captured by collecting various video clips of a given player from both a side and center field point of view.  All video and images used in this analysis are solely for a research purpose and are not being used for any team specifically.  However, a team can utilize this method of analysis by having a still camera directed at a pitcher throughout a game or during a bullpen/batting practice session.  For the most part, the infrastructure is already in place, so it comes down to a matter of teams collecting and utilizing this type of data.  For simplicity of this analysis, a few different pitches/swings were collected for a small sample of players, but the ideal situation would be to have hundreds of pitches or swings to gain better insights from the data.

OpenPose captures data for 25 keypoints of a human body, such as “Right Wrist”, “Neck”, “Left Knee”, etc. for both still images and videos.  A mapping of the keypoints to human body part can be seen below.  For each image fed through the algorithm, the x-coordinates, y-coordinates and confidence (0-1) are given for each of the 25 keypoints (body parts).  If the algorithm is applied to a video, then the video is essentially broken up into many separate images.

| ![OpenPose Keyoints](/figure/2021-06-07-mlb-openpose/openpose_keypoints.png) |
|:--:| 
| *OpenPose keypoints* |
  
<br>
  
  
### Analysis 
To start, we’ll look at a still image of the OpenPose algorithm applied to a side view of Walker Buehler throwing a pitch.  When a keypoint cannot be found in the image, OpenPose uses machine learning to estimate where the body part is located, which is referred to as pose estimation.  These cases can happen when a body part is hidden from view in the image or video.  The OpenPose algorithm also works with one or multiple people in a single view, but I have found that it works best with only one person in the picture to reduce background noise. In cases where non-relevant people are in the background, image processing techniques such as blurring effects or cropping can be used to filter out this noise.  This article will not focus on this type of preprocessing work, but OpenCV or deep learning techniques would be appropriate for implementing background blurring effects. 


| ![Walker Buehler Image](/figure/2021-06-07-mlb-openpose/buehler1.png) |
|:--:| 
| *OpenPose applied to a still image of Walker Buehler* | 
  
<br>

By feeding in a video through the OpenPose algorithm, we get an output like the video below.  Here we see the OpenPose algorithm in action throughout the duration of a full pitch for Walker Buehler. During this one center field view clip, 101 snapshots were taken by the algorithm.  Another way to think about this is that the video is turned into a sequence of 101 still images.  This number will differ depending on the length of a particular video.  

<video width="520" controls>
<source type="video/mp4" src="/figure/2021-06-07-mlb-openpose/buehler4_output.mp4">
</video>
Walker Buehler Center Field View

<br>
  
Using the output data from each of the 101 center field view images, a plot for a given keypoint (body part) can be mapped out over time.  From a windup approach, the below chart shows an example of Buehler’s right shoulder movement over the duration of the pitch above.  As Buehler approaches the release of the ball, his shoulder drops and then picks back up as he finishes the pitch.  This is evident by simply watching the video, but the advantage of this type of analysis is that this data can pick up changes in a pitcher’s mechanics that the naked eye may not be able to see.  Additionally, given the proper data, thousands of videos can be analyzed in a matter of minutes versus spending hours of film watching.

| ![Walker Buehler Image](/figure/2021-06-07-mlb-openpose/buehler2.png) |
|:--:| 
| *Walker Buehler's right shoulder mapped out over the duration of a single pitch* |

<br>

Valuable information can be shown from one unique pitch, but deeper analysis can start to be made from taking multiple pitches of the same pitcher over the duration of a game or multiple appearances.  The left chart below shows an analysis from five different pitches Buehler threw over the same game.  Each clip is initiated at a slightly different time prior to Buehler starting his motion, so in order to make more meaning of these five pitches, the right chart shows the same five pitches overlayed on top of each other starting from roughly the same point in time.  The data shows that Buehler has a slightly different motion for his cutter and slider than for his four-seam fastball.  Although not evidence, this possibly can mean that Buehler is tipping his pitches as shown in the clear change in patterns. 

It is important to note here that the distance of the plot is measured in pixels, so in order to know how significant this difference really is to a batter, the pixels need to be converted into inches.  With technology such as MLB’s Statcast, this should not be an issue implementing into gameday data.  In this example, based on an estimated PPI (pixels per inch) of 250px, it’s estimated that difference in shoulder height distance between Buehler’s four-seam fastball versus his cutter and slider is about 0.25 inches.


<br>

| ![Walker Buehler Image](/figure/2021-06-07-mlb-openpose/buehler5.png) |
|:--:| 
| *Walker Buehler's right shoulder mapped out over the duration for five distinct pitches* |

<br>

### Future Implementation 

There are lots of opportunities for further research still to be done in this area, but the difficulty is having the appropriate input data.  Some options would be for MLB to release video clips of this type for research purposes or to implement this data into MLB’s open-source data as it’s own standalone data source.  Another option would be to work with teams or individual players to collect video footage during offseason training.  In regards for use cases of this data, here are a few ideas.

Player Scouting:
  - OpenPose can be used to measure how closely one player’s pitching or hitting mechanics are relative to another known player. By collecting data like angles of body parts, movement, etc. clustering algorithms can be used to measure the similarity between two player’s pitches or swings.  From a scouting perspective, these types of models can output something along the lines of, “Player A’s swing is 80% similar to Mike Trout”.


Tracking Mechanics:
  - Rather than a player or coach going through video one by one, OpenPose technology can be used to better align hundreds or thousands of videos all at once. If a pitcher is unknowingly tweaking their mechanics, data from OpenPose can be overlayed to determine how much of a change is occurring and where specifically the change occurs.


Injury Prevention:
  - By using player movement tracking data, potential models like outlier detection algorithms can be used to detect if a pitcher’s mechanics are differing too much from the norm. In this case, some type of alert system can be programmed to allow a pitcher to know that their mechanics have changed and hopefully would help to prevent a future injury. This type of data can also be used to measure a given pitcher’s mechanics to those that have previously suffered from pitching related injuries.


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
