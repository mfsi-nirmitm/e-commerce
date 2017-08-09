<!---/**
 * userservices
 *
 * @author mindfire
 * @date 8/9/17
 **/--->
<cfcomponent extends="checkoutservices" >

	<cffunction name = "registerUser" access = "public" returntype="numeric" hint = "adding user detail for registration">
		<cfargument name = "firstName" required = "true" type = "string" hint = "first name of customer" />
		<cfargument name = "lastName" required = "true" type = "string" hint = "last name of the customer" />
		<cfargument name = "password" required = "true" type = "string"  hint = "password for customer" />
		<cfargument name = "email" required = "true" type = "string"  hint = "email of customer for registration" />
		<cfargument name = "customerTypeId" required = "true" type = "numeric" hint = "type of customer" />

		<cfset local.customerID=#Int(Super.insertCustomerDetail(#arguments.firstName#,#arguments.lastName#,#arguments.email#,#arguments.customerTypeId#))# />

		<cfquery>
			INSERT INTO CUSTOMERLOGIN
			( PASSWORD , CUSTOMERID )
			VALUES
			(
				<cfqueryparam value = "#arguments.password#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#local.customerID#" cfsqltype = "cf_sql_numeric" />
			)
		</cfquery>
		<cfreturn local.customerID />
	</cffunction>

	<cffunction name = "haveEmail" access = "public" returntype = "boolean" hint = "checking email already there is database or not ">
		<cfargument name = "email" required = "true" type = "string" hint = "email of customer" />
		<cfargument name = "customerTypeId" required = "true" type = "numeric" hint = "type of customer" />

		<cfset local.isEmailExist = false />
		<cfquery name = "getMail">
			SELECT *
			FROM CUSTOMER
			WHERE EMAILADDRESS = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_string" />
			AND CUSTOMERTYPEID = <cfqueryparam value = "#arguments.customerTypeId#" cfsqltype = "cf_sql_numeric" />
		</cfquery>
		<cfif getMail.RecordCount GT 0>
			<cfset local.isEmailExist = true />
		</cfif>

		<cfreturn local.isEmailExist />
	</cffunction>

</cfcomponent>