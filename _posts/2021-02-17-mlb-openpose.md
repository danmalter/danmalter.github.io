---
title: "Using OpenPose with MLB Players"
layout: post
comments: true
category: R
---

{% raw %}

# Using OpenPose with MLB Players
  
This post gives an example of how to use OpenPose for tracking pitcher and hitter mechanics in Major League Baseball. In the first example, we see a video of Walker Beuhler pitching in slow motion and in the second, a video of Mike Trout swinging through a home run. OpenPose is a real-time multi-person system developed by MIT to detect human body, hand, facial, and foot keypoints.  

Technology like this can be used for various reasons, some of which include the use of player scouting, tracking mechanics and detecting injuries ahead of time. 

- Player Scouting:
  - OpenPose can be used to measure how closely one player's pitching or hitting mechanics are relative to another known player.  By collecting data like angles of body parts, movement, etc. clustering algorithms can be used to measure the similarity between two player's pitches or swings.


- Tacking Mechanics:
  - Rather than a player or coach going through video one by one, OpenPose technology can be used to better align hundreds of videos all at once. If a pitcher is tweaking their mechanics, data from OpenPose can be overlayed to determine how much of a change is occurring and where specifically the change is.


- Injury Prevention:
  - By using player movement tracking data, potential models like outlier detection algorithms can be used to detect if a pitcher's mechanics are differing too much from the norm.  It can also be used to measure a given pitcher's mechanics to those that have previously suffered from pitching related injuries.


<br>

<b>Walker Beuhler</b>
<video width="520" controls>
<source src="/figure/2021-02-17-mlb-openpose/walker_beuhler.mp4">
</video>

<br>

<b>Mike Trout</b>
<video width="520" controls>
<source src="/figure/2021-02-17-mlb-openpose/trout.mp4">
</video>

<br>

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
