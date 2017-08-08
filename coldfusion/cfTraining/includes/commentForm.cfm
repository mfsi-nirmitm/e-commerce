
<!---Form Processing--->
<cfif isDefined('form.fld_commentSubmit')>
	<!---Server side form validation--->
	<cfset variables.aErrorMessages = application.commentsService.validateComment(form.fld_commentAuthor,form.fld_commentContent, fld_commentSecuritySystem,fld_commentSecurityUser) />
	<!---continue form processing if no errors--->
	<cfif arrayIsEmpty(variables.aErrorMessages)>
		<!--- insert the comment in the database --->
		<cfset application.commentsService.addComment(fld_commentAuthor,fld_commentContent,url.newsID) />
	</cfif>
	
</cfif>
<!---Get comments for news from comments service--->
<cfset variables.commentsForNews = application.commentsService.getCommentsForNews(url.newsID) />
<!---Generate security code--->

<div id="comments">
	<cfif variables.commentsForNews.recordCount EQ 1>
		<h2>There is one comment for this news</h2>
	<cfelseif variables.commentsForNews.recordCount GT 1>
		<h2>There are <cfoutput>#variables.commentsForNews.recordCount#</cfoutput> comments for this news</h2>
	<cfelse>
		<h2>There are no comments yet for this news</h2>
	</cfif>
	<!---Display comments for new if there are comments to display.  Display message instead--->
	<cfif variables.commentsForNews.recordCount EQ 0>
		<p>Be the first to comment this news</p>
	<cfelse>
		<ol id="displayComments">
			<cfoutput query="variables.commentsForNews">
			<li>
				<p class="metadata">On #dateFormat(fld_commentDate)#, #fld_commentAuthor# Wrote</p>
				<cfif NOT fld_commentIsApproved>
					<p class="metadata"><strong>This comment has not yet been moderated</strong></p>
				</cfif>
				#fld_commentContent#
			</li>
			</cfoutput>
		</ol>
	</cfif>
</div>
<!---Display comments form--->
<cfform id="frm_comment" preservedata="true" >
	<fieldset>
		<legend>Add your comment</legend>
		<!---display error messages if any--->
			<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
				<cfoutput>
				<cfloop array="#variables.aErrorMessages#" index="message">
					<p class=errorMessage>#message#</p>
				</cfloop>
				</cfoutput>
			</cfif>
		<dl>
			<dt><label for="fld_commentAuthor">Your Name</label></dt>
			<dd><cfinput name="fld_commentAuthor" id="fld_commentAuthor" required="true" message="Please enter your name or nickname in the form" validateAt="onSubmit" /></dd>
			<dt><label for="fld_commentContent">Your Comment</label></dt>
			<dd>
				<cftextarea name="fld_commentContent" id="fld_commentContent" richtext="true" toolbar="Basic" required="true" message="Please enter your comment in the appropriate field" validateAt="onSubmit" ></cftextarea>
			</dd>
			<!--- display the captcha image here --->
			<dt><label for="fld_commentSecurityUser">Security code</label></dt>
			<dd><cfinput name="fld_commentSecurityUser" id="fld_commentSecurityUser" required="true" message="Please enter the security code in the appropriate field" validateAt="onSubmit" /></dd>
		</dl>
		
		<input type="hidden" name="fld_commentSecuritySystem" value="<cfoutput>#variables.securityCode#</cfoutput>" />
		<input type="submit" name="fld_commentSubmit" id="fld_commentSubmit" value="Submit your comment" />
	</fieldset>
</cfform>