<cfcomponent output="false" displayname="Page Service component" hint="This component handles various aspects of page management">
	<cffunction name="getPageByID" returntype="query" hint="This function retreives a single page from the database based on the unique ID number of the page">
		<cfargument name="pageID" type="numeric" required="true" hint="Unique ID number of the page to retreive">
		<cfset var rsPage = '' />
		<cfquery  name="rsPage">
			SELECT FLD_PAGETITLE, FLD_PAGECONTENT
			FROM TBL_PAGES
			WHERE FLD_PAGEID = <cfqueryparam value="#arguments.pageID#" cfsqltype="cf_sql_integer" /> AND FLD_PAGEISACTIVE = <cfqueryparam  value="1" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn rsPage />
	</cffunction>
	<!---Update Page Method--->
	<cffunction name="updatePage" returntype="void" roles="Administrator">
		<cfargument name="pageTitle" required="true" type="string" />
		<cfargument name="pageContent" required="true" type="string" />
		<cfargument name="pageID" required="true" type="numeric" />
		<cfquery>
			UPDATE TBL_PAGES
			SET
			FLD_PAGECONTENT = <cfqueryparam value="#arguments.pageContent#" cfsqltype="cf_sql_longvarchar" />,
			FLD_PAGEMODIFICATIONDATE = #now()#,
			FLD_PAGEMODIFIER = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />,
			FLD_PAGETITLE = <cfqueryparam value="#arguments.pageTitle#" cfsqltype="cf_sql_varchar" />
			WHERE FLD_PAGEID = <cfqueryparam value="#arguments.pageID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	
	<!--- Get all pages Method --->
	<cffunction name="getAllPages" returntype="Query" roles="Administrator">
		<cfquery name="local.rs_allPages">
			SELECT TBL_PAGES.FLD_PAGEID, TBL_PAGES.FLD_PAGETITLE, TBL_PAGES.FLD_PAGECONTENT, TBL_PAGES.FLD_PAGEMODIFICATIONDATE, TBL_USERS.FLD_USERFIRSTNAME AS FLD_MODIFIERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME AS FLD_MODIFIERLASTNAME
			FROM TBL_PAGES INNER JOIN TBL_USERS ON TBL_PAGES.FLD_PAGEMODIFIER = TBL_USERS.FLD_USERID
			WHERE TBL_PAGES.FLD_PAGEISACTIVE = 1
			ORDER BY TBL_PAGES.FLD_PAGEID ASC
		</cfquery> 
		<cfreturn local.rs_allPages />
	</cffunction>
	
	<!---Validate page form method--->
	<cffunction name="validatePageForm" returntype="array" roles="Administrator">
		<cfargument name="pageTitle" required="true" type="string" />
		<cfargument name="pageContent" required="true" type="string" />
		<cfset local.messages = []/>
		<cfif arguments.pageTitle EQ ''>
			<cfset arrayAppend(local.messages,'Please provide a valid page title') />
		</cfif>
		<cfif arguments.pageContent EQ ''>
			<cfset arrayAppend(local.messages, 'Please provide a valid page content') />
		</cfif>
		<cfreturn local.messages />
	</cffunction>
</cfcomponent>