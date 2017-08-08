<!---
Page functionality : Application components
Date - 17-jul-2017

--->
<cfcomponent>
	<!---define name of application--->
	<cfset THIS.name='Basic_Coldfusion_Assignment' />

	<!---define application timeout time--->
	<cfset THIS.applicationTimeout = createtimespan(0,1,0,0)  />

	<!---datasource for application--->
	<cfset THIS.datasource = 'coldfusionbasic' />

	<!---path for custome tags--->
	<cfset THIS.customTagPaths = expandPath('../CF_Basic/customTags') />

	<!---enabling session--->
	<cfset THIS.sessionManagement = true />

	<!---creating a time stamp for session--->
	<cfset THIS.sessionTimeout = createTimespan(0,0,20,0) />

	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" hint = "function for starting application ">
		<cfset APPLICATION.Services = createObject("component",'coldfusion.CF_Basic.components.Services') />


		<cfreturn true />
	</cffunction>

	<!---onRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean" hint = "function execute at request time">

		<!---checking weather restartApp in url exists or not--->
		<cfif isDefined('URL.restartApp')>

			<!---restarting the application--->
			<cfset THIS.onApplicationStart() />
		</cfif>
		<cfreturn true />
	</cffunction>

	<!---OnSessionStart() method--->
	<cffunction name = "onSessionStart" returntype="boolean" hint = "function execute when session start">


		<cfreturn true />
	</cffunction>

	<!---OnSessionEnd() method--->
	<cffunction name = "onSessionEnd" returntype = "boolean" hint = "execute on session ends">

		<cfreturn true />
	</cffunction>

	<!--- onError() method --->
	<cffunction name="onError" returntype = "void" access = "public" hint = "execute when exception is not caught by try and catch block" >
		<cfargument name="Exception" required="true">
		<cfargument name="EventName" type="String" required="true">

		<!--- Mail the error to email id --->
		<cfmail from="onlyfornirmit@gmail.com" to="onlyfornirmit@gmail.com" subject="Error on site">
			<p>Exception.Type: #arguments.exception.type#<br>
			<p>Exception.Message: #arguments.exception.message#<br>
			<p>Stacktrace: #arguments.exception.stacktrace#<br>
			<p>Template: #arguments.exception.tagContext[1].template#<br>
			<p>Line number: #arguments.exception.tagContext[1].line#<br>
		</cfmail>

	</cffunction>
</cfcomponent>