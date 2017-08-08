
<cfset rsPage = application.pageService.getPageByID(1) />
<!---<cfmodule template="customTags/front.cfm" title="HS street ban- Adenda">--->
<cf_front>
	<div id="pageBody">
  		<cfoutput>
			<h1>#rsPage.FLD_PAGETITLE#</h1>
			#rsPage.FLD_PAGECONTENT#
		</cfoutput>
	</div>
</cf_front>
<!---</cfmodule>--->