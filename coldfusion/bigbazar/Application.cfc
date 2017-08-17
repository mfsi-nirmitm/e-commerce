<!---
 * Application
 *
 * @author mindfire
 * @date 7/21/17
 --->
<cfcomponent output = "false">
	<!--- Name of the application --->
	<cfset this.name = "e-commerce bajar" />

	<!--- Define application time out time --->
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />

	<!--- datasource for application --->
	<cfset this.datasource = "ECOMMERCE" />

	<!---enabling session--->
	<cfset this.sessionManagement = true />

	<!---creating a time stamp for session--->
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />

	<!---path for custome tags--->
	<cfset THIS.customTagPaths = expandPath('../bigbazar/customtags') />

	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >
		<!--- creating object to access functions  --->
		<cfset application.productService = createObject("component",'coldfusion.bigbazar.components.productservices') />
		<cfset application.cartService =    createObject("component","coldfusion.bigbazar.components.cartservices")  />
		<cfset application.checkoutService =    createObject("component","coldfusion.bigbazar.components.checkoutservices") />
		<cfset application.orderService = createObject("component" , "coldfusion.bigbazar.components.order-receipt") />
		<cfset application.userService = createObject("component" , "coldfusion.bigbazar.components.userservices") />



		<cfreturn true />
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