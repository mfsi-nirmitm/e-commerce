<!---Handle the logout--->
<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'coldfusion.final.components.authenticationService').doLogout() />
</cfif>
<!---Form processing begins here--->
<cfif structkeyExists(form,'fld_submitLogin')>
	<!---Create an instance of the authentication service component--->
	<cfset authenticationService = createobject("component",'coldfusion.final.components.authenticationService') />
	<!---server side data validation--->
	<cfset aErrorMessages = authenticationService.validateUser(form.fld_userEmail,form.fld_userPassword) />
	<cfif ArrayisEmpty(aErrorMessages)>
		<!---proceed to the login procedure--->
		<cfset isUserLoggedIn = authenticationService.doLogin(form.fld_userEmail,form.fld_userPassword) />
	</cfif>
</cfif>
<!---Form processing end here--->
<cfform id="frmConnexion" preservedata="true">
	<fieldset>
    <legend>Login</legend>
    <cfif structKeyExists(url,'noaccess')>
    	<p class="errorMessage">Please, log-in to have access to this page.</p>
    </cfif>
    <cfif structKeyExists(variables,'aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
    	<cfoutput>
			Kuchh to jhol hai
			<!---<cfloop array="#aErrorMessages#" item="message">
    			<p class="errorMessage">#message#</p>
    		</cfloop>--->
    	</cfoutput>
    </cfif>
    <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
    	<p class="errorMessage">User not found. Please try again!</p>
    </cfif>
    <cfif structKeyExists(session,'stLoggedInUser')>
    	<!---Display a welcome message--->
    	<p><cfoutput>Welcome #session.stLoggedInUser.userFirstName# #session.stLoggedInUser.userLastName#!</cfoutput></p>
    	<p><a href="../final/profile.cfm">My Profile</a> <a href="../final/index.cfm?logout">Logout</a></p>
    	<cfif isUserInRole('Administrator')>
    		<p><a href="../final/admin/main.cfm">Site Administration</a></p>
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
</cfform>
