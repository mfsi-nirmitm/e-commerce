<cf_front title="HD street band - Agenda">
  <div id="pageBody">
    <div id="calendarContent">
    	<cfif isDefined('url.eventID')>
    		<!---Output a single agenda if url.eventID is defined--->
    		<cfset rsSingleEvent = application.eventsService.getEventByID(url.eventID) />
			<cfoutput>
				<h1>#rsSingleEvent.fld_eventName#</h1>
				#rsSingleEvent.fld_eventDescription#
			</cfoutput>
			<p><a href="agenda.cfm">Back to the agenda</a></p>
    	<cfelse>
    		<!---Output the upcoming event table if url.eventID not defined--->
    		<cfset rsCurrentEvents = application.eventsService.getCurrentEvents() />
    	
	<h1> Agenda</h1>
	<cfif rsCurrentEvents.recordCount EQ 0>
		<p>Sorry, there are no events to display at this time.</p>
	<cfelse>
		<table>
			<cfoutput query="rsCurrentEvents">
				<tr>
					<th>#dateFormat(FLD_EVENTDATETIME, 'mmm dd yyyy')#</th>
					<td>#FLD_EVENTNAME# - #FLD_EVENTLOCATION# (#FLD_EVENTVENUE#)</td>
					<td><a href="agenda.cfm?eventID=#fld_eventID#">Read More</a></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
     </cfif>
</div>
    <div id="calendarSideBar">
    	<cfif isDefined('url.eventID')>
    		<cfoutput>
    			<h1>Event Details</h1>
    			<div id="EventDetails">
					<p id="eventDate"><span id="month">#dateFormat(rsSingleEvent.fld_eventDateTime, 'mmm')#</span> <span id="days">#dateFormat(rsSingleEvent.fld_eventDateTime,'dd')#</span></p>
					<h2>#rsSingleEvent.fld_eventName#</h2>
					</div>
					<p> #rsSingleEvent.fld_eventLocation# <br /> #rsSingleEvent.fld_eventvenue# </p>
    		</cfoutput>
    	<cfelse>
	    	<cfif rsCurrentEvents.recordCount EQ 0>
	    		<p>Sorry, there are no events to display at this time.</p>
	    	<cfelse>
	    		<cfoutput >
					<h1>Next Event</h1>
				      <div id="EventDetails">
				        <p id="eventDate"><span id="month">#dateformat(rsCurrentEvents.FLD_EVENTDATETIME, 'mmm')#</span> <span id="days">#dateformat(rsCurrentEvents.FLD_EVENTDATETIME, 'dd')#</span></p>
				        <h2>#rsCurrentEvents.FLD_EVENTNAME# - #rsCurrentEvents.FLD_EVENTLOCATION#</h2>
				      </div>
				      <p>#rsCurrentEvents.FLD_EVENTVENUE# </p>
				      <p class="alignRight"><a href="agenda.cfm?eventID=#rsCurrentEvents.fld_eventID#">Read More</a></p>
			      </cfoutput>
	      </cfif>
	    </cfif>
</div>
  </div>
 </cf_front>
