<!---Form processing begins here--->
<cfif structKeyExists(form,'fld_editUserSubmit')>
	<cfset aErrorMessages = application.userService.validateUser(form.fld_userFirstName,form.fld_userLastName,form.fld_userEmail,form.fld_userPassword,form.fld_userPassword) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.userService.updateUser(form.fld_userFirstName,form.fld_userLastName,form.fld_userEmail,form.fld_userPassword,form.fld_userRole,form.fld_userInstrument,form.fld_userComment,1,1, form.fld_userID) />
		<cflocation url="users.cfm?updated=true" />
	</cfif>
</cfif>
<!---Form processing ends here--->
<!---check if userID parameter is correctly passed--->
<cfif NOT structKeyExists(URL, 'userID')>
	<cflocation url="users.cfm" />
</cfif>
<!---get the current data of the user to edit.--->
<cfset userToEdit = application.userService.getUserByID(url.userID) />
<!---Get the instruments to generate the drop-down menu of the form--->
<cfset userInstruments = application.userService.getInstruments() />
<cf_admin title="HD street band - Users administration">
	<div id="pageBody">
		<h1>Update a user</h1>
			<cfform id="frm_editUser" preservedata="true">
			<fieldset>
				<legend>Add a user</legend>
				<!---Output error messages if any--->
				<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
					<cfloop array="#variables.aErrorMessages#" index="message">
						<p class="errorMessage">#message#</p>
					</cfloop>
					</cfoutput>
				</cfif>
				<dl>
					<!---Display form fields--->
					<dt><label>First Name</label></dt>
					<dd><cfinput name="fld_userFirstName" id="fld_userFirstName" value="#userToEdit.fld_userFirstName#" required="true" message="Please provide a valid first name" validateAt="onSubmit" /></dd>
					<dt><label>Last Name</label></dt>
					<dd><cfinput name="fld_userLastName" id="fld_userLastName" value="#userToEdit.fld_userLastName#" required="true" message="Please, provide a valid last name" validateAt="onSubmit" /></dd>
					<dt><label>E-mail Address</label></dt>
					<dd><cfinput name="fld_userEmail" id="fld_userEmail" value="#userToEdit.fld_userEmail#" required="true" validate="email" message="Please, provide a valid e-mail Address" validateAt="onSubmit" /></dd>
					<dt><label>Password</label></dt>
					<dd><cfinput type="password" name="fld_userPassword" id="fld_userPassword" value="#userToEdit.fld_userPassword#" required="true" message="Please, provide a password" validateAt="onSubmit" /></dd>
					<dt>Role</dt>
					<dd>
						<label><cfinput type="radio" name="fld_userRole" id="fld_userRoleAdmin" value="2" checked="#iif(userToEdit.fld_userRole EQ 2, 'true', 'false')#" />Administrator</label>&nbsp;
						<label><cfinput type="radio" name="fld_userRole" id="fld_userRoleUser" value="1" checked="#iif(userToEdit.fld_userRole EQ 1, 'true', 'false')#" />User</label>
					</dd>
					<dt><label>Instrument</label></dt>
					<dd>
						<cfselect name="fld_userInstrument" id="fld_userInstrument" selected="#userToEdit.fld_userInstrument#" query="userInstruments" value="fld_instrumentID" display="fld_instrumentName" queryposition="below" required="true" >
							<option value="0">Please choose the user instrument</option>
						</cfselect>
					</dd>
					<dt><label>Comment</label></dt>
					<dd>
						<cftextarea name="fld_userComment" id="fld_userComment" richtext="true" >
							<cfoutput>#userToEdit.fld_userComment#</cfoutput>
						</cftextarea>
					</dd>
				</dl>
				<cfinput type="hidden" name="fld_userID" value="#userToEdit.fld_userID#" />
				<input type="submit" name="fld_editUserSubmit" id="fld_editUserSubmit" value="Edit User" />
			</fieldset>
		</cfform>
	</div>
</cf_admin>