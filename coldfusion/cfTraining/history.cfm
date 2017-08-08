<!---Get page content for fld_pageId =2
<cfinclude template="includes/myFunctions.cfm"> --->

<cfset rsPage= application.pageService.getPageByID(2) />
<!---<cfmodule template="customTags/front.cfm" title="HD street band - History">--->
<cf_front>
	<div id="pageBody">
		<cfoutput>
			<h1>#rsPage.FLD_PAGETITLE#</h1>
			#rsPage.FLD_PAGECONTENT#
		</cfoutput>
	</div>
</cf_front>
<!---</cfmodule>--->