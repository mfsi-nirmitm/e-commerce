<!---/**
 * services
 *
 * @author mindfire
 * @date 7/31/17
 **/--->
<cfcomponent>
  <cffunction name="updateDescription" access="remote" returntype="void">
    <cfargument name="value" type="string" required="yes">

      <cfoutput>
        #cfcatch.Detail#<br />
        #cfcatch.Message#<br />
        #cfcatch.tagcontext[1].line#:#cfcatch.tagcontext[1].template#
      </cfoutput>


  </cffunction>


	<cffunction name="getEmp" access="remote">
        <cfargument name="lastName" required="true">
        <cfset var empQuery="">
         <cfquery name="empQuery" datasource="coldfusionbasic">
             SELECT username, email
             FROM users
			 where username = 'arguments.lastName'
         </cfquery>

         <cfdump var=#empQuery#>
    </cffunction>
</cfcomponent>