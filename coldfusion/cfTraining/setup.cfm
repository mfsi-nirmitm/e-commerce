
	<!---Adjust event dates--->
	<cfquery name=rs_events datasource="hdStreet" >
		SELECT TBL_EVENTS.FLD_EVENTDATETIME, TBL_EVENTS.FLD_EVENTID
		FROM TBL_EVENTS
	</cfquery>
	<cfloop query="rs_events">
		<cfset eventDate = createDate((year(now())+1),month(#FLD_EVENTDATETIME#),day(#FLD_EVENTDATETIME#)) />
		<cfquery datasource="hdStreet">
			UPDATE TBL_EVENTS
			SET
			FLD_EVENTDATETIME = #eventDate#
			WHERE FLD_EVENTID = #FLD_EVENTID#
		</cfquery>
	</cfloop>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<title>CF training setup</title>
<link href="styles/hdStreet.css" rel="stylesheet" type="text/css" media="screen" />

</head>

<body>

<div id="wrapper">
	<p>Event dates have been updated.</p>
	<p>Go to the <a href="agenda.cfm">Agenda page</a> to check it out!</p>
</div>
</body>
</html>
