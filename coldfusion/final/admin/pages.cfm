<!--- Get all pages from the database. --->
<cfset allPages = application.pageService.getAllPages() />
<cf_admin title="HD-Street band - Pages administration">
	<div id="pageBody">
		<h1>Pages administration</h1>
		<!---Display a feedback message to the user--->
		<cfif structKeyExists(url, 'update')>
			<p class="feedback">The page has been successfully updated.</p>
		</cfif>
		<!--- Display the list of all pages in an html table --->
		<table>
			<tr>
				<th>Title</th>
				<th>Modified Date</th>
				<th>Last modified by</th>
				<th>&nbsp</th>
			</tr>
			<cfoutput query="allPages">
				<tr>
					<td>#allPages.fld_pageTitle#</td>
					<td>#dateFormat(allPages.fld_pageModificationDate, 'mmm-dd-yyyy')#</td>
					<td>#allPages.fld_modifierFirstName# #allPages.fld_modifierLastName#</td>
					<td><a href="pageEdit.cfm?pageID=#allPages.fld_pageID#">Update this page</a></td>
				</tr>
			</cfoutput>
		</table>
	</div>
</cf_admin>