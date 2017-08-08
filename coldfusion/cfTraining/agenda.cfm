<!---Output a single agenda if url.eventID is defined--->
<cfset rsSingleEvent = application.eventsService.getEventByID(url.eventID) />
<!---Output the upcoming event table if url.eventID not defined--->
<cfset rsCurrentEvents = application.eventsService.getCurrentEvents() />
<cf_front title="Agenda">
  <div id="pageBody">
    <div id="calendarContent">
		<cfif isDefined('url.eventID')>
			<cfquery datasource = "hdStreet" name= "rsSingleEvent">
				SELECT FLD_EVENTID, FLD_EVENTNAME, FLD_EVENTDATETIME, FLD_EVENTLOCATION, FLD_EVENTVENUE, FLD_EVENTDESCRIPTION
				FROM TBL_EVENTS
				WHERE FLD_EVENTID = #url.eventID#
			</cfquery>
			<cfoutput>
				<h1>#rsSingleEvent.fld_eventName#</h1>
				#rsSingleEvent.fld_eventDescription#
			</cfoutput>
			<a href="agenda.cfm">Go back to the agenda.</a>
		<cfelse>
		<cfquery datasource = "hdStreet" name = "rsCurrentEvents" >
			SELECT FLD_EVENTID, FLD_EVENTNAME, FLD_EVENTDATETIME, FLD_EVENTLOCATION, FLD_EVENTVENUE
			FROM TBL_EVENTS
			WHERE FLD_EVENTDATETIME >= #now()#
			ORDER BY FLD_EVENTDATETIME ASC
		</cfquery>
<h1> Agenda</h1>
	<cfif rsCurrentEvents.recordCount EQ 0 >
		<p>Sorry, there are no events to display at this time.</p>
	<cfelse>
		<table>
			<cfoutput query = "rsCurrentEvents" >
				<tr>
					<th>#dateFormat(FLD_EVENTDATETIME, 'mmm dd yyyy')#</th>
					<td>#FLD_EVENTNAME# - #FLD_EVENTLOCATION# - (#FLD_EVENTVENUE#)</td>
					<td><a href="agenda.cfm?eventID=#rsCurrentEvents.FLD_EVENTID#">Read More</a></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
	</cfif>
</div>
    <div id="calendarSideBar">
		<cfif isDefined('url.eventID')>
			saregamapa
		<cfelse>
			<cfoutput>
	<h1>Next Event</h1>
      <div id="EventDetails">
        <p id="eventDate"><span id="month">#dateformat(rsCurrentEvents.FLD_EVENTDATETIME,'MMM')#</span> <span id="days">#dateformat(rsCurrentEvents.FLD_EVENTDATETIME,'dd')#</span></p>
        <h2>#rsCurrentEvents.FLD_EVENTNAME# - #rsCurrentEvents.FLD_EVENTLOCATION#</h2>
      </div>
      <p>#rsCurrentEvents.FLD_EVENTVENUE#</p>
      <p class="alignRight"><a href="events/20110719.html">Read More</a></p>
			</cfoutput>
		</cfif>
</div>
  </div>
</cf_front>
