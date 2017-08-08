<!---Get page content for fld_pageID = 6--->
<cfset rsPage = application.pageService.getPageByID(6) />

<cf_front title="HD street band - Contact Us">
  <div id="pageBody">
  <!---Erase from here--->
	<cfoutput>
	  	<h1>#rsPage.FLD_PAGETITLE#</h1>
	  	#rsPage.FLD_PAGECONTENT#
	</cfoutput>
<!---To here--->
</div>
</cf_front>
