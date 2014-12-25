## ui.R
shinyUI(fluidPage(
  #tags$head(includeScript("K:/Shiny/HR Hitters/google-analytics.js")),
  
  titlePanel("Hitters in Baseball History"),
  
  sidebarPanel(
    wellPanel(
      h4("Danny Malter"),
      a("RPubs Profile", href = "https://rpubs.com/DIM302", align="center"),
      br(),
      a("LinkedIn Profile", href = "http://www.linkedin.com/in/danmalter/", align="center"),
      br(),
      a("Twitter Profile", href = "http://www.twitter.com/danmalter/", align="center")),
    wellPanel(
      selectInput("statistic", "Statistic:",
                  list("Runs" = "R",
                       "Hits" = "H", 
                       "Doubles" = "X2B",
                       "Triples" = "X3B",  
                       "Home Runs" = "HR",
                       "RBIs" = "RBI",
                       "Stolen Bases" = "SB",
                       "Caught Stealing" = "CS",
                       "Walks" = "BB",
                       "Strikeouts" = "SO",
                       "Intentional Base on Balls" = "IBB",
                       "Hit by Pitch" = "HBP",
                       "Sacrifice Hits" = "SH",
                       "Sacrifice Flys" = "SF",
                       "Grounders into Double Plays" = "GIDP",
                       "Batting Average" = "BA",
                       "Plate Appearances" = "PA",
                       "Total Bases" = "TB",
                       "Slugging Percentage" = "SlugPct",
                       "On Base Percentage" = "OBP",
                       "On Base Plus Slugging" = "OPS",
                       "Batting Avg. on Balls in Play" = "BABIP")),
      textInput("player2", "Player ID (BLACK LINE)", "aaronha01"),
      HTML
      ("<div style='font-size: 12px;'> Choose a playerID from the table below.</div>"),
      HTML
      ("<div style='font-size: 12px;'> Must have a playerID chosen.</div>"),
      br(),
      selectInput("player",
                  label = "Top 50 HR Hitters (RED LINE)",
                  #choices = players_in_menu,    
                  choices = list("1. Barry Bonds"="bondsba01", "2. Hank Aaron"="aaronha01", "3. Babe Ruth"="ruthba01", "4. Willie Mays"="mayswi01", 
                                 "5. Alex Rodriguez"="rodrial01", "6. Ken Griffey, Jr."="griffke02", "7. Jim Thome"="thomeji01", 
                                 "8. Sammy Sosa"="sosasa01", "9. Frank Robinson"="robinfr02", "10. Mark McGwire"="mcgwima01", "11. Harmon Killebrew"="killeha01", 
                                 "12. Rafael Palmeiro"="palmera01", "13. Reggie Jackson"="jacksre01", "14. Manny Ramirez"="ramirma02", "15. Mike Schmidt"="schmimi01", 
                                 "16. Mickey Mantle"="mantlmi01", "17. Jimmie Foxx"="foxxji01", "18. Willie McCovey"="mccovwi01", "18. Frank Thomas"="thomafr04", 
                                 "18. Ted Williams"="willite01", "21. Albert Pujols"="pujolal01", "22. Ernie Banks"="bankser01", "22. Eddie Mathews"="matheed01", 
                                 "24. Mel Ott"="ottme01", "25. Gary Sheffield"="sheffga01", "26. Eddie Murray"="murraed02", "27. Lou Gehrig"="gehrilo01", 
                                 "27. Fred McGriff"="mcgrifr01", "29. Stan Musial"="musiast01", "29. Willie Stargell"="stargwi01", "31. Carlos Delgado"="delgaca01",
                                 "32. Chipper Jones"="jonesch06", "33. David Ortiz"="ortizda01", "34. Dave Winfield"="winfida01", "35. Jose Canseco"="cansejo01",
                                 "35. Adam Dunn"="dunnad01", "37. Carl Yastrzemski"="yastrca01", "38. Jeff Bagwell"="bagweje01", "38. Vladimir Guerrero"="guerrvl01",
                                 "40. Dave Kingman"="kingmda01", "41. Jason Giambi"="giambja01", "42. Paul Konerko"="konerpa01", "43. Andre Dawson"="dawsoan01",
                                 "44. Juan Gonzalez"="gonzaju03", "44. Andruw Jones"="jonesan01", "46. Cal Ripken, Jr."="ripkeca01", "47. Mike Piazza"="piazzmi01",
                                 "48. Billy Williams"="willibi01", "49. Darrell Evans"="evansda01", "50. Alfonso Soriano"="soriaal01"),
                  selected = "ruthba01"),
      br(),
      sliderInput("range", "Slide to select a date range:",
                  min = 1901, max = 2013, format="###",
                  value = c(1901, 2013), step = 1)
    ),
    wellPanel(
      h5("Notes"),
      HTML
      ("<div style='font-size: 12px;'> - The league average is calculated for players with at least 450 plate appearances in the given year.</div>"),
      br(),
      HTML
      ("<div style='font-size: 12px;'> - All player data is from the Lahman database.</div>")
    )),
  
  mainPanel(
    h4(textOutput("caption")),
    (textOutput("legend1")),
    tags$head(tags$style("#legend1{color: red;
                                 font-size: 12px;;
                                 }")),
    (textOutput("legend2")),
    tags$head(tags$style("#legend2{color: black;
                                 font-size: 12px;;
                                 }")),
    (textOutput("legend3")),
    tags$head(tags$style("#legend3{color: blue;
                                 font-size: 12px;;
                                 }")),
    plotOutput("plot"),
    br(),
    dataTableOutput("myTable"))
))