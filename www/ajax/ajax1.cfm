<cfcomponent output="false">
 <cffunction name="getDivContent" returntype="string" access="remote">
  <cfargument name="edit">
  <cfreturn "This is the content returned from the CFC for 
   the div, the calling page variable is '<strong>#arguments.edit#</strong>'.">
 </cffunction>
</cfcomponent>
<cfform id="myForm" format="html">
  This is my edit box.<br />
  <cfinput type="text" name="myText">
</cfform>
<hr />
And this is the bound div container.<br />
<cfdiv bind="cfc:bindsource.getDivContent({myText})"></cfdiv>


/////////////////////////////////////////////////////////////////////

If you have multiple functions in your cfm(even if you don't), put them in a cfc. Then you can use the following url pattern to invoke a specific method.

cfc named myEntityWS.cfc

<cfcomponent>
  <cffunction name="updateDescription" access="remote" returntype="string">
    <cfargument name="value" type="string" required="yes">
    <cftry>
      your code here
    <cfcatch>
      <cfoutput>
        #cfcatch.Detail#<br />
        #cfcatch.Message#<br />
        #cfcatch.tagcontext[1].line#:#cfcatch.tagcontext[1].template#
      </cfoutput>
    </cfcatch>
    </cftry>
  </cffunction>
</cfcomponent>
Javascript

$.get('myEntityWS.cfc?method=updateDescription&value=someValue');