<cfset urgentTasks = false />
<cfset usersToApprove = application.userService.getUsersToApprove() />
<cfset commentsToApprove = application.commentsService.getUnapprovedComments() />
<cf_admin>
	<div id="pageBody">
		<h1>Welcome to the site administration</h1>
		<cfif commentsToApprove.recordCount NEQ 0>
			<h2>There are <cfoutput>#commentsToApprove.recordCount#</cfoutput> comments to approve.</h2>
			<p>Go to the <a href="comments.cfm">comments</a> section of this admin site.</p>
			<cfset urgentTasks = true />
		</cfif>
		<cfif usersToApprove.recordCount NEQ 0>
			<h2>There are <cfoutput>#usersToApprove.recordCount#</cfoutput> users to approve.</h2>
			<p>Go to the <a href="users.cfm">users</a> section of this admin site.</p>
			<cfset urgentTasks = true />
		</cfif>
		<cfif NOT urgentTasks>
			<p>There are no urgent tasks at the moment!</p>
		</cfif>
	</div>
</cf_admin>