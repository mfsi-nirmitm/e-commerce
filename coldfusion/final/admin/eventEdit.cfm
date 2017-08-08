<!---Form processing begins here--->
<cfif structKeyExists(form,'fld_updateEventSubmit')>
	<cfset aErrorMessages = application.eventsService.validateEventForm(form.fld_eventName,form.fld_eventDate,form.fld_eventLocation,form.fld_eventVenue,form.fld_eventDescription) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.eventsService.updateEvent(form.fld_eventName,form.fld_eventDate,form.fld_eventLocation,form.fld_eventVenue,form.fld_eventDescription,form.fld_eventID) />
		<cflocation url="events.cfm?update=true" />
	</cfif>
</cfif>
<!---Form processing ends here--->

<!---Check if the eventID parameter exists in the URL scope--->
<cfif NOT structKeyExists(url,'eventID')>
	<cflocation url="events.cfm" />
</cfif>
<!---Retrieve current event data--->
<cfset eventToUpdate = application.eventsService.getEventByID(url.eventID) />
<cf_admin title="HD street band - Events administration">
	<div id="pageBody">
		<h1>Edit an event</h1>
				<!---Display add event form--->
		<cfform id="frm_updateEvent" preservedata="true">
			<fieldset>
				<!---Output error messages if any--->
				<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
						<cfloop array="#variables.aErrorMessages#" index="message">
							<p class="errorMessage">#message#</p>
						</cfloop>
					</cfoutput>
				</cfif>
				<legend>Add a new event</legend>
				<dl>
					<!---Display add event form fields--->
					<dt><label for="fld_eventName">Event Name</label></dt>
					<dd><cfinput type="text" name="fld_eventName" value="#eventToUpdate.fld_eventName#" id="fld_eventName" required="true" message="Please provide a valid name for the event" validateAt="onSubmit"  /></dd>
					<dt><label for="fld_eventDate">Event Date</label></dt>
					<dd><cfinput type="datefield" mask="MM/DD/YYYY" name="fld_eventDate" value="#dateFormat(eventToUpdate.fld_eventDateTime, 'MM/DD/YYYY')#" id="fld_eventDate" required="true" message="Please provide a valid date for your event" validateAt="onSubmit" /></dd>
					<dt><label for="fld_eventLocation">Event Location</label></dt>
					<dd><cfinput name="fld_eventLocation" id="fld_eventLocation" value="#eventToUpdate.fld_eventLocation#" required="true" message="Please provide a location for youy new event" validateAt="onSubmit" /></dd>
					<dt><label for="fld_eventVenue">Event Venue</label></dt>
					<dd><cfinput name="fld_eventVenue" id="fld_eventVenue" value="#eventToUpdate.fld_eventVenue#" /></dd>
					<dt><label for="fld_eventDescription">Event Description</label></dt>
					<dd>
						<cftextarea name="fld_eventDescription" id="fld_eventDescription" required="true" message="Please, provide a short description for your event" validateAt="onSubmit" richtext="true" height="500" >
							<cfoutput>#eventToUpdate.fld_eventDescription#</cfoutput>
						</cftextarea>
					</dd>
				</dl>
				<cfinput type="hidden" name="fld_eventID" value="#eventToUpdate.fld_eventID#" />
				<input type="submit" name="fld_updateEventSubmit" id="fld_updateEventSubmit" value="Update Event" />
			</fieldset>
		</cfform>
	</div>
</cf_admin>