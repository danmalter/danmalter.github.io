---
layout: post
title: "You're up and running!"
published: true
---

Next you can update your site name, avatar and other options using the _config.yml file in the root of your repository (shown below :point_down:).

![_config.yml]({{ site.baseurl }}/images/config.png)

```{r regression}
startsal = c(5,7,7,5,6,7,5,6,7,5,6,5,5,6,7,6,6,8) # subject's starting salary upon cessation of schooling
yrsed = c(16,19,20,16,13,20,16,18,20,16,14,20,16,18,21,16,18,20) # yrs of subject education
parentincome = c(5,6,8,5,6,7,5,6,8,5,4,8,5,6,8,3,6,9) # subject's parents' income x $10,000
data = data.frame(startsal,yrsed,parentincome)    

r1 = lm(startsal ~ yrsed + parentincome, data = data); summary(r1)

```

The easiest way to make your first post is to edit this one. Go into /_posts/ and update the Hello World markdown file. For more instructions head over to the [Jekyll Now repository](https://github.com/barryclark/jekyll-now) on GitHub.