<!---handle the logout--->
<cfif structKeyExists(url,'logout')>
	<cfset createObject('component','coldfusion.cfTraining.components.authenticationService').doLogout() />
</cfif>
<!---Form processing begin here--->
<cfif structkeyExists(form,'fld_submitLogin')>
	<!---Create an instance of the authentication service component--->
	<cfset authenticationService = createObject('componenet','coldfusion.cfTraining.components.authenticationService') />
	<!---server side data validation--->
	<cfset aErrorMessages = authenticationService.validateUser(form.fld_userEmail,form.fld_userPassword) />
	<cfif ArrayisEmpty(aErrorMessages) >
		<!---proceed to the login procedure--->
		<cfset isUserLoggedIn = authenticationService.doLogin(form.fld_userEmail,form.fld_userPassword) />
	</cfif>
</cfif>
<!---form processing end here--->
<cfform id="frmConnexion" preservedata="true">
	<fieldset>
	    <legend>Login</legend>
	    <cfif structKeyExists(variables,'aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
			<cfoutput>
				<cfloop array="#aErrorMessages#" item="message">
					<p class="errorMessage">#message#</p>
				</cfloop>
			</cfoutput>
	    </cfif>
	    <cfif structkeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
		    <p class="errorMessage">User not found. Please try again!</p>
	    </cfif>
		<cfif structKeyExists(session,'stLoggedInUser')>
			<!---Display a welcome message--->
			<p><cfoutput>Welcome #session.stLoggedInUser.userFirstName# #session.stLoggedInUser.userLastName#!</cfoutput></p>
			<p><a href="../cfTraining/profile.cfm">My Profile</a> <a href="../cfTraining/index.cfm?logout">Logout</a></p>
			<cfif isUserInRole('Administrator')>
				<p><a href="../cfTraining/admin/main.cfm">Site Administration</a></p>
			</cfif>
		<cfelse>


			<dl>
	        	<dt><label for="fld_userEmail">E-mail address</label></dt>
	            <dd><cfinput type="text" name="fld_userEmail" id="fld_userEmail" required="true" validate="email" validateAt="onSubmit" message="Please enter a valid e-mail Address" /></dd>
	    		<dt><label for="fld_userPassword">Password</label></dt>
	            <dd><cfinput type="password" name="fld_userPassword" id="fld_userPassword" required="true"  validateAt="onSubmit" message="Please provide a password" /></dd>
	        </dl>
	        <cfinput type="submit" name="fld_submitLogin" id="fld_submitLogin" value="Login" />
	    </cfif>
	</fieldset>
</cfform>
