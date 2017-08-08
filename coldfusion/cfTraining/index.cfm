<cfset newsService = createObject("component",'coldfusion.cfTraining.components.newsService') />
<cf_front>
  <div id="pageBody">
    <div id="homeContent">
		<!---Display the latest new in the main area--->

		<cfset latestNews=newsService.getLatestNews(1) />
		<cfoutput>
			<h1>#latestNews.FLD_NEWSTITLE#</h1>
			<p class="metadata">Published on #dateFormat(latestNews.FLD_NEWSCREATIONDATE,'mmm dd yyyy')# by #latestNews.FLD_USERFIRSTNAME# #latestNews.FLD_USERLASTNAME#</p>
			#latestNews.FLD_NEWSCONTENT#
		</cfoutput>
    </div>
    <div id="homeSideBar">
      <div class="pod">
        <h1 id="nextEventsTitle">Next Events</h1>
        <ul>
          <li><a href="events/20110719.html"><strong>Jul 19</strong> - Redville AK</a></li>
          <li><a href="events/20110720.html"><strong>Jul 20</strong> - Redville AK</a></li>
          <li><a href="events/20110722.html"><strong>Jul 22</strong> - Redville AK</a></li>
        </ul>
      </div>
      <div class="pod">
        <h1 id="latestNewsTitle">latest News</h1>
        <ul>
          <li><a href="news/20110506.html"><strong>May  06</strong> - New concerts announced</a></li>
          <li><a href="news/20110430.html"><strong>Apr 30</strong> - Happy Birthday Tony!</a></li>
        </ul>
      </div>
    </div>
  </div>
</cf_front>