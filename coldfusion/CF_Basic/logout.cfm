<!---
Page functionality : page for logout front
Date - 17-jul-2017
--->
<!---redirecting to login page if session is not running--->
<cfif NOT structKeyExists ( SESSION , 'setLoggedInUser' ) >
	<cflocation url="login.cfm" addToken="no" />
</cfif>
<cf_header title="logout">
	<div class="lg-container">
		<!---checking session exists or not--->
		<cfif structKeyExists(SESSION,'setLoggedInUser')>
			<h1><cfoutput>
						Welcome #SESSION.setLoggedInUser.UserName# !
				</cfoutput>
				<a href="login.cfm?logout">Logout</a>
			</h1>
		</cfif>
	</div>
</cf_header>