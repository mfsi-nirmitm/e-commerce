<!---Get page content for fld_pageID = 5--->
<cfset rsPage = application.pageService.getPageByID(5) />
<cf_front title="HD street band - Site Map">
  <div id="pageBody">
  <!---Erase from here--->
	<cfoutput>
	  	<h1>#rsPage.FLD_PAGETITLE#</h1>
	  	#rsPage.FLD_PAGECONTENT#
	</cfoutput>
   <!---To here--->
</div>
</cf_front>
