<cfcomponent output="false">
	<cfset this.name = 'hdStreetWebsite' />
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />
	<cfset this.datasource = 'hdStreet-final' />
	<cfset this.customTagPaths = expandPath('../final/customTags') />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />

	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >
		<cfset application.pageService = createObject("component",'coldfusion.final.components.pageService') />
		<cfset application.eventsService = createObject("component",'coldfusion.final.components.eventsService') />
		<cfset application.newsService = createObject("component",'coldfusion.final.components.newsService') />
		<cfset application.userService = createObject("component",'coldfusion.final.components.userService') />
		<cfset application.commentsService = createObject("component",'coldfusion.final.components.commentsService') />
		<cfset application.utils = createObject("component",'coldfusion.final.components.utils') />
		<cfreturn true />
	</cffunction>
	<!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean" >
		<cfargument name="targetPage" type="string" required="true" />
		<!---handle some special URL parameters--->
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart() />
		</cfif>
		<!---Implement ressource Access control for the 'admin' folder--->
		<cfif listFind(arguments.targetPage,'admin', '/') AND (NOT isUserLoggedIn() OR NOT isUserInRole('Administrator'))>
			<cflocation url="/final/index.cfm?noaccess" />

		</cfif>
		<cfreturn true />
	</cffunction>
</cfcomponent>