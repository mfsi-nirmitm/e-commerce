<cfset variables.currentURL = "https://" & "#CGI.SERVER_NAME#" & "#CGI.SCRIPT_NAME#" />
<cfoutput>
	#variables.currentURL#
</cfoutput>