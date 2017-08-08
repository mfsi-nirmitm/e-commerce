<cfcomponent output="false">
	<!---getNewsForYears() method --->
	<cffunction name="getNewsForYear" access="public" returntype="query">
		<cfargument name="year" type="numeric" required="true" />
		<cfset var rsNewsOfYear = '' />
		<cfquery  name="rsNewsOfYear">
			SELECT FLD_NEWSTITLE, FLD_NEWSCREATIONDATE, FLD_NEWSID
			FROM TBL_NEWS
			WHERE year(FLD_NEWSCREATIONDATE) = <cfqueryparam value="#arguments.year#" cfsqltype="cf_sql_integer" /> 
			ORDER BY FLD_NEWSCREATIONDATE DESC
		</cfquery>
		<cfreturn rsNewsOfYear />
	</cffunction>
	<!---getNewsByID() method --->
	<cffunction name="getNewsByID" access="public" returntype="query">
		<cfargument name="newsID" type="numeric" required="true" />
		<cfset var rsSingleNews = '' />
		<cfquery  name="rsSingleNews">
			SELECT TBL_NEWS.FLD_NEWSCONTENT, TBL_NEWS.FLD_NEWSTITLE, TBL_NEWS.FLD_NEWSID, TBL_NEWS.FLD_NEWSCREATIONDATE, TBL_USERS.FLD_USERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME
			FROM TBL_NEWS INNER JOIN TBL_USERS ON TBL_NEWS.FLD_NEWSAUTHOR = TBL_USERS.FLD_USERID
			WHERE FLD_NEWSID = <cfqueryparam value="#arguments.newsID#" cfsqltype="cf_sql_integer" >  
		</cfquery>
		<cfreturn rsSingleNews />
	</cffunction>
	<!---getLatestNews() method --->
	<cffunction name="getLatestNews" access="public" returntype="query">
		<cfargument name="numNews" type="numeric" required="false" default="-1">
		<cfset var rsAllNews = '' />
		<cfquery  name="rsAllNews" maxrows="#arguments.numNews#">
			SELECT TBL_NEWS.FLD_NEWSTITLE, TBL_NEWS.FLD_NEWSCREATIONDATE, TBL_NEWS.FLD_NEWSID, TBL_NEWS.FLD_NEWSCONTENT, TBL_USERS.FLD_USERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME
			FROM TBL_NEWS INNER JOIN TBL_USERS ON TBL_NEWS.FLD_NEWSAUTHOR = TBL_USERS.FLD_USERID
			ORDER BY FLD_NEWSCREATIONDATE DESC 
		</cfquery>
		<cfreturn rsAllNews />
	</cffunction>
	<!---getNewsYears() method --->
	<cffunction name="getNewsYears" access="public"  returntype="query">
		<cfset var rsNewsYears = '' />
		<cfquery  name="rsNewsYears">
			SELECT YEAR(FLD_NEWSCREATIONDATE) AS fld_newsYear
			FROM TBL_NEWS
			ORDER BY FLD_NEWSCREATIONDATE DESC
		</cfquery>
		<cfreturn rsNewsYears />
	</cffunction>
	
	
	<!---AddNews method--->
	<cffunction name="addNews" returntype="void" roles="Administrator" >
		<cfargument name="newsTitle" required="true" type="string" />
		<cfargument name="newsCreationDate" required="true" type="date" />
		<cfargument name="newsContent" required="true" type="string" />
		<cfquery>
			INSERT INTO TBL_NEWS
			(FLD_NEWSAUTHOR, FLD_NEWSCONTENT, FLD_NEWSCREATIONDATE, FLD_NEWSTITLE)
			VALUES
			(#session.stLoggedInUser.userID#, <cfqueryparam value="#arguments.newsContent#" cfsqltype="cf_sql_longvarchar" />, <cfqueryparam value="#arguments.newsCreationDate#" cfsqltype="cf_sql_timestamp" />, <cfqueryparam value="#arguments.newsTitle#" cfsqltype="cf_sql_varchar" />)
		</cfquery>   
	</cffunction>
	
	
	<!---Update News Method--->
	<cffunction name="updateNews" returntype="void" roles="Administrator">
		<cfargument name="newsTitle" required="true" type="string" />
		<cfargument name="newsDate" required="true" type="date" />
		<cfargument name="newsContent" required="true" type="string" />
		<cfargument name="newsID" required="true" type="numeric" />
		<cfquery>
			UPDATE TBL_NEWS
			SET
			FLD_NEWSTITLE = <cfqueryparam value="#arguments.newsTitle#" cfsqltype="cf_sql_varchar" />,
			FLD_NEWSCREATIONDATE = <cfqueryparam value="#arguments.newsDate#" cfsqltype="cf_sql_date" />,
			FLD_NEWSCONTENT = <cfqueryparam value="#arguments.newsContent#" cfsqltype="cf_sql_longvarchar" />
			WHERE FLD_NEWSID = <cfqueryparam value="#arguments.newsID#" cfsqltype="cf_sql_integer" />
		</cfquery>    
	</cffunction>
	
	
	<!---Delete News Method--->
	<cffunction name="deleteNews" returntype="void" roles="Administrator">
		<cfargument name="newsID" required="true" type="numeric" />
		<cfquery>
			DELETE FROM TBL_NEWS
			WHERE FLD_NEWSID = <cfqueryparam value="#arguments.newsID#" cfsqltype="cf_sql_integer" />
		</cfquery> 
	</cffunction>
	
	
	<!---Validate news form method--->
	<cffunction name="validateNewsForm" returntype="Array" roles="Administrator" >
		<cfargument name="newsTitle" type="string" required="true" />
		<cfargument name="newsDate" type="string" required="true" />
		<cfargument name="newsContent" type="string" required="true" />
		<cfset local.messages = [] />
		<!---Validate news Title--->
		<cfif arguments.newsTitle EQ ''>
			<cfset arrayAppend(local.messages,'Please enter a valid title for your news') />
		</cfif>
		<!---Validate news Date--->
		<cfif arguments.newsDate EQ ''>
			<cfset arrayAppend(local.message, 'Please enter a valid publish date for your news') />
		</cfif>
		<!---Validate news content--->
		<cfif arguments.newsContent EQ ''>
			<cfset arrayAppend(local.messages,'Please provide some content for your news') />
		</cfif>
		<cfreturn local.messages />
	</cffunction>
</cfcomponent>