<!---
Page functionality : for database services like - login authentivation
Date - 17-jul-2017
--->

<cfcomponent  hint = "component for database services">
	<!---validUserName() method checking weather username exist in database of not --->
	<cffunction name="validUserName" access = "public" returntype = "boolean" hint=  "username exists or not in database">
		<cfargument name="UserName" required = "true" type = "string" hint = "username argument" />

		<cftry>

			<!---Create the isValidUserName variable for checking username exists of not--->
			<cfset LOCAL.isValidUserName = true />
			<cfquery name = "resultUser" >
				SELECT USERS.USERNAME, USERS.EMAIL, USERS.PASSWORD
				FROM USERS
				WHERE USERNAME = <cfqueryparam value="#ARGUMENTS.UserName#" cfsqltype = "cf_sql_varchar" />
			</cfquery>

			<cfcatch type="any">
        		<cfset LOCAL.isValidUserName = false />
    		</cfcatch>
    	</cftry>

		<!---Check if the query returns not zero value--->
		<cfif resultUser.recordCount NEQ 0>
			<cfset LOCAL.isValidUserName = false />
		</cfif>
		<cfreturn LOCAL.isValidUserName />
	</cffunction>

	<!---addNewUser() function to add new user in USERS database--->
	<cffunction name="addNewUser" returntype="boolean"  hint = "register/insert a new user in database">
		<cfargument name="UserName" required="true" type="string" hint = "username argument" />
		<cfargument name="Email" required="true" type="string" hint = "email argument" />
		<cfargument name="Password" required="true" type="string" hint = "password argument" />

		<cfset LOCAL.isRegistered = true />

		<cftry>

			<!---Inserting the datainto database users--->
			<cfquery>
				INSERT INTO USERS
				(USERNAME, EMAIL , PASSWORD)
				VALUES
				(
				  <cfqueryparam value="#ARGUMENTS.UserName#" cfsqltype="cf_sql_varchar" />,
				  <cfqueryparam value="#ARGUMENTS.Email#" cfsqltype="cf_sql_varchar" />,
				  <cfqueryparam value="#ARGUMENTS.Password#" cfsqltype="cf_sql_varchar" />
				)
			</cfquery>

				<cfcatch type="any" >
					<cfset LOCAL.isRegistered = false />
				</cfcatch>

			</cftry>
			<cfreturn LOCAL.isRegistered />
	</cffunction>

	<!---doLogin() method--->
	<cffunction name="doLogin" access="public"  returntype="boolean" hint = "login authentication">
		<cfargument name="UserName" type="string" required="true" hint = "username argument" />
		<cfargument name="LoginPassword" type="string" required="true" hint = "login password argument" />

		<!---Create the isUserLoggedIn variable--->
		<cfset LOCAL.isUserLoggedIn = false />
		<!---Get the user data from the database--->

		<cftry>

			<cfquery name="resultLoginUser">
				SELECT USERS.USERNAME, USERS.EMAIL , USERS.PASSWORD
				FROM USERS
				WHERE USERNAME = <cfqueryparam value="#ARGUMENTS.UserName#" cfsqltype="cf_sql_varchar" />
				AND PASSWORD = <cfqueryparam value="#ARGUMENTS.LoginPassword#" cfsqltype="cf_sql_varchar" />
			</cfquery>

			<cfcatch type="any">
        		<cfset LOCAL.isUserLoggedIn = false />
    		</cfcatch>
    	</cftry>
		<!---Check if the query returns one and only one user--->
		<cfif resultLoginUser.recordCount EQ 1>
			<!---Save user data in the session scope--->
			<cfset SESSION.setLoggedInUser = {'UserName' = resultLoginUser.UserName} />
			<!---change the isUserLoggedIn variable to true--->
			<cfset LOCAL.isUserLoggedIn = true />
		</cfif>
		<!---Return the isUserLoggedIn variable--->
		<cfreturn LOCAL.isUserLoggedIn />
	</cffunction>

	<!---doLogout() method--->
	<cffunction name = "doLogout" access = "public" returntype = "void" hint = "delete session on logout" >
		<!---delete user data from the session scope--->
		<cfset structdelete(SESSION,'setLoggedInUser') />
	</cffunction>
</cfcomponent>