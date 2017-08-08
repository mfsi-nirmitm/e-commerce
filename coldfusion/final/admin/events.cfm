<!---Delete an event if the url.delete variables exists--->
<cfif structKeyExists(url,'delete')>
	<cfset application.eventsService.deleteEvent(url.delete) />
</cfif>
<!---Get the list of current events in the database--->
<cfset currentEvents = application.eventsService.getCurrentEvents() />
<cf_admin title="HD street band - Events administration">
	<script>
		function confirmDelete(eventID)
		{
			if(window.confirm('Are you sure you want to delete this event?'))
			{
				window.location.href = '/final/admin/events.cfm?delete='+eventID;
			}
			else
			{
				null;
			}
		}
	</script>
	<div id="pageBody">
		<h1>Events Administration</h1>
		<cfif structKeyExists(url,'add')>
			<p class="feedback">The event has been successfully created.</p>
		</cfif>
		<cfif structKeyExists(url,'update')>
			<p class="feedback">The event has been successfully updated.</p>
		</cfif>
		<p><a href="eventAdd.cfm">[Add an event]</a></p>
		<cfif currentEvents.recordCount EQ 0>
			<p>There are no events to display at this time.</p>
		<cfelse>
			<table>
				<tr>
					<th>Event Date</th>
					<th>Evant Name</th>
					<th>Event Location</th>
					<th>Created By</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
				<cfoutput query="currentEvents">
					<tr>
						<td>#dateFormat(fld_eventDateTime, 'mmm-dd-yyyy')#</td>
						<td>#fld_eventName#</td>
						<td>#fld_eventLocation# #fld_eventVenue#</td>
						<td>#fld_userFirstName# #fld_userLastName#</td>
						<td><a href="eventEdit.cfm?eventID=#fld_eventID#">Edit this event</a></td>
						<td><a href="javascript:confirmDelete(#fld_eventID#);">Delete this event</a></td>
					</tr>
				</cfoutput>
			</table>
		</cfif>
	</div>
</cf_admin>