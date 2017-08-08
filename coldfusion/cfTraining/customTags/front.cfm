<cfparam name="attributes.title" default="HD street band - Welcome"/>
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><cfoutput>#attributes.title#</cfoutput></title>
<link href="../cfTraining/styles/hdStreet.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../cfTraining/script/jquery.js"></script>
<script type="text/javascript" src="../cfTraining/script/menu.js"></script>
</head>

<body>
<div id="wrapper">
  <div id="header"> <a href="#"><img src="../cfTraining/images/logo.png" alt="logo" name="logo" width="188" height="181" id="logo" /></a>
    <p id="mainTitle"><img src="../cfTraining/images/mainTitle.png" width="398" height="158" alt="HD Street Concert Band" /><span>HD Street Concert Band</span></p>
<ul>
       	<li><a href="siteMap.html">Site Map</a></li>
        <li><a href="contactUs.html">Contact us</a></li>
    </ul>
    <!---Include login form here--->
	<cfinclude template="../includes/loginForm.cfm" />
  </div>
  <div id="menu">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="agenda.html">Agenda</a></li>
      <li><a href="#">The Band</a>
        <ul>
          <li><a href="director.html">The director</a></li>
          <li><a href="history.html">The band History</a></li>
        </ul>
      </li>
      <li><a href="wePlayForYou.html">We play for You</a></li>
      <li><a href="comePlayWithUs.html">Come play with us</a></li>
      <li><a href="news.html">News</a></li>
    </ul>
  </div>
<!---end of header--->
<cfelse>
<!---First line to be included in footer.cfm--->
  <div id="footer">
    <p>&copy; Copyright 2011 - HD Street Concert Band</p>
  </div>
</div>
</body>
</html>
</cfif>