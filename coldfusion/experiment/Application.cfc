<!---/**
 * Application
 *
 * @author mindfire
 * @date 7/28/17
 **/--->
<cfcomponent output="false" hint="I define the application settings and event handlers.">

    <!---
        Define the application settings. Notice that our
        Application timeout is rather small - 10 seconds,
        while our Session timeout is larger - 5 minutes.
    --->
    <cfset this.name = 'experiment' />
    <cfset this.applicationTimeout = createTimeSpan( 0, 0, 0, 20 ) />
    <cfset this.sessionManagement = true />
    <cfset this.sessionTimeout = createTimeSpan( 0, 0, 0, 10 ) />

	<!---<cfset this.requestTimeout =  createTimeSpan( 0, 0, 0, 5 ) />
	--->

    <!--- Define the request settings. --->
    <cfsetting showdebugoutput= "true" />


    <cffunction
        name="onApplicationStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="I initialize the application.">

        <!--- Initialize the application settings. --->
        <cfset application.dateInitialized = now() />

        <!--- Return true so that the page can load. --->
        <cfreturn true />
    </cffunction>


    <cffunction
        name="onSessionStart"
        access="public"
        returntype="void"
        output="false"
        hint="I initialize the session.">

        <!--- Initialize the session settings. --->
        <cfset session.dateInitialized = now() />

        <!--- Return out. --->
        <cfreturn />
    </cffunction>

	<!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean" hint = "function execute at request time">

		<!---checking weather restartApp in url exists or not--->
		<cfif isDefined('url.restartApp')>

			<!---restarting the application--->
			<cfset this.onApplicationStart() />
		</cfif>
		<cfreturn true />
	</cffunction>

</cfcomponent>