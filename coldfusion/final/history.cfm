<!---Get page content for fld_pageID = 2--->
<cfset rsPage = application.pageService.getPageByID(2) />
<cf_front title="HD street band - History">
  <div id="pageBody">
  <cfoutput>
  	<h1>#rsPage.FLD_PAGETITLE#</h1>
  	#rsPage.FLD_PAGECONTENT#
  </cfoutput>
</div>
</cf_front>
