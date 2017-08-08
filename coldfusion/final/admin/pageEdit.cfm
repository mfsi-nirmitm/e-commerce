<!--- Confirm url.pageID is passed --->
<cfif NOT structKeyExists(url, 'pageID')>
	<cflocation url="pages.cfm" />
</cfif>
<!--- Begin form processing --->
<cfif structKeyExists(form, 'fld_editPageSubmit')>
	<cfset aErrorMessages = application.pageService.validatePageForm(form.fld_pageTitle,form.fld_pageContent) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.pageService.updatePage(form.fld_pageTitle,form.fld_pageContent,form.fld_pageID) />
		<cflocation url="pages.cfm?update=true" />
	</cfif>
</cfif>
<!--- End Form Processing --->
<!---Get current page data--->
<cfset pageToUpdate = application.pageService.getPageByID(url.pageID) />
<cf_admin title="HD-Street band - Pages administration">
	<div id="pageBody">
		<h1>Edit a page</h1>
		<cfform id="frm_editPage" preservedata="true" >
		<!--- Display pages form --->
			<fieldset>
				<legend>Edit a page</legend>
				<!--- output error messages if messages array not empty --->
				<cfif isDefined('variables.aErrorMessage') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
					<cfloop array="#variables.aErrorMessages#" index="message">
						<p class="errorMessage">#message#</p>
					</cfloop> 
					</cfoutput>
				</cfif>
				<dl>
					<dt><label for="fld_pageTitle">Page Title</label></dt>
					<dd><cfinput name="fld_pageTitle" id="fld_pageTitle" value="#pageToUpdate.fld_pageTitle#" required="true" message="Please enter a valid page title" validateAt="onSubmit" /></dd>
					<dt><label for="fld_pageContent">Page Content</label></dt>
					<dd>
						<cftextarea name="fld_pageContent" id="fld_pageContent" required="true" message="Please enter a valid page content" validateAt="onSubmit" richtext="true" height="500" >
							<cfoutput>#pageToUpdate.fld_pageContent#</cfoutput>
						</cftextarea>
					</dd>
				</dl>
				<!---Create hidden form field to store page ID--->
				<cfinput type="hidden" name="fld_pageID" value="#url.pageID#" />
				<input type="submit" name="fld_editPageSubmit" id="fld_editPageSubmit" value="Update Page" />
			</fieldset>
		</cfform>
	</div>
</cf_admin>