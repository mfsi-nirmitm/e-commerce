<cfcomponent output="false">
	<!---addUser() method--->
	<cffunction name="addUser" access="public" output="false" returntype="void">
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userLastName" type="string" required="true" />
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userRole" type="numeric" required="true" />
		<cfargument name="userInstrument" type="numeric" required="true" />
		<cfargument name="userComment" type="string" required="true" />
		<cfargument name="userIsApproved" type="numeric" required="true" />
		<cfargument name="userIsActive" type="numeric" required="true" />
		<cfquery  >
			INSERT INTO TBL_USERS
			(FLD_USERFIRSTNAME, FLD_USERLASTNAME, FLD_USEREMAIL, FLD_USERPASSWORD, FLD_USERCOMMENT, FLD_USERAPPROVED, FLD_USERISACTIVE, FLD_USERROLE, FLD_USERINSTRUMENT)
			VALUES
			(
				<cfqueryparam value="#form.fld_userFirstName#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userLastName#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userEmail#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userPassword#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.fld_userComment#" cfsqltype="cf_sql_longvarchar" />,
				<cfqueryparam value="#arguments.userIsApproved#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#arguments.userIsActive#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#arguments.userRole#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#arguments.userInstrument#" cfsqltype="cf_sql_integer" />
			)
		</cfquery>
	</cffunction>
	<!---validateUser() method--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userLastName" type="string" required="true" />
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userPasswordConfirm" type="string" required="true" />
		<cfset var aErrorMessages = arrayNew(1) />
		<!---Validate firstName--->
		<cfif arguments.userFirstName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please provide a valid first name') />
		</cfif>
		<!---Validate lastName--->
		<cfif arguments.userLastName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please provide a valid lastname') />
		</cfif>
		<!---Validate Email--->
		<cfif arguments.userEmail EQ '' OR NOT isValid('email',arguments.userEmail) >
			<cfset arrayAppend(aErrorMessages,'Please provide a valid email address ')/>
		</cfif>
		<!---Validate Password--->
		<cfif arguments.userPassword EQ '' >
			<cfset arrayAppend(aErrorMessages,'Please provide a password ')/>
		</cfif>
		<!---Validate Password confirmation--->
		<cfif arguments.userPasswordConfirm EQ '' >
			<cfset arrayAppend(aErrorMessages,'Please confirm your password')/>
		</cfif>
		<!---validate password and password confirmation Match --->
		<cfif arguments.userPassword NEQ arguments.userPasswordConfirm >
			<cfset arrayAppend(aErrorMessages,'The password and the password confirmation do not match')/>
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---getUserByID() method--->
	<cffunction name="getUserByID" access="public" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true" />
		<cfset var rsSingleUser = '' />
		<cfquery  name="rsSingleUser">
			SELECT FLD_USERID, FLD_USERFIRSTNAME, FLD_USERLASTNAME, FLD_USEREMAIL, FLD_USERPASSWORD, FLD_USERCOMMENT, FLD_USERINSTRUMENT, FLD_USERROLE
			FROM TBL_USERS
			WHERE FLD_USERID = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn rsSingleUser />
	</cffunction>
	<!---updateUser() method--->
	<cffunction name="updateUser" access="public" output="false" returntype="void">
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userLastName" type="string" required="true" />
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userRole" type="numeric" required="true" />
		<cfargument name="userInstrument" type="numeric" required="true" />
		<cfargument name="userComment" type="string" required="true" />
		<cfargument name="userIsApproved" type="numeric" required="true" />
		<cfargument name="userIsActive" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		<cfquery>
			UPDATE TBL_USERS
			SET
			FLD_USERFIRSTNAME = <cfqueryparam value="#arguments.userFirstName#" cfsqltype="cf_sql_varchar" />,
			FLD_USERLASTNAME = <cfqueryparam value="#arguments.userLastName#" cfsqltype="cf_sql_varchar" />,
			FLD_USEREMAIL = <cfqueryparam value="#arguments.userEmail#" cfsqltype="cf_sql_varchar" />,
			FLD_USERPASSWORD = <cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />,
			FLD_USERINSTRUMENT = <cfqueryparam value="#arguments.userInstrument#" cfsqltype="cf_sql_integer" />,
			FLD_USERCOMMENT = <cfqueryparam value="#arguments.userComment#" cfsqltype="cf_sql_longvarchar" />, 
			FLD_USERROLE = <cfqueryparam value="#arguments.userRole#" cfsqltype="cf_sql_integer" />, 
			FLD_USERISACTIVE = <cfqueryparam value="#arguments.userIsActive#" cfsqltype="cf_sql_integer" />,
			FLD_USERAPPROVED = <cfqueryparam value="#arguments.userIsApproved#" cfsqltype="cf_sql_integer" />
			WHERE FLD_USERID = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	<!---getInstruments() method--->
	<cffunction name="getInstruments" access="public" output="false" returntype="query">
		<cfset var rsInstrumentsList = '' />
		<cfquery  name="rsInstrumentsList">
			SELECT FLD_INSTRUMENTID, FLD_INSTRUMENTNAME
			FROM TBL_INSTRUMENTS
			ORDER BY FLD_INSTRUMENTNAME ASC
		</cfquery>
		<cfreturn rsInstrumentsList />
	</cffunction>
			<!---Get users to approve--->
		<cffunction name="getUsersToApprove" returntype="Query" roles="Administrator">
			<cfquery name="local.rs_UsersToApprove">
				SELECT TBL_USERS.FLD_USERID, TBL_USERS.FLD_USERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME, TBL_USERS.FLD_USERCOMMENT, TBL_USERS.FLD_USEREMAIL
				FROM TBL_USERS
				WHERE FLD_USERAPPROVED = 0
			</cfquery>
			<cfreturn local.rs_UsersToApprove />
		</cffunction>
		
		<!--- approve user method --->
		<cffunction name="approveUser" returntype="void" roles="Administrator">
			<cfargument name="userID" type="numeric" required="true" /> 
			<cfquery >
				UPDATE TBL_USERS
				SET 
				FLD_USERAPPROVED = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
				FLD_USERISACTIVE = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				WHERE FLD_USERID = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
			</cfquery>
			<!--- call the sendApprovedMail() method of this component. --->
			<cfset sendApprovedMail(arguments.userID) />
		</cffunction>
		
		<!---Get All active Users Method--->
		<cffunction name="getAllActiveUsers" returntype="Query">
			<cfquery name="local.rs_allUsers">
				SELECT TBL_USERS.FLD_USERID, TBL_USERS.FLD_USERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME, TBL_USERS.FLD_USERCOMMENT, TBL_USERS.FLD_USEREMAIL, TBL_ROLES.FLD_ROLENAME, TBL_INSTRUMENTS.FLD_INSTRUMENTNAME
				FROM TBL_USERS INNER JOIN TBL_ROLES ON TBL_USERS.FLD_USERROLE = TBL_ROLES.FLD_ROLEID INNER JOIN TBL_INSTRUMENTS ON TBL_USERS.FLD_USERINSTRUMENT = TBL_INSTRUMENTS.FLD_INSTRUMENTID
				WHERE FLD_USERAPPROVED = 1 AND FLD_USERISACTIVE = 1
				ORDER BY FLD_INSTRUMENTNAME ASC , FLD_USERLASTNAME ASC
			</cfquery>
			<cfreturn local.rs_allUsers/>
		</cffunction> 
		
		<!---Delete user function--->
		<cffunction name="deleteUser" returntype="void" roles="Administrator">
			<cfargument name="userID" type="numeric" required="true" />
			<cfquery>
				DELETE FROM TBL_USERS
				WHERE FLD_USERID = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
			</cfquery>
		</cffunction>
		
		<!---deactivate User--->
		<cffunction name="deactivateUser" returntype="void" roles="Administrator" >
			<cfargument name="userID" type="numeric" required="true" >
			<cfquery>
				UPDATE TBL_USERS
				SET
				FLD_USERISACTIVE = 0
				WHERE FLD_USERID = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
			</cfquery> 
		</cffunction>
		
		<!---Send approved Mail function--->
		<cffunction name="sendApprovedMail" returntype="void" roles="Administrator" access="private" >
			<cfargument name="userID" type="numeric" required="true" />
			<!---Get approved user info--->
			<cfset local.user = this.getUserByID(arguments.userID) />
			<!---Send mail to the user--->
			<cfmail from="administrator@hdstreet.com" subject="You've been approved!'" to="#local.user.fld_userEmail#">
				<cfinclude template="../includes/approvedUserMail.cfm" />
			</cfmail>
		</cffunction>
</cfcomponent>