<!---Get page content for fld_pageID = 3--->
<cfset rsPage = application.pageService.getPageByID(3) />
<cf_front title="HD street band - We play for you">
	<div id="pageBody">
	<!---Erase from here--->
		<cfoutput>
			<h1>#rsPage.FLD_PAGETITLE#</h1>
			#rsPage.FLD_PAGECONTENT#
		</cfoutput>
	<!---To here--->
	</div>
</cf_front>
