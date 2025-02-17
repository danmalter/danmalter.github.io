---
title: "Corporate Logo Detection in Sports"
layout: post
comments: true
---

{% raw %}

#### Tracking Corporate Logo Exposure on Televised Sports Broadcasts


In the world of sports, sponsorship and advertising are integral to a team or league’s revenue. Companies invest millions of dollars to place their logos in key spots for TV viewers. For example, along the boards of the ice during an NHL game or rotating sideboards of MLB, NBA and Premier League soccer games. But how is the return on investment of these sponsorships measured? It’s well known how TV viewership varies throughout the broadcasts of each sport and game time slot, but quantifying the exact exposure - and thus value - of an advertisement remains a challenge. Using TV viewership data along with an AI logo detection model, we can solve this challenge with a new business metric in sports advertising; Total Viewership per Second of Exposure. For the purposes of this demonstration, we are using the generic [Google AI Logo Detection]( https://cloud.google.com/vision/docs/detecting-logos){:target="_blank"} model but this or similar models can be retrained to learn better about identifying certain logos. 

<div style="text-align: center;">
  <video width="640" controls>
    <source src="/figure/2025-02-17-Logo_Detection/output_labels.mp4">
  </video>
</div>

<br>

Using Python, we analyzed a video clip from the first period of a game between the [Chicago Blackhawks and St. Louis Blues]( https://www.youtube.com/watch?v=_P9cXD2BqFU){:target="_blank"}, played on February 8th, 2025 at the Enterprise Center, broadcasted by ESPN+. Hockey is a fast-paced sport, so it’s unlikely that a logo will be 100% visible for more than a few seconds at a time. To solve this, we’ve written an algorithm that uses the Google model to first identify if a logo is in a given frame. We continue to track that logo over the next two frames to detect if the logo remains visible; if we capture 100% of a logo in three consecutive frames, we count the occurrence as one continuous logo detection. We ran a highlight video from the first period of this game and below is the total amount of seconds that each logo was shown over a 93 second video. 

<table style="width:100%; border: 1px solid black; border-collapse: collapse;">
  <thead>
    <tr>
      <th style="border: 1px solid black; text-align: center; padding: 8px; font-weight: bold;">Logo Name</th>
      <th style="border: 1px solid black; text-align: center; padding: 8px; font-weight: bold;">Total Time (seconds)</th>
      <th style="border: 1px solid black; text-align: center; padding: 8px; font-weight: bold;">Percent of Time in Total Video</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">FanDuel</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">44.74</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">48.11%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">Purina PetCare Company</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">22.72</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">24.43%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">Enterprise Rent-A-Car</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">12.31</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">13.24%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">PNC Financial Services</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">11.81</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">12.70%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">World Wide Technology</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">10.51</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">11.30%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">Schnucks</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">5.91</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">6.35%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">BJC HealthCare</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">4.6</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">4.95%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">National Hockey League</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">4.4</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">4.73%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">Bauer Hockey</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">2.5</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">2.69%</td>
    </tr>
    <tr>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">Stifel</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">1.6</td>
      <td style="border: 1px solid black; text-align: center; padding: 8px;">1.72%</td>
    </tr>
  </tbody>
</table>


<br>

We already know that ad placement matters, but the use of AI to quantify the impact of each placement provides greater insights that are not currently accounted for. Over the course of an entire game, optimized ad placement can lead to several extra minutes of exposure. Tracking the time a logo is displayed on TV during sports events provides both sponsors and teams with quantifiable metrics to measure the effectiveness of their deals. By leveraging this data, teams can offer more accurate sponsorship valuations, and companies can make more informed decisions about where and how to invest their marketing dollars. Knowing the duration of logo exposure gives both parties a powerful tool for negotiation and strategy.
{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57468410-2', 'auto');
  ga('send', 'pageview');

</script>