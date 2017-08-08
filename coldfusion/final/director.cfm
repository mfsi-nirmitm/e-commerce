<!---Get page content--->
<cfset rsPage = application.pageService.getPageByID(1) />

<cf_front title="HD street band - The band director">
  <div id="pageBody">
  	<cfoutput>
  		<h1>#rsPage.FLD_PAGETITLE#</h1>
  		#rsPage.FLD_PAGECONTENT#
  	</cfoutput>
</div>
</cf_front>