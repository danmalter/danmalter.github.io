---
title: "Setting up RStudio over Amazon EC2"
layout: post
comments: true
category: R
---

{% raw %}

# Guide to Setting up RStudio over Amazon EC2 #

### Setting up Elastic Cloud Computing ###

Step 1: Log into [Amazon AWS](https://aws.amazon.com/)

Step 2: Click the EC2 icon - Virtual Servers in the Cloud <br><br>
![plot of chunk image1](/figure/2015-12-03-RStudio-Server/image1.png)

Step 3: Launch an Instance <br>
<ul>
  <li>Click "Launch Instance" and choose an Amazon Machine Image.  This example will be used with an Amazon Linux AMI</li>
  <li>Choose an Instance type:  Amazon offers 1 free year at the t2.micro level</li>
  <li>Configure Instance Details: Select advanced details and add the following information</li>
</ul>  

```r
#!/bin/bash
#install R
yum install -y R
#install RStudio-Server
wget https://download2.rstudio.org/rstudio-server-rhel-0.99.465-x86_64.rpm
yum install -y --nogpgcheck rstudio-server-rhel-0.99.465-x86_64.rpm
#install shiny and shiny-server
R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
wget https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.4.0.718-rh5-x86_64.rpm
yum install -y --nogpgcheck shiny-server-1.4.0.718-rh5-x86_64.rpm
#add user(s)
useradd username
echo username:password | chpasswd
```
<b> NOTE:  Change username and password based on your requirements. </b><br>

<ul>
  <li>Add Storage: For normal setup, this step can be skipped</li>
  <li>Tag Instance: Give your Instance a name</li>
  <li>Congifure Security Group and add the following rules
      <ul>
      <li>Note that port 8787 is what allows the connection to RStudio Server.  Additionally, if you wish to open your server up to other IP addresses, you will have to alter the settings.</li>
      </ul>
  </li>
</ul>  

![plot of chunk image2](/figure/2015-12-03-RStudio-Server/image2.png)

<ul>
  <li>Launch the Instance:</li>
      <ul>
      <li>If you do not already have a private key pair, you will have to download one to your local machine.  Keep this in a private location on your computer.</li>
      </ul>
</ul>  

Step 4: Open RStudio Server <br>
- On the AWS Console, find the public DNS of your running instance.  Copy and paste it into a browser followed by :8787

<b> NOTE: </b><br> 
Even if the instance appears to be showing with the green dot, you will still have to wait for the status check to complete before being able to login to your RStudio session. </b><br>

<b> REMEMBER TO STOP OR TERMINATE YOUR INSTANCE </b><br>

{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57468410-2', 'auto');
  ga('send', 'pageview');

</script>
