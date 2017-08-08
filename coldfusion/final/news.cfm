<!---Get news years--->
<cfset rsNewsYears = application.newsService.getNewsYears() />
<cf_front title="HD street band - News">
  <div id="pageBody">
    <div id="calendarContent">
    	<cfif isDefined('url.newsID')>
    		<!---Output a single news--->
    		<cfset rsSingleNews= application.newsService.getNewsByID(url.newsID) />
    		<cfoutput>
    			<h1>#rsSingleNews.FLD_NEWSTITLE#</h1>
    			<p class="metadata">Published on #dateFormat(rsSingleNews.FLD_NEWSCREATIONDATE, 'mmm dd yyyy')# by #rsSingleNews.FLD_USERFIRSTNAME# #rsSingleNews.FLD_USERLASTNAME#</p>
    			#rsSingleNews.FLD_NEWSCONTENT#
    		</cfoutput>
    		<!---include the commenting system---->
    		<cfinclude template="includes/commentForm.cfm" >
    	<cfelseif isDefined('url.year') >
    		<cfset rsNewsOfYear = application.newsService.getNewsForYear(url.year) />
    			<h1>All the news of year <cfoutput>#url.year#</cfoutput></h1>
      <table>
		<!---Output  news in a table--->
		<cfoutput query="rsNewsOfYear">
			<tr>
				<td>#dateFormat(FLD_NEWSCREATIONDATE, 'mmm dd yyyy')#</td>
				<td>#FLD_NEWSTITLE#</td>
				<td><a href="news.cfm?newsID=#FLD_NEWSID#">Read More</a></td>
			</tr>
		</cfoutput>
      </table>
    	<cfelse>
	<!---Output all news if no url scope newsID not present in URL--->
	
	
	<!---Get all news--->
	<cfset rsAllNews = application.newsService.getLatestNews() />
	  <h1> News</h1>
      <table>
		<!---Output  news in a table--->
		<cfoutput query="rsAllNews">
			<tr>
				<td>#dateFormat(FLD_NEWSCREATIONDATE, 'mmm dd yyyy')#</td>
				<td>#FLD_NEWSTITLE#</td>
				<td><a href="news.cfm?newsID=#FLD_NEWSID#">Read More</a></td>
			</tr>
		</cfoutput>
      </table>
      </cfif>
</div>
    <div id="calendarSideBar">
<h1>News archive</h1>
      <ul>
        <cfoutput query="rsNewsYears" group="fld_newsYear">
        	<li><a href="news.cfm?year=#fld_newsYear#">#fld_newsYear#</a></li>
        </cfoutput>
      </ul>
      <p class="alignRight">&nbsp;</p>
</div>
  </div>
</cf_front>