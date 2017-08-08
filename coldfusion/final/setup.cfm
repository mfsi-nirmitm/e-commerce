<cfset success = false />
<cfif isDefined('form.configureBtn')>

	<!---Log in to the AdminAPI --->
	<cfset CreateObject("component", "cfide.adminapi.administrator").login(form.password) />
	<!--- Create datasource for final website--->
	<cfset datasources = CreateObject("component", "cfide.adminapi.datasource") />
	<cfset datasources.setDerbyEmbedded(
		name="hdStreet-final"
		, database="#ExpandPath("/final/database/")#"
		, driver="Apache Derby Embedded"
		, class="org.apache.derby.jdbc.EmbeddedDriver"
		, description="Database for the final hdStreet site"
		, isnewdb="false") />
	<cfset success = true />
	<!---Adjust event dates--->
	<cfquery name=rs_events>
		SELECT TBL_EVENTS.FLD_EVENTDATETIME, TBL_EVENTS.FLD_EVENTID
		FROM TBL_EVENTS
	</cfquery>
	<cfloop query="rs_events">
		<cfset eventDate = createDate((year(now())+1),month(#FLD_EVENTDATETIME#),day(#FLD_EVENTDATETIME#)) />
		<cfquery>
			UPDATE TBL_EVENTS
			SET
			FLD_EVENTDATETIME = #eventDate#
			WHERE FLD_EVENTID = #FLD_EVENTID#
		</cfquery>
	</cfloop>
</cfif>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<title>CF training setup</title>
<link href="styles/hdStreet.css" rel="stylesheet" type="text/css" media="screen" />

</head>

<body>

<cfif success>
	<p>Setup is complete</p>
<cfelse>
<form method="post">
Please provide the password for the ColdFusion Administrator<br />
<input type="password" name="password" id="password" /><br />
<input type="submit" name="configureBtn" value="Configure" />
</form>
</cfif>
</body>
</html>
