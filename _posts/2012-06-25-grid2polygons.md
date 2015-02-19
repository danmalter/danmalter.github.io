---
layout: post
title: "Grid2Polygons"
description: ""
category: r
tags: [spatial, package]
---
{% include JB/setup %}

I'd like to introduce you to the *Grid2Polygons* function; an
[R](http://www.r-project.org/) function for
converting **sp** spatial objects from class *SpatialGridDataFrame*
to *SpatialPolygonsDataFrame*.
The significance of this conversion is that
spatial polygons can be transformed to a different projection or datum with
the *spTransform* function in package **rgdal**.
Postscript files created with spatial polygons are reduced in size and result
in a much "cleaner" version of your image. Disadvantages of the conversion
include long computational times and irreversible leveling,
partitioning the range of *z* values.
A general explanation of the algorithm is provided
[here](http://stackoverflow.com/questions/643995/algorithm-to-merge-adjacent-rectangles-into-polygon});
inspiration provided
[here](http://menugget.blogspot.com/2012/04/create-polygons-from-matrix.html).

To access the function install the
[Grid2Polygons](http://cran.r-project.org/web/packages/Grid2Polygons/index.html)
package ([source](https://github.com/jfisher-usgs/Grid2Polygons)):

{% highlight r %}
install.packages("Grid2Polygons")
library(Grid2Polygons)
{% endhighlight %}

See help documentation for argument descriptions:

{% highlight r %}
?Grid2Polygons
{% endhighlight %}

The following examples highlight the functions usefulness:

## Example 1

Construct a simple spatial grid data frame.

{% highlight r %}
m <- 5
n <- 6
z <- c(1.1,  1.5,  4.2,  4.1,  4.3,  4.7,
       1.2,  1.4,  4.8,  4.8,   NA,  4.1,
       1.7,  4.2,  1.4,  4.8,  4.0,  4.4,
       1.1,  1.3,  1.2,  4.8,  1.6,   NA,
       3.3,  2.9,   NA,  4.1,  1.0,  4.0)
x <- rep(0:6, m + 1)
y <- rep(0:5, each = n + 1)
xc <- c(rep(seq(0.5, 5.5, by = 1), m))
yc <- rep(rev(seq(0.5, 4.5, by = 1)), each = n)
grd <- data.frame(z = z, xc = xc, yc = yc)
coordinates(grd) <- ~ xc + yc
gridded(grd) <- TRUE
grd <- as(grd, "SpatialGridDataFrame")
{% endhighlight %}

Plot the grid using a gray scale to indicate values of *z* (**fig. 1**).

{% highlight r %}
image(grd, col = gray.colors(30), axes = TRUE)
grid(col = "black", lty = 1)
points(x = x, y = y, pch = 16)
text(cbind(xc, yc), labels = z)
text(cbind(x = x + 0.1, y = rev(y + 0.1)), labels = 1:42, cex = 0.6)
{% endhighlight %}

![center](/figs/2012-06-25-grid2polygons/fig1.png)

##### Figure 1: Simple spatial grid data frame.

Convert the grid to spatial polygons and overlay in plot (**fig. 2**).
Leveling is specified with cut locations at 1, 2, 3, 4, and 5, and
*z*-values set equal to the midpoint between breakpoints. A "winding rule"
is used to determine if a polygon ring is filled (island) or is a
hole in another polygon.

{% highlight r %}
plys <- Grid2Polygons(grd, level = TRUE, at = 1:5)
cols <- rainbow(4, alpha = 0.3)
plot(plys, col = cols, add = TRUE)
x <- rep(0:6, m + 1)
y <- rep(0:5, each = n + 1)
legend("top", legend = plys[[1]], fill = cols, bty = "n", xpd = TRUE, inset = c(0, -0.1), ncol = 4)
{% endhighlight %}

![center](/figs/2012-06-25-grid2polygons/fig2.png)

##### Figure 2: Simple gridded data represented with spatial polygons.


## Example 2

Apply the conversion function to the *meuse* data set,
included in the **sp** package.
The effect of leveling is shown in **figure 3**.

{% highlight r %}
data(meuse.grid)
coordinates(meuse.grid) <- ~ x + y
gridded(meuse.grid) <- TRUE
meuse.grid <- as(meuse.grid, "SpatialGridDataFrame")
meuse.plys <- Grid2Polygons(meuse.grid, "dist", level = FALSE)
op <- par(mfrow = c(1, 2), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0))
z <- meuse.plys[[1]]
col.idxs <- findInterval(z, sort(unique(na.omit(z))))
cols <- heat.colors(max(col.idxs))[col.idxs]
plot(meuse.plys, col = cols)
title("level = FALSE", line = -7)
meuse.plys.lev <- Grid2Polygons(meuse.grid, "dist", level = TRUE)
z <- meuse.plys.lev[[1]]
col.idxs <- findInterval(z, sort(unique(na.omit(z))))
cols <- heat.colors(max(col.idxs))[col.idxs]
plot(meuse.plys.lev, col = cols)
title("level = TRUE", line = -7)
par(op)
{% endhighlight %}

![center](/figs/2012-06-25-grid2polygons/fig3.png)

##### Figure 3: Distance from river represented with spatial polygons.
