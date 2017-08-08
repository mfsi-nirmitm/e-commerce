<!---Delete the news if the url.delete parameter is present--->
<cfif structKeyExists(url,'delete')>
	<cfset application.newsService.deleteNews(url.delete) />
</cfif>
<!--- retrieve all news from the database --->
<cfset allNews = application.newsService.getLatestNews() />
<cf_admin title="HD street band - News administration">
	<script>
		function confirmDelete(newsID)
		{
			if(window.confirm('Are you sure you want to delete this news?'))
			{
				window.location.href = '/final/admin/news.cfm?delete='+newsID;
			}
			else
			{
				null;
			}
		}
	</script>
	<div id="pageBody">
		<h1>News Administration</h1>
		<cfif structKeyExists(url, 'add')>
			<p class="feedback">The news has been successfully created!</p>
		</cfif>
		<cfif structKeyExists(url, 'update')>
			<p class="feedback">The news has been successfully updated!</p>
		</cfif>
		<p><a href="newsAdd.cfm">[Add a news]</a></p>
		<!---Display all the news in a table--->
		<table>
			<tr>
				<th>Title</th>
				<th>Published date</th>
				<th>Author</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
			</tr>
			<cfoutput query="allNews">
				<tr>
					<td>#fld_newsTitle#</td>
					<td>#dateFormat(fld_newsCreationDate, 'mmm-dd-yyyy')#</td>
					<td>#fld_userFirstName# #fld_userLastName#</td>
					<td><a href="newsEdit.cfm?newsID=#fld_newsID#">Edit this news</a></td>
					<td><a href="javascript:confirmDelete(#fld_newsID#);">Delete this news</a></td>
				</tr>
			</cfoutput>
		</table>
	</div>
</cf_admin>