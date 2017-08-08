<!---Delete a comment--->
<cfif structKeyExists(URL,'delete')>
	<cfset application.commentsService.deleteComment(url.delete) />
</cfif>
<!---Approve comments--->
<cfif structKeyExists(URL,'approve')>
	<cfset application.commentsService.approveComment(url.approve) />
</cfif>
<!---Get the list of comments to approve--->
<cfset commentsToApprove = application.commentsService.getUnapprovedComments() />
<!---Get the list of approved comments--->
<cfset approvedComments = application.commentsService.getAllComments() />
<cf_admin title="HD street band - Comments administration">
	<script>
		function confirmDelete(commentID)
		{
			if(window.confirm('Are you sure you want to delete this comment?'))
			{
				window.location.href = '/final/admin/comments.cfm?delete='+commentID;
			}
			else
			{
				null;
			}
		}
	</script>
	<div id="pageBody">
		<h1>Comments Administration</h1>
		<cfif structKeyExists(URL,'approve')>
			<p class="feedback">The comment has been approved!</p>
		</cfif>
		<cfif structKeyExists(URL,'update')>
			<p class="feedback">The comment has been modified!</p>
		</cfif>
		<h2>Comments awaiting approval</h2>
		<cfif commentsToApprove.recordCount EQ 0>
			<p>There are no comments awaiting approval at this time.</p>
		<cfelse>
			<table>
				<tr>
					<th>Date</th>
					<th>Author</th>
					<th>Comment</th>
					<th>News</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
				<cfoutput query="commentsToApprove">
					<tr>
						<td>#dateFormat(fld_commentDate, 'mmm-dd-yyyy')#</td>
						<td>#fld_commentAuthor#</td>
						<td>#fld_commentContent#</td>
						<td><a href="../news.cfm?newsID=#fld_newsID#" target="_blank">#fld_newsTitle#</a></td>
						<td><a href="comments.cfm?approve=#fld_commentID#">Approve</a></td>
						<td><a href="commentEdit.cfm?commentID=#fld_commentID#">Modify</a></td>
						<td><a href="javascript:confirmDelete(#fld_commentID#);">Reject</a></td>
					</tr>
				</cfoutput>
			</table>
		</cfif>
		<h2>List of approved comments</h2>
		<table>
			<cfoutput query="approvedComments" group="fld_newsTitle">
				<tr>
					<th colspan="5">#fld_newsTitle#</th>
				</tr>
				<cfoutput>
					<tr>
						<td>#dateformat(fld_commentDate, 'mmm-dd-yyyy')#</td>
						<td>#fld_commentAuthor#</td>
						<td>#fld_commentContent#</td>
						<td><a href="commentEdit.cfm?commentID=#fld_commentID#">Modify</a></td>
						<td><a href="javascript:confirmDelete(#fld_commentID#);">Delete</a></td>
					</tr>
				</cfoutput>
			</cfoutput>
		</table>
	</div>
</cf_admin>