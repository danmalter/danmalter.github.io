---
title: "MLB Spray Charts"
layout: post
comments: true
category: R
---

{% raw %}



```r
library(mosaic)
library(ggplot2)
library(ggvis)
library(dplyr)
library(ggplot2)
library(RSQLite)
library(pitchRx)
```


```r
setwd("~/GitHub/Spray Chart")
files <- c("inning/inning_hit.xml", "players.xml", "miniscoreboard.xml")
my_db <- src_sqlite("MLB2014.sqlite3", create = TRUE)
#scrape(start = "2014-03-30", end = "2014-09-30", connect = my_db$con, suffix = files)
```


```r
# There is no key that allows the tables to be joined, so I write to a dataframe.
locations <- select(tbl(my_db, "hip"), des, x, y, batter, pitcher, type, team, inning)
locations <- as.data.frame(locations, n=-1)
locations <- locations[!duplicated(locations),]
names(locations)[names(locations) == 'batter'] <- 'batter.id'
names(locations)[names(locations) == 'pitcher'] <- 'pitcher.id'

batters <- select(tbl(my_db, "player"), first, last, id, bats, team_abbrev)
batters <- as.data.frame(batters, n=-1)
batters <- batters[!duplicated(batters),]
batters$full.name <- paste(batters$first, batters$last, sep = " ")
names(batters)[names(batters) == 'id'] <- 'batter.id'
batters <- batters[,-c(1,2)]

players <- as.data.frame(players, n=-1)
names(players)[names(players) == 'id'] <- 'player.id'

# If scraping the whole season, you will need to take out non-mlb regular season games.
batters <- batters[ !grepl("AL", batters$team_abbrev) , ]
batters <- batters[ !grepl("NL", batters$team_abbrev) , ]
batters <- batters[ !grepl("VER", batters$team_abbrev) , ]

# Merge the batters and location tables together.
spraychart <- merge(locations, batters, by="batter.id")
spraychart <- merge(spraychart, players, by.x="pitcher.id", by.y="player.id")
names(spraychart)[names(spraychart) == 'full.name'] <- 'batter.name'
names(spraychart)[names(spraychart) == 'full_name'] <- 'pitcher.name'
names(spraychart)[names(spraychart) == 'des'] <- 'Description'

# Subset to only look at Jose Abreu's spray chart
spraychart <- subset(spraychart, batter.name=="Jose Abreu")
```


```r
# Create ggvis tooltip  
spraychart$id <- 1:nrow(spraychart)

all_values <- function(x) {
  if(is.null(x)) return(NULL)
  
  paste0("Pitcher: ",
         spraychart$pitcher.name[x$id],
         "<br>",
         spraychart$Description[x$id]
  )
}
```



```r
spraychart %>%
  ggvis(~x, ~-y+250) %>%
  layer_points(size := 30, size.hover := 200, fill = ~Description, key:=~id) %>%
  scale_numeric("x", domain = c(0, 250), nice = FALSE) %>%
  scale_numeric("y", domain = c(0, 250), nice = FALSE) %>%
  hide_legend("stroke") %>%
  add_tooltip(all_values, "hover") %>%
  add_axis("x", title = "x") %>%
  add_axis("y", title = "y") %>%
  add_axis("x", orient = "top", ticks = 0, title = 'Jose Abreu 2014 Spray Chart',
           properties = axis_props(
             axis = list(stroke = "white"),
             title = list(fontSize = 12),
             labels = list(fontSize = 0)))
```

```
## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
```

<!--html_preserve--><div id="plot_id649638610-container" class="ggvis-output-container">
<div id="plot_id649638610" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id649638610_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id649638610" data-renderer="svg">SVG</a>
 | 
