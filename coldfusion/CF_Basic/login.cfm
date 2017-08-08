<!---
Page functionality : login front page
Date - 17-jul-2017

--->
<!---Handle the logout--->
<cfif structKeyExists(URL,'logout')>

	<!--- Checking session is running or not --->
	<cfif structKeyExists ( SESSION , 'setLoggedInUser' ) >

		<!--- Creating log for user logout --->
		<cflog file="CF_Basic" text = "#session.setLoggedInUser.UserName# has been logged out" type = "information" >

		<!--- logout the session --->
		<cfset APPLICATION.Services.doLogout() />

	</cfif>
</cfif>

<!---redirecting to logout id session running--->
<cfif structKeyExists ( SESSION , 'setLoggedInUser' ) >
	<cflocation url="logout.cfm" addToken="no" />
</cfif>

<!---giving default values for form scope variables--->
<cfparam name="FORM.username" default="">
<cfparam name="FORM.login_password" default="">

<!---difining all error messages field--->
<cfset VARIABLES.UserNameErrorMessage = '' />
<cfset VARIABLES.PasswordErrorMessage = '' />
<cfset VARIABLES.UserNameOrPasswordErrorMessage = '' />
<cfset VARIABLES.IsLoginValid = true />

<!--- on form submission condition--->
<cfif structkeyExists(FORM,'login')>

	<!---validate the username field in form---->
	<cfif trim(FORM.username) EQ ''>
		<cfset VARIABLES.UserNameErrorMessage = 'Please! Enter the username' />
		<cfset VARIABLES.IsLoginValid = false />
	</cfif>

	<!---validate the password field in form--->
	<cfif FORM.login_password EQ ''>
		<cfset VARIABLES.PasswordErrorMessage = 'Please! Enter the password' />
		<cfset VARIABLES.IsLoginValid = false />
	</cfif>

	<!---checking the form variables are fine--->
	<cfif VARIABLES.IsLoginValid  >

		<!--- Handle error in database
		<cftry>--->
			<!---login the user if exists in database--->
			<cfif APPLICATION.Services.doLogin(trim(FORM.username),hash(FORM.login_password)) >

				<!--- Creating log --->
				<cflog file="CF_Basic" text="#FORM.username# has logged in" type="information" >

				<!---page redirection on successful login--->
				<cflocation url="logout.cfm" addToken="no" />

			<cfelse>

				<!---set message when password or username does not exists--->
				<cfset VARIABLES.UserNameOrPasswordErrorMessage = 'Username or Password does not exist' />

			</cfif>
			<!--- Catching the database error
			<cfcatch type = "database" >

				<!--- Creating log for error --->
				<cflog file="CF_Basic" text = "Database eroor at login" type = "error" >

				<cflocation url = "databaseError.cfm" addToken = "no" />
			</cfcatch>
		</cftry>--->
	</cfif>
</cfif>
<cf_header title = "Login">
	<div class="lg-container">
		<h1>Login</h1>
		<span class="error"><cfoutput>#VARIABLES.UserNameOrPasswordErrorMessage#</cfoutput></span>
		<cfform id="lg-form" name="lg-form" >

			<div>
				<label for="username">Username:</label>
				<cfinput type="text" name="username" id="username" placeholder="username" value="#FORM.username#"/>
				<span class="error" id="username_error"><cfoutput>#VARIABLES.UserNameErrorMessage#</cfoutput></span>
			</div>

			<div>
				<label for="password">Password:</label>
				<cfinput type="password" name="login_password" id="login_password" placeholder="password" value = "#FORM.login_password#" />
				<span class="error" id="login_password_error"><cfoutput>#VARIABLES.PasswordErrorMessage#</cfoutput></span>
			</div>

			<div class="sbmit-button">
				<cfinput type="submit" class="button" id="login" name="login" value="Login" />
			</div>
			<a href="signup.cfm">New User?</a>
		</cfform>
		<div id="message"></div>
	</div>
</cf_header>