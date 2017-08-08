<cfcomponent output="false">
	<cfset this.name = 'hdStreetWebsite'  />
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />
	<cfset this.datasource = 'hdStreet' />
	<cfset this.customTagPaths = expandPath('../cfTraining/customTags') />

	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean">
		<cfset application.pageService=createObject('component','coldfusion.cfTraining.components.pageService') />
		<cfset application.eventsService=createObject('component','coldfusion.cfTraining.components.eventsService') />
		<cfset application.newsService=createObject('component','coldfusion.cfTraining.components.newsService') />
		<cfset application.userService=createObject('component','coldfusion.cfTraining.components.userService') />
		<cfreturn true />
	</cffunction>
	<!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean">
		<cfargument name="targetPage" type="string" required="true" />
		<!---handle some special URL paramenters--->
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart() />
		</cfif>
		<cfreturn true />
	</cffunction>
</cfcomponent>