<a id="plot_id649638610_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id649638610" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id649638610_download" class="ggvis-download" data-plot-id="plot_id649638610">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id649638610_spec = {
    "data": [
        {
            "name": ".0",
            "format": {
                "type": "csv",
                "parse": {
                    "x": "number",
                    "-y + 250": "number",
                    "id": "number"
                }
            },
            "values": "\"x\",\"-y + 250\",\"Description\",\"id\"\n97.39,79.32,\"Groundout\",1\n71.29,154.62,\"Single\",2\n84.98,139.48,\"Batter Interference\",3\n39.16,185.74,\"Home Run\",4\n147.59,162.65,\"Single\",5\n115.46,89.36,\"Groundout\",6\n99.4,208.84,\"Double\",7\n111.45,90.36,\"Groundout\",8\n103.41,81.33,\"Groundout\",9\n174.7,111.45,\"Pop Out\",10\n141.57,105.42,\"Lineout\",11\n95.38,130.52,\"Single\",12\n104.42,94.38,\"Groundout\",13\n135.54,150.6,\"Single\",14\n77.31,136.55,\"Single\",15\n102.41,81.33,\"Groundout\",16\n110.44,95.38,\"Groundout\",17\n103.41,84.34,\"Groundout\",18\n148.59,218.88,\"Home Run\",19\n33.13,186.75,\"Home Run\",20\n107.43,101.41,\"Field Error\",21\n125.5,66.27,\"Groundout\",22\n186.75,204.82,\"Home Run\",23\n109.44,91.37,\"Groundout\",24\n127.51,142.57,\"Error\",25\n127.51,142.57,\"Single\",26\n141.57,94.38,\"Groundout\",27\n157.63,137.55,\"Single\",28\n167.67,77.31,\"Pop Out\",29\n132.53,162.65,\"Single\",30\n164.66,92.37,\"Pop Out\",31\n129.52,149.6,\"Single\",32\n112.45,98.39,\"Groundout\",33\n104.42,78.31,\"Single\",34\n103.41,83.33,\"Groundout\",35\n153.61,152.61,\"Lineout\",36\n135.54,149.6,\"Flyout\",37\n109.44,71.29,\"Field Error\",38\n64.26,134.54,\"Single\",39\n123.49,149.6,\"Single\",40\n200.8,113.45,\"Flyout\",41\n136.55,152.61,\"Flyout\",42\n100.4,175.7,\"Flyout\",43\n106.43,75.3,\"Groundout\",44\n110.44,173.69,\"Single\",45\n177.71,114.46,\"Single\",46\n187.75,143.57,\"Single\",47\n102.41,188.76,\"Flyout\",48\n112.45,97.39,\"Lineout\",49\n22.09,171.69,\"Home Run\",50\n171.69,148.59,\"Single\",51\n105.42,80.32,\"Groundout\",52\n110.44,90.36,\"Groundout\",53\n180.72,135.54,\"Lineout\",54\n139.56,88.35,\"Groundout\",55\n125.5,163.65,\"Single\",56\n106.43,92.37,\"Groundout\",57\n145.58,204.82,\"Flyout\",58\n105.42,80.32,\"Groundout\",59\n116.47,173.69,\"Single\",60\n99.4,232.93,\"Home Run\",61\n158.63,207.83,\"Single\",62\n139.56,168.67,\"Single\",63\n114.46,176.71,\"Lineout\",64\n182.73,140.56,\"Flyout\",65\n69.28,149.6,\"Single\",66\n143.57,97.39,\"Lineout\",67\n212.85,152.61,\"Flyout\",68\n126.51,177.71,\"Lineout\",69\n110.44,146.59,\"Single\",70\n172.69,138.55,\"Lineout\",71\n99.4,82.33,\"Lineout\",72\n160.64,208.84,\"Flyout\",73\n110.44,90.36,\"Groundout\",74\n165.66,159.64,\"Lineout\",75\n89.36,177.71,\"Single\",76\n133.53,164.66,\"Single\",77\n67.27,143.57,\"Flyout\",78\n127.51,101.41,\"Single\",79\n72.29,221.89,\"Home Run\",80\n147.59,162.65,\"Flyout\",81\n80.32,141.57,\"Flyout\",82\n164.66,154.62,\"Single\",83\n128.51,213.86,\"Double\",84\n139.56,228.92,\"Home Run\",85\n177.71,130.52,\"Single\",86\n25.1,158.63,\"Home Run\",87\n184.74,138.55,\"Flyout\",88\n141.57,81.33,\"Groundout\",89\n213.86,144.58,\"Double\",90\n169.68,133.53,\"Single\",91\n105.42,86.35,\"Groundout\",92\n110.44,93.37,\"Groundout\",93\n99.4,81.33,\"Groundout\",94\n93.37,138.55,\"Single\",95\n105.42,82.33,\"Groundout\",96\n44.18,153.61,\"Double\",97\n109.44,92.37,\"Groundout\",98\n113.45,99.4,\"Groundout\",99\n133.53,85.34,\"Pop Out\",100\n32.13,147.59,\"Double\",101\n125.5,154.62,\"Flyout\",102\n86.35,131.53,\"Single\",103\n109.44,201.81,\"Flyout\",104\n75.3,215.86,\"Home Run\",105\n211.85,159.64,\"Double\",106\n125.5,155.62,\"Single\",107\n199.8,200.8,\"Home Run\",108\n110.44,97.39,\"Groundout\",109\n189.76,157.63,\"Lineout\",110\n102.41,78.31,\"Groundout\",111\n156.63,136.55,\"Single\",112\n107.43,82.33,\"Groundout\",113\n110.44,89.36,\"Groundout\",114\n188.76,137.55,\"Double\",115\n121.49,150.6,\"Single\",116\n112.45,173.69,\"Single\",117\n111.45,92.37,\"Groundout\",118\n100.4,82.33,\"Groundout\",119\n124.5,153.61,\"Single\",120\n54.22,201.81,\"Home Run\",121\n172.69,231.93,\"Home Run\",122\n172.69,154.62,\"Single\",123\n103.41,78.31,\"Groundout\",124\n99.4,99.4,\"Groundout\",125\n172.69,200.8,\"Double\",126\n117.47,172.69,\"Single\",127\n134.54,64.26,\"Pop Out\",128\n39.16,139.56,\"Double\",129\n107.43,93.37,\"Groundout\",130\n119.48,212.85,\"Flyout\",131\n100.4,82.33,\"Groundout\",132\n80.32,133.53,\"Single\",133\n99.4,81.33,\"Groundout\",134\n63.25,140.56,\"Single\",135\n177.71,129.52,\"Single\",136\n140.56,92.37,\"Single\",137\n25.1,160.64,\"Home Run\",138\n111.45,94.38,\"Groundout\",139\n156.63,144.58,\"Double\",140\n110.44,77.31,\"Groundout\",141\n102.41,90.36,\"Groundout\",142\n106.43,93.37,\"Groundout\",143\n125.5,185.74,\"Lineout\",144\n105.42,94.38,\"Single\",145\n160.64,129.52,\"Single\",146\n57.23,163.65,\"Double\",147\n189.76,157.63,\"Flyout\",148\n129.52,111.45,\"Groundout\",149\n108.43,94.38,\"Groundout\",150\n43.17,139.56,\"Double\",151\n69.28,151.61,\"Flyout\",152\n164.66,129.52,\"Single\",153\n99.4,82.33,\"Groundout\",154\n104.42,84.34,\"Groundout\",155\n95.38,120.48,\"Pop Out\",156\n183.73,143.57,\"Single\",157\n138.55,97.39,\"Groundout\",158\n197.79,129.52,\"Double\",159\n127.51,146.59,\"Single\",160\n184.74,128.51,\"Single\",161\n143.57,97.39,\"Groundout\",162\n103.41,79.32,\"Groundout\",163\n126.51,68.27,\"Groundout\",164\n72.29,145.58,\"Flyout\",165\n161.65,205.82,\"Flyout\",166\n120.48,159.64,\"Flyout\",167\n115.46,92.37,\"Groundout\",168\n148.59,72.29,\"Groundout\",169\n98.39,83.33,\"Field Error\",170\n104.42,97.39,\"Groundout\",171\n176.71,126.51,\"Single\",172\n115.46,93.37,\"Groundout\",173\n118.47,45.18,\"Pop Out\",174\n138.55,95.38,\"Groundout\",175\n72.29,176.71,\"Flyout\",176\n45.18,213.86,\"Home Run\",177\n111.45,96.39,\"Groundout\",178\n164.66,141.57,\"Flyout\",179\n100.4,76.31,\"Groundout\",180\n102.41,86.35,\"Groundout\",181\n164.66,209.84,\"Double\",182\n32.13,148.59,\"Double\",183\n99.4,83.33,\"Groundout\",184\n125.5,157.63,\"Single\",185\n145.58,188.76,\"Flyout\",186\n135.54,90.36,\"Groundout\",187\n150.6,176.71,\"Flyout\",188\n146.59,84.34,\"Groundout\",189\n86.35,134.54,\"Flyout\",190\n184.74,144.58,\"Single\",191\n160.64,154.62,\"Single\",192\n101.41,78.31,\"Groundout\",193\n106.43,77.31,\"Groundout\",194\n103.41,79.32,\"Groundout\",195\n149.6,78.31,\"Groundout\",196\n113.45,95.38,\"Groundout\",197\n41.16,133.53,\"Double\",198\n122.49,172.69,\"Single\",199\n107.43,76.31,\"Groundout\",200\n198.8,146.59,\"Flyout\",201\n151.61,80.32,\"Groundout\",202\n103.41,78.31,\"Lineout\",203\n211.85,141.57,\"Double\",204\n154.62,208.84,\"Double\",205\n135.54,214.86,\"Triple\",206\n119.48,148.59,\"Single\",207\n110.44,93.37,\"Groundout\",208\n117.47,84.34,\"Pop Out\",209\n110.44,93.37,\"Groundout\",210\n137.55,87.35,\"Groundout\",211\n24.1,145.58,\"Double\",212\n139.56,99.4,\"Pop Out\",213\n167.67,104.42,\"Pop Out\",214\n24.1,191.77,\"Home Run\",215\n195.78,150.6,\"Lineout\",216\n121.49,178.71,\"Flyout\",217\n166.67,194.78,\"Double\",218\n140.56,86.35,\"Groundout\",219\n49.2,150.6,\"Single\",220\n124.5,148.59,\"Single\",221\n81.33,143.57,\"Single\",222\n130.52,157.63,\"Flyout\",223\n109.44,93.37,\"Groundout\",224\n102.41,165.66,\"Flyout\",225\n79.32,145.58,\"Single\",226\n111.45,91.37,\"Groundout\",227\n187.75,144.58,\"Lineout\",228\n100.4,204.82,\"Lineout\",229\n99.4,78.31,\"Groundout\",230\n142.57,88.35,\"Pop Out\",231\n74.3,183.73,\"Double\",232\n69.28,144.58,\"Single\",233\n35.14,151.61,\"Double\",234\n121.49,59.24,\"Groundout\",235\n125.5,72.29,\"Groundout\",236\n113.45,89.36,\"Groundout\",237\n113.45,158.63,\"Single\",238\n180.72,157.63,\"Flyout\",239\n111.45,175.7,\"Single\",240\n121.49,70.28,\"Groundout\",241\n114.46,70.28,\"Groundout\",242\n62.25,208.84,\"Home Run\",243\n105.42,82.33,\"Groundout\",244\n138.55,100.4,\"Groundout\",245\n79.32,127.51,\"Field Error\",246\n111.45,92.37,\"Groundout\",247\n32.13,187.75,\"Home Run\",248\n101.41,89.36,\"Field Error\",249\n125.5,158.63,\"Single\",250\n73.29,144.58,\"Single\",251\n109.44,72.29,\"Groundout\",252\n106.43,77.31,\"Groundout\",253\n159.64,101.41,\"Pop Out\",254\n110.44,75.3,\"Field Error\",255\n108.43,101.41,\"Single\",256\n70.28,144.58,\"Single\",257\n105.42,93.37,\"Field Error\",258\n111.45,176.71,\"Double\",259\n113.45,86.35,\"Groundout\",260\n119.48,98.39,\"Groundout\",261\n69.28,216.87,\"Home Run\",262\n146.59,196.79,\"Lineout\",263\n129.52,103.41,\"Groundout\",264\n161.65,144.58,\"Lineout\",265\n135.54,90.36,\"Groundout\",266\n125.5,152.61,\"Lineout\",267\n105.42,96.39,\"Groundout\",268\n122.49,142.57,\"Single\",269\n107.43,90.36,\"Groundout\",270\n121.49,148.59,\"Lineout\",271\n109.44,99.4,\"Groundout\",272\n125.5,170.68,\"Single\",273\n115.46,226.91,\"Home Run\",274\n150.6,79.32,\"Pop Out\",275\n150.6,96.39,\"Groundout\",276\n108.43,87.35,\"Groundout\",277\n220.88,170.68,\"Home Run\",278\n136.55,90.36,\"Groundout\",279\n146.59,84.34,\"Lineout\",280\n117.47,78.31,\"Groundout\",281\n172.69,203.82,\"Double\",282\n198.8,138.55,\"Lineout\",283\n104.42,93.37,\"Groundout\",284\n124.5,247.99,\"Home Run\",285\n159.64,139.56,\"Single\",286\n119.48,207.83,\"Lineout\",287\n133.53,63.25,\"Groundout\",288\n122.49,148.59,\"Single\",289\n25.1,153.61,\"Home Run\",290\n66.27,131.53,\"Single\",291\n114.46,98.39,\"Groundout\",292\n127.51,70.28,\"Single\",293\n177.71,189.76,\"Double\",294\n168.67,139.56,\"Flyout\",295\n143.57,154.62,\"Single\",296\n100.4,182.73,\"Flyout\",297\n81.33,131.53,\"Single\",298\n21.08,184.74,\"Home Run\",299\n101.41,227.91,\"Home Run\",300\n109.44,75.3,\"Groundout\",301\n18.07,166.67,\"Home Run\",302\n110.44,91.37,\"Groundout\",303\n103.41,81.33,\"Groundout\",304\n83.33,130.52,\"Single\",305\n156.63,223.9,\"Home Run\",306\n104.42,79.32,\"Groundout\",307\n100.4,84.34,\"Groundout\",308\n127.51,150.6,\"Single\",309\n91.37,140.56,\"Lineout\",310\n132.53,161.65,\"Single\",311\n171.69,155.62,\"Flyout\",312\n86.35,213.86,\"Home Run\",313\n153.61,80.32,\"Groundout\",314\n48.19,151.61,\"Single\",315\n79.32,100.4,\"Field Error\",316\n172.69,156.63,\"Flyout\",317\n112.45,92.37,\"Groundout\",318\n113.45,165.66,\"Lineout\",319\n139.56,188.76,\"Flyout\",320\n36.14,140.56,\"Double\",321\n138.55,92.37,\"Groundout\",322\n110.44,94.38,\"Groundout\",323\n160.64,132.53,\"Single\",324\n131.53,83.33,\"Groundout\",325\n76.31,178.71,\"Double\",326\n103.41,83.33,\"Field Error\",327\n108.43,92.37,\"Groundout\",328\n124.5,224.9,\"Home Run\",329\n112.45,100.4,\"Groundout\",330\n109.44,96.39,\"Groundout\",331\n112.45,88.35,\"Groundout\",332\n109.44,96.39,\"Groundout\",333\n117.47,96.39,\"Groundout\",334\n172.69,133.53,\"Flyout\",335\n133.53,71.29,\"Pop Out\",336\n151.61,149.6,\"Single\",337\n172.69,104.42,\"Flyout\",338\n139.56,106.43,\"Groundout\",339\n78.31,155.62,\"Flyout\",340\n118.47,70.28,\"Groundout\",341\n210.84,149.6,\"Double\",342\n182.73,157.63,\"Flyout\",343\n56.22,178.71,\"Double\",344\n169.68,139.56,\"Single\",345\n168.67,152.61,\"Triple\",346\n73.29,193.78,\"Flyout\",347\n112.45,65.26,\"Single\",348\n192.77,173.69,\"Lineout\",349\n109.44,91.37,\"Groundout\",350\n146.59,200.8,\"Flyout\",351\n100.4,93.37,\"Groundout\",352\n150.6,90.36,\"Lineout\",353\n182.73,184.74,\"Flyout\",354\n156.63,153.61,\"Single\",355\n170.68,150.6,\"Single\",356\n115.46,70.28,\"Single\",357\n85.34,118.47,\"Pop Out\",358\n109.44,151.61,\"Flyout\",359\n55.22,145.58,\"Single\",360\n98.39,178.71,\"Lineout\",361\n207.83,226.91,\"Home Run\",362\n103.41,79.32,\"Field Error\",363\n108.43,208.84,\"Flyout\",364\n134.54,100.4,\"Groundout\",365\n69.28,146.59,\"Single\",366\n183.73,131.53,\"Single\",367\n177.71,131.53,\"Single\",368\n149.6,83.33,\"Groundout\",369\n143.57,90.36,\"Groundout\",370\n178.71,140.56,\"Single\",371\n59.24,163.65,\"Flyout\",372\n181.73,135.54,\"Flyout\",373\n72.29,138.55,\"Single\",374\n110.44,88.35,\"Groundout\",375\n141.57,90.36,\"Groundout\",376\n112.45,97.39,\"Groundout\",377\n136.55,106.43,\"Pop Out\",378\n147.59,81.33,\"Groundout\",379\n112.45,74.3,\"Single\",380\n219.88,142.57,\"Double\",381\n175.7,111.45,\"Double\",382\n125.5,150.6,\"Single\",383\n104.42,93.37,\"Groundout\",384\n125.5,66.27,\"Groundout\",385\n209.84,144.58,\"Double\",386\n159.64,138.55,\"Lineout\",387\n221.89,164.66,\"Home Run\",388\n106.43,74.3,\"Groundout\",389\n54.22,203.82,\"Home Run\",390\n143.57,100.4,\"Groundout\",391\n85.34,126.51,\"Single\",392\n119.48,145.58,\"Single\",393\n98.39,197.79,\"Double\",394\n179.72,142.57,\"Single\",395\n132.53,143.57,\"Flyout\",396\n106.43,98.39,\"Groundout\",397\n128.51,174.7,\"Flyout\",398\n103.41,76.31,\"Groundout\",399\n107.43,91.37,\"Groundout\",400\n168.67,141.57,\"Flyout\",401\n111.45,69.28,\"Groundout\",402\n83.33,175.7,\"Flyout\",403\n89.36,127.51,\"Single\",404\n168.67,150.6,\"Flyout\",405\n177.71,118.47,\"Lineout\",406\n179.72,193.78,\"Double\",407\n108.43,218.88,\"Double\",408\n111.45,226.91,\"Home Run\",409\n87.35,148.59,\"Single\",410\n115.46,161.65,\"Single\",411\n113.45,69.28,\"Groundout\",412\n61.24,196.79,\"Home Run\",413\n102.41,82.33,\"Groundout\",414\n207.83,144.58,\"Flyout\",415\n126.51,160.64,\"Single\",416\n168.67,150.6,\"Single\",417\n151.61,82.33,\"Pop Out\",418\n138.55,35.14,\"Pop Out\",419\n160.64,98.39,\"Pop Out\",420\n96.39,80.32,\"Groundout\",421\n170.68,102.41,\"Single\",422\n154.62,78.31,\"Pop Out\",423\n91.37,224.9,\"Home Run\",424"
        },
        {
            "name": "scale/fill",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"Groundout\"\n\"Single\"\n\"Batter Interference\"\n\"Home Run\"\n\"Double\"\n\"Pop Out\"\n\"Lineout\"\n\"Field Error\"\n\"Error\"\n\"Flyout\"\n\"Triple\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-12.5\n262.5"
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-12.5\n262.5"
        }
    ],
    "scales": [
        {
            "name": "fill",
            "type": "ordinal",
            "domain": {
                "data": "scale/fill",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "nice": false,
            "zero": false,
            "clamp": false,
            "range": "width"
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "nice": false,
            "zero": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "symbol",
            "properties": {
                "update": {
                    "x": {
                        "scale": "x",
                        "field": "data.x"
                    },
                    "y": {
                        "scale": "y",
                        "field": "data.-y + 250"
                    },
                    "fill": {
                        "scale": "fill",
                        "field": "data.Description"
                    },
                    "size": {
                        "value": 30
                    }
                },
                "hover": {
                    "size": {
                        "value": 200
                    }
                },
                "ggvis": {
                    "data": {
                        "value": ".0"
                    }
                }
            },
            "from": {
                "data": ".0"
            },
            "key": "data.id"
        }
    ],
    "width": 504,
    "height": 504,
    "legends": [
        {
            "orient": "right",
            "fill": "fill",
            "title": "Description"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "x",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "y",
            "layer": "back",
            "grid": true
        },
        {
            "type": "x",
            "scale": "x",
            "orient": "top",
            "title": "Jose Abreu 2014 Spray Chart",
            "ticks": 0,
            "layer": "back",
            "grid": true,
            "properties": {
                "labels": {
                    "fontSize": {
                        "value": 0
                    }
                },
                "title": {
                    "fontSize": {
                        "value": 12
                    }
                },
                "axis": {
                    "stroke": {
                        "value": "white"
                    }
                }
            }
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 504,
        "height": 504
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id649638610").parseSpec(plot_id649638610_spec);
</script><!--/html_preserve-->

{% endraw %}
