<cfcomponent>
	<cffunction name="abc" access="remote" returntype="string">
		<cfargument name="name" required = "true" type = "string" />
		<cfreturn arguments.name />
	</cffunction>
</cfcomponent>
