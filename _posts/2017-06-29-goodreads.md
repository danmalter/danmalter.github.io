---
  title: "Goodreads Analysis of Titles Containing 'Boy' and 'Girl'"
layout: post
comments: true
category: R
---


<!-- Here we style our button a little bit -->

<style>
.showopt {
  background-color: #004c93;
  color: #FFFFFF; 
  width: 100px;
  height: 20px;
  text-align: center;
  vertical-align: middle !important;
  float: right;
  font-family: sans-serif;
  border-radius: 8px;
}

.showopt:hover {
    background-color: #dfe4f2;
    color: #004c93;
}

pre.plot {
  background-color: white !important;
}
</style>


<!--Include script for hiding output chunks-->
<script src="/javascripts/hideOutput.js"></script>

{% raw %}

# Analyzing Book Titles Containing 'Boy' and 'Girl' #

This analysis is inspired by the FiveThirtyEight post, [The Gone Girl With The Dragon Tattoo On The Train](https://fivethirtyeight.com/features/the-gone-girl-with-the-dragon-tattoo-on-the-train/), in which the authors asks the question, 
"why are there so many books with 'girl' in the title?".  The goal of this analysis is to replicate the code used to collect reading data 
from [Goodreads.com](https://www.goodreads.com/).

<div class="fold s">
```r
# Load in the required packages
library(rvest)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
```
</div>

```r
# initialize tables
girl.title <- NULL
boy.title <- NULL

#girl.author <- NULL
#boy.author <- NULL

girl.rating <- NULL
boy.rating <- NULL

girl.published  <- NULL
boy.published <- NULL

girl.editions  <- NULL
boy.editions <- NULL
```

```r
# Find URL
for(i in 1:100){
  girl.url <- paste('https://www.goodreads.com/search?page=',i,'&q=girl&search%5Bfield%5D=title&search_type=books&tab=books&utf8=%E2%9C%93', sep='')
  girl.webpage <- read_html(girl.url)
  
  boy.url <- paste('https://www.goodreads.com/search?page=',i,'&q=boy&search%5Bfield%5D=title&search_type=books&tab=books&utf8=%E2%9C%93', sep='')
  boy.webpage <- read_html(boy.url)
  
  ### Title ###
  
  # grab girl title
  girl.title.table <- html_nodes(girl.webpage,'.bookTitle') %>%
    html_text() %>%
    str_replace_all("[\r\n]" , "") %>%
    str_trim(side = "both") %>%
    as.data.frame()
  
  # bind to dataframe
  girl.title <- rbind(girl.title, girl.title.table)
  
  # grab boy title
  boy.title.table <- html_nodes(boy.webpage,'.bookTitle') %>%
    html_text() %>%
    str_replace_all("[\r\n]" , "") %>%
    str_trim(side = "both") %>%
    as.data.frame()
  
  # bind to dataframe
  boy.title <- rbind(boy.title, boy.title.table)
  
  # ### Author ###
  # #grab girl author
  # girl.author.table <- html_nodes(girl.webpage,'.tableList') %>%
  #       html_text() %>%
  #       as.data.frame()
  #   
  # #bind to dataframe
  # girl.author <- rbind(girl.author, girl.author.table)
  #   
  # #grab boy author
  # boy.author.table <- html_nodes(boy.webpage,'.tableList') %>%
  # html_text() %>%
  #   as.data.frame()
  # 
  # #bind to dataframe
  # boy.author <- rbind(boy.author, boy.author.table)
  
  ### Rating ###
  
  # grab firl rating
  girl.rating.table <- html_nodes(girl.webpage,'.minirating') %>%
    html_text() %>%
    str_trim(side = "both") %>%
    as.data.frame()
  
  # bind to dataframe
  girl.rating <- rbind(girl.rating, girl.rating.table)
  
  # grab boy rating
  boy.rating.table <- html_nodes(boy.webpage,'.minirating') %>%
    html_text() %>%
    str_trim(side = "both") %>%
    as.data.frame()
  
  # bind to dataframe
  boy.rating <- rbind(boy.rating, boy.rating.table)
  
  
  ### Published ###
  
  # grab girl published
  girl.published.table <- html_nodes(girl.webpage,'.uitext') %>%
    html_text() %>%
    as.data.frame()
  
  # bind to dataframe
  girl.published <- rbind(girl.published, girl.published.table)
  
  # grab boy published
  boy.published.table <- html_nodes(boy.webpage,'.uitext') %>%
    html_text() %>%
    as.data.frame()
  
  # bind to dataframe
  boy.published <- rbind(boy.published, boy.published.table)
  
  
  ### Editions ###
  
  # grab girl editions
  girl.editions.table <- html_nodes(girl.webpage,'.greyText a') %>%
    html_text() %>%
    as.data.frame()
  
  # bind to dataframe
  girl.editions <- rbind(girl.editions, girl.editions.table)
  
  # grab boy editions
  boy.editions.table <- html_nodes(boy.webpage,'.greyText a') %>%
    html_text() %>%
    as.data.frame()
  
  # bind to dataframe
  boy.editions <- rbind(boy.editions, boy.editions.table)
}
```

```r
# clean title
names(girl.title)[1] <- "girl.title"
names(boy.title)[1] <- "boy.title"

# clean author
# names(girl.author)[1] <- "author"
# names(boy.author)[1] <- "author"
# 
# girl.author <- str_replace_all(girl.author$author, "[\r\n]" , "")
# girl.author <- data.frame( do.call( cbind, strsplit( girl.author, 'by' ) ) ) 
# girl.author <- girl.author[-1,]  # remove first row
# girl.author <- gather(girl.author)
# names(girl.author)[names(girl.author) == 'value'] <- 'author'
# girl.author <- sub('avg rating — .*', '', girl.author$author)
# girl.author <- gsub('[[:digit:]]+', '', girl.author)
# girl.author <- gsub("[.]","",girl.author) 
# girl.author <- sub(".(Goodreads Author).*", " \\", girl.author)
# girl.author <- sub(").*", " \\", girl.author)
# girl.author <- str_trim(girl.author, side = "both")
# girl.author <- as.data.frame(girl.author)
# girl.author <- girl.author[!apply(girl.author == "", 1, all),]
# girl.author <- gsub(",.*$", "", girl.author)
# 
# boy.author <- str_replace_all(boy.author$author, "[\r\n]" , "")
# boy.author <- data.frame( do.call( cbind, strsplit( boy.author, 'by' ) ) ) 
# boy.author <- boy.author[-1,]  # remove first row
# boy.author <- gather(boy.author)
# names(boy.author)[names(boy.author) == 'value'] <- 'author'
# boy.author <- sub('avg rating — .*', '', boy.author$author)
# boy.author <- gsub('[[:digit:]]+', '', boy.author)
# boy.author <- gsub("[.]","",boy.author) 
# boy.author <- sub(".(Goodreads Author).*", " \\", boy.author)
# boy.author <- sub(").*", " \\", boy.author)
# boy.author <- str_trim(boy.author, side = "both")
# boy.author <- as.data.frame(boy.author)
# boy.author <- boy.author[!apply(boy.author == "", 1, all),]
# boy.author <- gsub(",.*$", "", boy.author)

# clean rating
names(girl.rating)[1] <- "rating"
names(boy.rating)[1] <- "rating"

girl.avg.rating <- sub(' avg rating.*', '', girl.rating$rating)
girl.total.ratings <- sub('.*rating — ', '', girl.rating$rating)
girl.total.ratings <- sub(' .*', '', girl.total.ratings)
girl.total.ratings <- gsub(',', '', girl.total.ratings)

boy.avg.rating <- sub(' avg rating.*', '', boy.rating$rating)
boy.total.ratings <- sub('.*rating — ', '', boy.rating$rating)
boy.total.ratings <- sub(' .*', '', boy.total.ratings)
boy.total.ratings <- gsub(',', '', boy.total.ratings)

# clean published
names(girl.published)[1] <- "published"
names(boy.published)[1] <- "published"

girl.published <- gsub('*\n[A-z ]*', '' , girl.published$published)
girl.published <- girl.published[lapply(girl.published,function(x) length(grep("Clear rating",x,value=FALSE))) == 0]
girl.published <- girl.published[lapply(girl.published,function(x) length(grep("Rate this book",x,value=FALSE))) == 0]
girl.published <- sub('.*ratings—', '', girl.published)
girl.published <- sub('—.*', '', girl.published)
girl.published <- ifelse(grepl("edition", girl.published), NA, girl.published) # some books don't contain published years
girl.published <- ifelse(grepl("rating", girl.published), NA, girl.published)

boy.published <- gsub('*\n[A-z ]*', '' , boy.published$published)
boy.published <- boy.published[lapply(boy.published,function(x) length(grep("Clear rating",x,value=FALSE))) == 0]
boy.published <- boy.published[lapply(boy.published,function(x) length(grep("Rate this book",x,value=FALSE))) == 0]
boy.published <- sub('.*ratings—', '', boy.published)
boy.published <- sub('—.*', '', boy.published)
boy.published <- ifelse(grepl("edition", boy.published), NA, boy.published)  # some books don't contain published years
boy.published <- ifelse(grepl("rating", boy.published), NA, boy.published)

# clean editions
names(girl.editions)[1] <- "editions"
names(boy.editions)[1] <- "editions"

girl.editions <- sub(' .*', '', girl.editions$editions)
boy.editions <- sub(' .*', '', boy.editions$editions)
```

```r
### Combine into Dataframe ###

girl <- as.data.frame(cbind(girl.title, girl.avg.rating, girl.total.ratings, girl.published, girl.editions))
girl$girl.title <- as.character(girl$girl.title)
girl$girl.avg.rating <- as.numeric(as.character(girl$girl.avg.rating))
girl$girl.total.ratings <- as.numeric(as.character(girl$girl.total.ratings))
girl$girl.published <- as.numeric(as.character(girl$girl.published))
girl$girl.editions <- as.numeric(as.character(girl$girl.editions))
girl[is.na(girl)] <- 0
girl[grepl("girl", girl$girl.title) | grepl("Girl", girl$girl.title), ]

boy <- as.data.frame(cbind(boy.title, boy.avg.rating, boy.total.ratings, boy.published, boy.editions))
boy$boy.title <- as.character(boy$boy.title)
boy$boy.avg.rating <- as.numeric(as.character(boy$boy.avg.rating))
boy$boy.total.ratings <- as.numeric(as.character(boy$boy.total.ratings))
boy$boy.published <- as.numeric(as.character(boy$boy.published))
boy$boy.editions <- as.numeric(as.character(boy$boy.editions))
boy[is.na(boy)] <- 0
boy <- boy[grepl("boy", boy$boy.title) | grepl("Boy", boy$boy.title), ]
```

### Count of Books on Goodreads ###

```r
# Count of Books
ggplot(final.df, aes(x = published)) + 
  geom_line(aes(y = boy.count, colour="#00BFC4")) + #blue
  geom_line(aes(y = girl.count, colour = '#F8766D')) + #red
  scale_x_continuous(limits = c(1984, 2016), breaks = seq(1984,2016,2)) +
  scale_y_continuous(limits = c(0, 250), breaks = seq(0, 250, 25), labels = comma) +
  xlab('Year Published') + 
  ylab('Count of Books') +
  ggtitle('Total Count of Books Containing "Boy(s)" or "Girl(s)"') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_color_manual(name = '', labels = c("Boy(s)", "Girl(s)"), values = c("#00BFC4", "#F8766D")) + 
  theme(plot.caption=element_text(hjust = 0)) +  
  labs(caption = "Boy(s)
       2005: The Boy in the Striped Pajamas
       2014: Heaven is for Real: A Little Boy's Astounding Story of His Trip to Heaven and Back
       
       Girl(s)
       2005: The Girl with the Dragon Tattoo
       2009: Girl with a Pearl Earring
       2012: Gone Girl
       2015: The Girl on the Train
       ")
```

### Average Rating by Year ###

```r
# Average Rating by Year
ggplot(final.df, aes(x = published)) + 
  geom_line(aes(y = boy.avg.rating, colour="#00BFC4")) + #blue
  geom_line(aes(y = girl.avg.rating, colour = '#F8766D')) + #red
  scale_x_continuous(limits = c(1984, 2016), breaks = seq(1984,2016,2)) +
  scale_y_continuous(limits = c(3, 4), breaks = seq(3, 4,.1), labels = comma) +
  xlab('Year Published') + 
  ylab('Rating') +
  ggtitle('Average Rating of Books Containing "Boy(s)" or "Girl(s)"') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_color_manual(name = '', labels = c("Boy(s)", "Girl(s)"), values = c("#00BFC4", "#F8766D"))
```

```r

```

```r

```

{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-57468410-2', 'auto');
ga('send', 'pageview');

</script>
  
  
