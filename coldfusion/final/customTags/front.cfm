<cfparam name="attributes.title" default="HD street band - Welcome" >
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><cfoutput>#attributes.title#</cfoutput></title>
<link href="../final/styles/hdStreet.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../final/script/jquery.js"></script>
<script type="text/javascript" src="../final/script/menu.js"></script>
</head>

<body>
<div id="wrapper">
  <div id="header"> <a href="#"><img src="../final/images/logo.png" alt="logo" name="logo" width="188" height="181" id="logo" /></a>
    <p id="mainTitle"><img src="../final/images/mainTitle.png" width="398" height="158" alt="HD Street Concert Band" /><span>HD Street Concert Band</span></p>
<ul>
       	<li><a href="siteMap.cfm">Site Map</a></li>
        <li><a href="contactUs.cfm">Contact us</a></li>
    </ul>
    <!---Include login form here--->
    <cfinclude template="../includes/loginForm.cfm" />
  </div>
  <div id="menu">
    <ul>
      <li><a href="index.cfm">Home</a></li>
      <li><a href="agenda.cfm">Agenda</a></li>
      <li><a href="#">The Band</a>
        <ul>
          <li><a href="director.cfm">The director</a></li>
          <li><a href="history.cfm">The band History</a></li>
        </ul>
      </li>
      <li><a href="wePlayForYou.cfm">We play for You</a></li>
      <li><a href="comePlayWithUs.cfm">Come play with us</a></li>
      <li><a href="news.cfm">News</a></li>
    </ul>
  </div>
  <!---end of header--->
  <cfelse>
  <!---begin of footer--->
  <div id="footer">
    <p>&copy; Copyright 2016 - HD Street Concert Band</p>
  </div>
</div>
</body>
</cfif>
</html>