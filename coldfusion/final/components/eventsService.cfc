<cfcomponent output="false">
	<!---geteventByID() method --->
	<cffunction name="getEventByID" access="public" output="false" returntype="query">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfset var rsSingleEvent = '' />
		<cfquery  name="rsSingleEvent">
			SELECT FLD_EVENTID, FLD_EVENTNAME, FLD_EVENTDATETIME, FLD_EVENTLOCATION,
			FLD_EVENTVENUE, FLD_EVENTDESCRIPTION
			FROM TBL_EVENTS
			WHERE FLD_EVENTID = <cfqueryparam value="#arguments.eventID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn rsSingleEvent />
	</cffunction>
	
	<!---getCurrentEvents() method --->
	<cffunction name="getCurrentEvents" access="public" output="false" returntype="query">
		<cfargument name="numEvents" type="numeric" required="false" default="-1">
		<cfset var rsCurrentEvents = '' />
		<cfquery  name="rsCurrentEvents" maxrows="#arguments.numEvents#">
    		SELECT TBL_EVENTS.FLD_EVENTID, TBL_EVENTS.FLD_EVENTNAME, TBL_EVENTS.FLD_EVENTDATETIME, TBL_EVENTS.FLD_EVENTLOCATION, TBL_EVENTS.FLD_EVENTVENUE, TBL_USERS.FLD_USERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME
    		FROM TBL_EVENTS INNER JOIN TBL_USERS ON TBL_EVENTS.FLD_EVENTAUTHOR = TBL_USERS.FLD_USERID
    		WHERE FLD_EVENTDATETIME >= #now()#
    		ORDER BY FLD_EVENTDATETIME ASC
    	</cfquery>
    	<cfreturn rsCurrentEvents />
	</cffunction>
		<!--- updateEvent() method --->
	<cffunction name="updateEvent" access="public" output="false" returntype="void" roles="Administrator">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventDate" type="string" required="true" /> 
		<cfargument name="eventLocation" type="string" required="true" />
		<cfargument name="eventVenue" type="string" required="true" />
		<cfargument name="eventDescription" type="string" required="true" />
		<cfargument name="eventID" type="numeric" required="true" />
		<cfquery>
			UPDATE TBL_EVENTS
			SET
			FLD_EVENTNAME = <cfqueryparam value="#arguments.eventName#" cfsqltype="cf_sql_varchar" />,
			FLD_EVENTDATETIME = <cfqueryparam value="#arguments.eventDate#" cfsqltype="cf_sql_date" />,
			FLD_EVENTLOCATION = <cfqueryparam value="#arguments.eventLocation#" cfsqltype="cf_sql_varchar" />,
			FLD_EVENTVENUE = <cfqueryparam value="#arguments.eventVenue#" cfsqltype="cf_sql_varchar" />,
			FLD_EVENTDESCRIPTION = <cfqueryparam value="#arguments.eventDescription#" cfsqltype="cf_sql_longvarchar" />
			WHERE
			FLD_EVENTID = <cfqueryparam value="#arguments.eventID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	
	<!--- addEvent() method --->
	<cffunction name="addEvent" access="public" output="false" returntype="void" roles="Administrator">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventDate" type="string" required="true" /> 
		<cfargument name="eventLocation" type="string" required="true" />
		<cfargument name="eventVenue" type="string" required="true" />
		<cfargument name="eventDescription" type="string" required="true" />
		<cfquery>
			INSERT INTO TBL_EVENTS
			(FLD_EVENTNAME, FLD_EVENTDATETIME, FLD_EVENTLOCATION, FLD_EVENTVENUE, FLD_EVENTDESCRIPTION, FLD_EVENTAUTHOR, FLD_EVENTCREATIONDATE)
			VALUES
			(<cfqueryparam value="#arguments.eventName#" cfsqltype="cf_sql_varchar" />, <cfqueryparam value="#arguments.eventDate#" cfsqltype="cf_sql_date" />, <cfqueryparam value="#arguments.eventLocation#" cfsqltype="cf_sql_varchar" />, <cfqueryparam value="#arguments.eventVenue#" cfsqltype="cf_sql_varchar" />, <cfqueryparam value="#arguments.eventDescription#" cfsqltype="cf_sql_longvarchar" />, <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />, <cfqueryparam value="#now()#" cfsqltype="cf_sql_date" />)
		</cfquery>
	</cffunction>
	
	<!--- deleteEvent() method --->
	<cffunction name="deleteEvent" access="public" output="false" returntype="void" roles="Administrator">
		<cfargument name="eventID" type="numeric" required="true" />
		<cfquery>
			DELETE FROM TBL_EVENTS
			WHERE FLD_EVENTID = <cfqueryparam value="#arguments.eventID#" cfsqltype="cf_sql_integer" />
		</cfquery>			
	</cffunction>
	
	<!---Validate event Form--->
	<cffunction name="validateEventForm" access="public" returntype="Array" output="false" roles="Administrator">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventDate" type="string" required="true" /> 
		<cfargument name="eventLocation" type="string" required="true" />
		<cfargument name="eventVenue" type="string" required="true" />
		<cfargument name="eventDescription" type="string" required="true" /> 
		<cfset local.aErrorMessages = [] />
		<cfscript>
			//validate event name
			if(arguments.eventName EQ '')
			{
				arrayAppend(local.aErrorMessages,'Please provide a valid name for your event');
			}
			//validate event date
			if(arguments.eventDate EQ '')
			{
				arrayAppend(local.aErrorMessages, 'Please provide a date for your new event');
			}
			else if(arguments.eventDate LT dateFormat(now()))
			{
				arrayAppend(local.aErrorMessages, "Your event date can not be smaller than today's date");
			}
			//validate event location
			if(arguments.eventLocation EQ '')
			{
				arrayAppend(local.aErrorMessages, 'Please provide a valid location for your event');
			}
			//validate event venue
			if(arguments.eventVenue EQ '')
			{
				arrayAppend(local.aErrorMessages, 'Please provide a valid venue for your event');
			}
			//validate event description
			if(arguments.eventDescription EQ '')
			{
				arrayAppend(local.aErrorMessages, 'Please provide a description for your event');
			}
		</cfscript>
		<cfreturn local.aErrorMessages />
	</cffunction>

</cfcomponent>