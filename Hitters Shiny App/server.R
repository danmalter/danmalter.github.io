## server.R
shinyServer(function(input, output) {
  formulaText1 <- reactive({
    paste(input$statistic, " between ",
          input$range[1], "and", input$range[2])
  })
  formulaText2 <- reactive({
    paste(input$player, "- RED ")
  })
  formulaText3 <- reactive({
    paste(input$player2, "- BLACK")
  })
  formulaText4 <- reactive({
    paste("League Avg. - BLUE")
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText1()
  })
  output$legend1 <- renderText({
    formulaText2()
  })
  output$legend2 <- renderText({
    formulaText3()
  })
  output$legend3 <- renderText({
    formulaText4()
  })
  
  # Generate a plot
  output$plot <- renderPlot({
    
    # Give column numbers to each varaible
    if (input$statistic == "R"){
      stat=9
    }else if (input$statistic == "H"){
      stat=10
    }else if (input$statistic == "X2B"){
      stat=11
    }else if (input$statistic == "X3B"){
      stat=12
    }else if (input$statistic == "HR"){
      stat=13
    }else if (input$statistic == "RBI"){
      stat=14
    }else if (input$statistic == "SB"){
      stat=15
    }else if (input$statistic == "CS"){
      stat=16
    }else if (input$statistic == "BB"){
      stat=17
    }else if (input$statistic == "SO"){
      stat=18
    }else if (input$statistic == "IBB"){
      stat=19
    }else if (input$statistic == "HBP"){
      stat=20
    }else if (input$statistic == "SH"){
      stat=21
    }else if (input$statistic == "SF"){
      stat=22
    }else if (input$statistic == "GIDP"){
      stat=23
    }else if (input$statistic == "BA"){
      stat=25
    }else if (input$statistic == "PA"){
      stat=26
    }else if (input$statistic == "TB"){
      stat=27
    }else if (input$statistic == "SlugPct"){
      stat=28
    }else if (input$statistic == "OBP"){
      stat=29
    }else if (input$statistic == "OPS"){
      stat=30
    }else if (input$statistic == "BABIP"){
      stat=31
    }

    
    
    # Aggregate the mean of each statistic for the league data line
    league_player_data <- subset(player_data, PA >= 450)
    league_data <- aggregate(league_player_data[, c(2, stat)], by=list(league_player_data$yearID), FUN=mean, na.rm=TRUE)
    #league_data <- subset(league_data, playerPA > 450)
    #league_data <- league_data[,-1]
    #league_data = ddply(player_data, .(yearID), summarize, HR = mean(HR)) 
    
    # Subset data based on the range of the year
    player_data <- subset(player_data, yearID >= input$range[1] & yearID <= input$range[2])
    player_data2 <- subset(player_data2, yearID >= input$range[1] & yearID <= input$range[2])
    league_data <- subset(league_data, yearID >= input$range[1] & yearID <= input$range[2])
    
    # Subset the player data based on which playerID is selected
    if (input$player !='') player_data <- player_data[which(player_data$playerID==input$player),]
    if (input$player2 !='') player_data2 <- player_data2[which(player_data2$playerID==input$player2),]
    
    # Graphs
    if (input$statistic == "R") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=R), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=R), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=R), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=R), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=R), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 10)) +
        xlab("Year") +
        ylab("Runs")
    }
    else if (input$statistic == "H") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=H), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=H), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=H), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=H), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=H), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 10)) +
        xlab("Year") +
        ylab("Hits")
    }
    else if (input$statistic == "X2B") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=X2B), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=X2B), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=X2B), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=X2B), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=X2B), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 5)) +
        xlab("Year") +
        ylab("Doubles")
    }
    else if (input$statistic == "X3B") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=X3B), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=X3B), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=X3B), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=X3B), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=X3B), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 1)) +
        xlab("Year") +
        ylab("Triples")
    }
    else if (input$statistic == "HR") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=HR), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=HR), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=HR), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=HR), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=HR), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 10)) +
        xlab("Year") +
        ylab("Home Runs")
    }
    else if (input$statistic == "RBI") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=RBI), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=RBI), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=RBI), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=RBI), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=RBI), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 10)) +
        xlab("Year") +
        ylab("Runs Batting In")
    }
    else if (input$statistic == "SB") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=SB), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=SB), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=SB), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=SB), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=SB), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 5)) +
        xlab("Year") +
        ylab("Stolen Bases")
    }
    else if (input$statistic == "CS") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=CS), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=CS), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=CS), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=CS), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=CS), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 5)) +
        xlab("Year") +
        ylab("Caught Stealing")
    }
    else if (input$statistic == "BB") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=BB), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=BB), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=BB), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=BB), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=BB), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 10)) +
        xlab("Year") +
        ylab("Walks")
    }
    else if (input$statistic == "SO") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=SO), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=SO), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=SO), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=SO), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=SO), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 10)) +
        xlab("Year") +
        ylab("Strike Outs")
    }
    else if (input$statistic == "IBB") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=IBB), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=IBB), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=IBB), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=IBB), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=IBB), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 5)) +
        xlab("Year") +
        ylab("Intentional Base on Balls")
    }
    else if (input$statistic == "HBP") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=HBP), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=HBP), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=HBP), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=HBP), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=HBP), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 1)) +
        xlab("Year") +
        ylab("Hit by Pitch")
    }
    else if (input$statistic == "SH") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=SH), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=SH), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=SH), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=SH), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=SH), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 1)) +
        xlab("Year") +
        ylab("Sacrifice Hits")
    }
    else if (input$statistic == "SF") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=SF), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=SF), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=SF), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=SF), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=SF), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 1)) +
        xlab("Year") +
        ylab("Sacrifice Flys")
    }
    else if (input$statistic == "GIDP") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=GIDP), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=GIDP), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=GIDP), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=GIDP), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=GIDP), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 5)) +
        xlab("Year") +
        ylab("Grounders into Double Plays")
    }
    else if (input$statistic == "BA") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=BA), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=BA), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=BA), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=BA), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=BA), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1, .05)) +
        xlab("Year") +
        ylab("Batting Average")
    }
    else if (input$statistic == "PA") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=PA), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=PA), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=PA), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=PA), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=PA), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 25)) +
        xlab("Year") +
        ylab("Plate Appearances")
    }
    else if (input$statistic == "TB") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=TB), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=TB), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=TB), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=TB), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=TB), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1000, 20)) +
        xlab("Year") +
        ylab("Total Bases")
    }
    else if (input$statistic == "SlugPct") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=SlugPct), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=SlugPct), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=SlugPct), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=SlugPct), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=SlugPct), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1, .05)) +
        xlab("Year") +
        ylab("Slugging Percentage")
    }
    else if (input$statistic == "OBP") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=OBP), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=OBP), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=OBP), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=OBP), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=OBP), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1, .05)) +
        xlab("Year") +
        ylab("On Base Percentage")
    }
    else if (input$statistic == "OPS") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=OPS), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=OPS), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=OPS), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=OPS), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=OPS), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 2, .05)) +
        xlab("Year") +
        ylab("On Base + Slugging Percentage")
    }
    else if (input$statistic == "BABIP") {
      ggplot() + 
        geom_point(data=player_data, aes(x=yearID, y=BABIP), color='red') +
        geom_point(data=player_data2, aes(x=yearID, y=BABIP), color='black') +
        geom_line(data=player_data, aes(x=yearID, y=BABIP), color='red') + 
        geom_line(data=player_data2, aes(x=yearID, y=BABIP), color='black') +
        geom_line(data=league_data, aes(x=yearID, y=BABIP), color='blue') +
        theme(plot.background = element_rect(fill = 'white', colour = 'black')) +
        scale_x_continuous(breaks = seq(1900, 2013, 5)) +
        scale_y_continuous(breaks=seq(0, 1, .05)) +
        xlab("Year") +
        ylab("Batting Avg. on Balls in Play")
    }
  })
  
  
  # Generate a table summarizing each players stats
  output$myTable <- renderDataTable({
    aggregate(player_data[c("R", "H", "X2B", "X3B", "HR", "RBI", "SB", "CS", "BB", "SO", "SF")], by=player_data[c("name","playerID")], FUN=sum, na.rm=TRUE)
  })
  
})
