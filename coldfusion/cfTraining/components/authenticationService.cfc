<cfcomponent output="false">
	<!---validateUser() method--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />

		<cfset aErrorMessages = ArrayNew(1) />
		<!---Vallidate the eMail--->
		<cfif NOT isValid('email',arguments.userEmail)>
			<cfset arrayAppend(aErrorMessages,"Please, provide a valid eMail address") />
		</cfif>
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(aErrorMessages,"Please provide a password") />
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---doLogin() method--->
	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />

		<!---Create the isUserLoggedIn variable--->
		<cfset var isUserLoggedIn = false />
		<!---Get the user data from the database--->
		<cfquery name="rsLoginUser">
			SELECT TBL_USERS.FLD_USERFIRSTNAME,TBL_USERS.FLD_USERLASTNAME,TBL_USERS.FLD_USERID,TBL_USERS.FLD_USEREMAIL,TBL_USERS.FLD_USERPASSWORD,TBL_ROLES.FLD_ROLENAME
			FROM TBL_USERS INNER JOIN TBL_ROLES ON TBL_USERS.FLD_USERROLE = TBL_ROLES.FLD_ROLEID
			WHERE FLD_USEREMAIL = '#arguments.userEmail#' AND FLD_USERPASSWORD = '#arguments.userPassword#' AND FLD_USERISACTIVE =1

		</cfquery>
		<!---Check if the query returns one and only one user--->
		<cfif rsLoginUser.recordCount EQ 1>
			<!---Log the user in--->
			<cflogin>
				<cfloginuser name="#rsLoginUser.FLD_USERFIRSTNAME# #rsLoginUser.FLD_USERPASSWORD#" roles="#rsLoginUser.FLD_ROLENAME#">
			</cflogin>
			<!---Save user data in the session scope--->
			<cfset session.stLoggedInUser = {'userFirstName' = rsLoginUser.FLD_USERFIRSTNAME,'userLastName' = rsLoginUser.FLD_USERLASTNAME,'userID' = rsLoginUser.FLD_USERID} />
			<!---change the isUserLoggedIn variable to true--->
			<cfset var isUserLoggedIn = true />
		</cfif>
		<!---Return the isUserLoggedIn variable--->
		<cfreturn  isUserLoggedIn />
	</cffunction>
	<!---doLogout() method--->
	<cffunction name="doLogout" access="public" output="false" returntype="void">
		<!---delete user data from the session scope--->
		<cfset structdelete(session,'stLoggedInUser') />
		<!---Log the user out--->
		<cflogout />
	</cffunction>
</cfcomponent>