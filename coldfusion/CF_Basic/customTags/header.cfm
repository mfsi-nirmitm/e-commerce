<!---
Page functionality : header front page
Date - 17-jul-2017

--->
<cfparam name="attributes.title" default="CFBasicAssignment" >
<cfif thistag.executionMode EQ 'start'>
<!---header part--->
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title><cfoutput>#attributes.title#</cfoutput></title>
	<link rel="stylesheet" href="css/style.css" />
	<link href='http://fonts.googleapis.com/css?family=Oleo+Script' rel='stylesheet' type='text/css'>
	<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="js/script.js"></script>
</head>
<body>
<cfelse>
<!---footer part--->
	</body>
</html>
</cfif>