<!---
Page functionality : signup front page
Date - 17-jul-2017

--->
<!---redirecting to logout id session running--->
<cfif structKeyExists ( SESSION , 'setLoggedInUser' ) >
	<cflocation url="logout.cfm" addToken="no" />
</cfif>

<!---Creating default values for form scop values--->
<cfparam name="FORM.username" default="">
<cfparam name="FORM.email" default="">
<cfparam name="FORM.password" default="">
<cfparam name="FORM.confirm_password" default="">

<!---Creating the error message fields--->
<cfset VARIABLES.UserNameErrorMessage = '' />
<cfset VARIABLES.EmailErrorMessage = '' />
<cfset VARIABLES.PasswordErrorMessage = '' />
<cfset VARIABLES.ConfirmPasswordErrorMessage = '' />
<cfset VARIABLES.IsSignUpFormValid = true />
<cfset VARIABLES.IsRegistered = true />

<!---checking the form submit or not --->
<cfif structkeyExists(FORM,'signUp')>

	<!---Validate the username field--->
	<cfif trim(FORM.username) EQ ''>
		<cfset VARIABLES.UserNameErrorMessage = 'Please! Enter UserName' />
		<cfset VARIABLES.IsSignUpFormValid = false />
	</cfif>

	<!---Validate the Email field--->
	<cfif trim(FORM.email) EQ '' OR NOT isValid('email', FORM.email)>
		<cfset VARIABLES.EmailErrorMessage = 'Please! Enter a valid email id' />
		<cfset VARIABLES.IsSignUpFormValid = false />
	</cfif>

	<!---Validate the password field--->
	<cfif trim(FORM.password) EQ '' OR NOT isValid('regex',FORM.password,'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[$@!%*?&])[A-Za-z\d@$!%*?&\s]{4,}$') >
		<cfset VARIABLES.PasswordErrorMessage = 'Password length should be minimum 4 and atleat 1 small letter , 1 upper letter , 1 digit and 1 special character _!@$%' />
		<cfset VARIABLES.IsSignUpFormValid = false />
	</cfif>

	<!---Validate the confirm password field--->
	<cfif trim(FORM.confirm_password) EQ '' >
		<cfset VARIABLES.ConfirmPasswordErrorMessage = 'Please! Enter a valid confirm password' />
		<cfset VARIABLES.IsSignUpFormValid = false />

	<!---checking weather the passwords fields are same or not--->
	<cfelseif trim(FORM.confirm_password) NEQ trim(FORM.password) >
		<cfset VARIABLES.ConfirmPasswordErrorMessage = 'Password should be same' />
		<cfset VARIABLES.IsSignUpFormValid = false />
	</cfif>

	<!---Checkign all the fields are valid--->
	<cfif VARIABLES.IsSignUpFormValid>

		<!--- Handle error on database query
		<cftry >--->

			<!---checking username already exists or not--->
			<cfif APPLICATION.Services.validUserName(trim(FORM.username))>

				<!---inserting the data into the database--->
				<cfset VARIABLES.IsRegistered = APPLICATION.Services.addNewUser(trim(FORM.username),trim(Form.email),hash(FORM.password)) />

				<cfif VARIABLES.IsRegistered >

					<!--- Creating log --->
					<cflog file="CF_Basic" text="#FORM.username# has been registered in" type="information" >

					<!--- mail to the user's email id --->
					<cfmail from = "onlyfornirmit@gmail.com" to = "#FORM.email#" subject = "Successfull signup">
	   					Hello #FORM.username#!
						You have successfully signup into website.
					</cfmail>

					<!---redirecting to the login form--->
					<cflocation url="login.cfm" addToken="no" />

				<cfelse>
					<cflocation url = "databaseError.cfm" addToken = "no" />

				</cfif>

			<cfelse>
				<cfset VARIABLES.UserNameErrorMessage = "This username is already taken!" />
			</cfif>

			<!--- catching the database error
			<cfcatch type = "any" >

				<!--- Creating log for error --->
				<cflog file="CF_Basic" text = "Database eroor at signup" type = "error" >

				<cflocation url = "databaseError.cfm" addToken = "no" />
			</cfcatch>

		</cftry>--->
	</cfif>
</cfif>

<!---Including the header--->
<cf_header title="SignUp">
		<div class="lg-container">
			<h1>Sign Up</h1>
			<cfform id="lg-form" name="lg-form" >
				<div>
					<label for="username">Username:</label>
					<cfinput type="text" name="username" id="username" placeholder="username" value="#FORM.username#"/>
					<span class="error" id="username_error"><cfoutput>#VARIABLES.UserNameErrorMessage#</cfoutput></span>
				</div>

				<div>
					<label for="email">Email:</label>
					<cfinput type="text" name="email" id="email" placeholder="email" value="#FORM.email#" />
					<span class="error" id="email_error"><cfoutput>#VARIABLES.EmailErrorMessage#</cfoutput></span>
				</div>

				<div>
					<label for="password">Password:</label>
					<cfinput type="password" name="password" id="password" placeholder="password" value="#FORM.password#" />
					<span class="error" id="password_error"><cfoutput>#VARIABLES.PasswordErrorMessage#</cfoutput></span>
				</div>

				<div>
					<label for="confirm_password">Confirm Password:</label>
					<cfinput type="password" name="confirm_password" id="confirm_password" placeholder="confirm password" value="#FORM.confirm_password#" />
					<span class="error" id="confirm_password_error"><cfoutput>#VARIABLES.ConfirmPasswordErrorMessage#</cfoutput></span>
				</div>

				<div class="sbmit-button">
					<cfinput type="submit" class="button" id="signUp" name="signUp" value="SignUp" />
				</div>
				<a href="login.cfm">Already Registered ?</a>
			</cfform>
			<div id="message"></div>
		</div>
</cf_header>