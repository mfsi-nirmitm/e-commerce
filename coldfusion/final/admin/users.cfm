<!---Delete User--->
<cfif structKeyExists(url,'delete') >
	<cftry>
		<cfset application.userService.deleteUser(url.delete) />
		<cfcatch type="database" >
			<cfset application.userService.deactivateUser(url.delete) />
		</cfcatch>
	</cftry>
</cfif>
<!---Approve Users--->
<cfif structKeyExists(url,'approve')>
	<cfset application.userService.approveUser(url.approve) />
</cfif>
<!--- Get the list of users to approve --->
<cfset usersToApprove = application.userService.getUsersToApprove() />
<!---Get the active users--->
<cfset activeUsers = application.userService.getAllActiveUsers() />
<cf_admin title="HD street band - Users administration">
	<script>
		function confirmDelete(userID)
		{
			if(window.confirm('Are you sure you want to delete this user?'))
			{
				window.location.href = 'users.cfm?delete='+userID;
			}
			else
			{
				null;
			}
		}
	</script>
	<div id="pageBody">
		<h1>Users Administration</h1>
		<cfif structKeyExists(url, 'updated')>
			<p class="feedback">The user has been successfully updated.</p>
		</cfif>
		<cfif structKeyExists(url, 'add')>
			<p class="feedback">A new user has been created.!/p>
		</cfif>
		<p><a href="userAdd.cfm">[Add a user]</a></p>
		<cfif usersToApprove.recordCount EQ 0>
			<p>There are no users to approve at this time.</p>
		<cfelse>
			<h2>Users to approve</h2>
			<table>
				<tr>
					<th>User Name</th>
					<th>eMail Address</th>
					<th>Comment</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
				<cfoutput query="usersToApprove">
					<tr>
						<td>#fld_userFirstName# #fld_userLastName#</td>
						<td>#fld_userEmail#</td>
						<td>#fld_userComment#</td>
						<td><a href="userEdit.cfm?userID=#fld_userID#">View</a></td>
						<td><a href="users.cfm?approve=#fld_userID#">Approve</a></td>
						<td><a href="javascript:confirmDelete(#fld_userID#);">Delete</a></td>
					</tr>
				</cfoutput>
			</table>
		</cfif>
		<h2>Active users</h2>
		<table>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Role</th>
				<th>Instrument</th>
				<th>eMail Address</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
			</tr>
			<cfoutput query="activeUsers">
			<tr>
				<td>#fld_userFirstName#</td>
				<td>#fld_userLastName#</td>
				<td>#fld_roleName#</td>
				<td>#fld_instrumentName#</td>
				<td>#fld_userEmail#</td>
				<td><a href="userEdit.cfm?userID=#fld_userID#">Edit</a></td>
				<td><a href="javascript:confirmDelete(#fld_userID#);">Delete</a></td>
			</tr>
			</cfoutput>
		</table>
	</div>
</cf_admin>