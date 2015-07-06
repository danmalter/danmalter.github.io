---
title: "Connecting to Microsoft SQL Server from R"
layout: post
comments: true
category: R
---

{% raw %}

# Connecting to Microsoft SQL Server from R #

This post is about how to connect to a Microsoft SQL Server database from within R.  This process allows you to manipulate and run SQL queries on live data directly in R.  Step 1 is not neccessary depending on the process used in Step 2, but the directions used to create an ODBC connection in Step 1 are for Windows computers.

#### Step 1:  Create an ODBC connection ####
Note: This step is not neccessary if you use the second option in Step 2.

1.  Open the ODBC Data Source Administrator application.  You can do this by clicking on the Start button and then search for "ODBC".
2. Click the "Add..." button to add a new User DSN and choose "ODBC Driver 11 for SQL Server".
3. Give a name to the new DSN.  This will be used later to make a connection in R.
4. Copy and paste the SQL Server name into where it asks, "What SQL Server do you want to connect to?"
5. Login using SQL Server authentication.
6. Change the default database to the one that you would like to connect to.


#### Step 2:  Open Connections to ODBC from within R ####

There are two ways to connect to the database using the [RODBC package](http://cran.r-project.org/web/packages/RODBC/RODBC.pdf).

- This first method uses the dsn name created in step 1, along with the user Login and Password used to connect to SQL Server.

```r
con <- odbcConnect(dsn, uid = "", pwd = "")
```

- In this second mothod, you can connect directly to your SQL database with the code below by replacing XXX with the proper names.

```r
con <- odbcDriverConnect("Driver= {SQL Server};
                         Server=XXX; Database=XXX; 
                         Uid=XXX; Pwd=XXX")
```

#### Step 3:  Run SQL queries in R ####


Once your connection has been made, you can run any SQL query exaclty as you would within Microsoft SQL Server


```r
df <- sqlQuery(channel = con, "SELECT column_name1, column_name2
                                 FROM table_name
                                 WHERE column_name1 operator value;")
```

From here, your data is now stored within the df variable and you can work on your data frame as you normally would within R.

{% endraw %}

<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-57468410-2', 'auto');
ga('send', 'pageview');

</script>
