---
layout: post
title: "Color Tools"
description: ""
category: r
tags: [color, gui]
---
{% include JB/setup %}

Colors are mysterious business and choosing the right color or color palette
for an [R](http://www.r-project.org/) graphics can sometimes be a chore.
To alleviate this burden, I present two functions for choosing color values.

To access these functions install the
[RSurvey](http://cran.r-project.org/web/packages/RSurvey/) package and its
dependencies:

{% highlight r %}
repo <- "http://cran.us.r-project.org"
install.packages("RSurvey", repos = repo, dependencies = TRUE, type = "both")
{% endhighlight %}

## Choose Color

The first function, *ChooseColor*
([source](https://github.com/jfisher-usgs/RSurvey/blob/master/R/ChooseColor.R)),
calls upon a graphical user interface (GUI) for choosing a color in the
[HSV](http://en.wikipedia.org/wiki/HSL_and_HSV) color space (**fig. 1**).

{% highlight r %}
col <- RSurvey::ChooseColor(col = "#669933")
{% endhighlight %}

![center](/figs/2012-06-01-color-tools/fig1.png)

##### Figure 1: A screenshot of the HSV color tool.

## Choose Color Palette

The second function, *choose_palette*
([source](https://github.com/cran/colorspace/blob/master/R/choose_palette.R)),
calls upon a GUI for choosing a color palette in the HCL
(Hue, Chroma, and Luminance) color space (**fig. 2**).

{% highlight r %}
pal <- colorspace::choose_palette(terrain_hcl)
{% endhighlight %}

![center](/figs/2012-06-01-color-tools/fig2.png)

##### Figure 2: A screenshot of the HCL color palette tool.

An example graphic accompanies the GUI and may be used to evaluate the
robustness of individual color schemes (**fig. 3**).

![center](/figs/2012-06-01-color-tools/fig3.png)

##### Figure 3: Example graphic based on selected color palette.

