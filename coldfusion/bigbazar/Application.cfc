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

</cfcomponent>