## @knitr global.R
## global.R
require(Lahman)
require(ggplot2)
require(plyr)
library(dplyr)
library(markdown)

Master$name <- paste(Master$nameFirst, Master$nameLast, sep=' ')

bstats <- battingStats(data = Lahman::Batting, 
                       idvars = c("playerID", "yearID", "stint", "teamID", "lgID"), 
                       cbind = TRUE)

batting <- merge(bstats,
                 Master[,c("playerID","name")],
                 by="playerID", all.x=TRUE)

#batting$PA <- rowSums(Batting[,c(8,17,19,20,21,22)], na.rm=T)


#dat = batting[,c('playerID', 'yearID', 'name', 'G', 'SO', 'HR', 'R', 'H', 'X2B', 'X3B', 'BB', 'SO', 'BB', 'SB', 'AB', 'PA', 'BA')]
#dat <- dat[, -c(12, 13)]


player_data = subset(batting, PA >= 0)
player_data2 = player_data
# league_data = ddply(player_data, .(yearID), summarize, HR = mean(HR)) 

player_table <- aggregate(player_data[c("SO", "HR", "H", "R", "X2B", "X3B", "BB", "SB")], by=player_data[c("name","playerID")], FUN=sum)


#list of top home run hitters
top_30 <- 
    player_data %>%
    group_by(playerID, name) %>%
    summarize(HR = sum(HR)) %>%
    arrange(desc(HR)) %>%
    head(500)

players_in_menu = top_30[1:500,]$playerID
#player_appearances = count(player_data, .(name))
#counts <- aggregate(player_data, by=list(player_data$name, player_data$HR), FUN=length)





