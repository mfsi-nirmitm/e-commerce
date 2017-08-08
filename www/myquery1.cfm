<!---Get some data from, in this case, the database--->
<cfquery name="getData" datasource="cfartgallery" >
    select ARTISTID, ARTID, ARTNAME, DESCRIPTION, ISSOLD, PRICE, LARGEIMAGE from ART
    where artistid = 1
</cfquery>

<!---Process the query result and generate xml--->
<cfxml variable="artxml"> 
<art artistid="<cfoutput>#getdata.artistid#</cfoutput>"> 
    <cfoutput query="getData"> 
        <piece id="#getData.artid#" available="#getdata.isSOLD#">
            <artname>#getData.artname#</artname>
            <description>#getData.artNAME#</description>
            <image>#getData.LARGEIMAGE#</image>     
            <price>#getData.PRICE#</price>  
        </piece>
    </cfoutput>
</art>
</cfxml>
<cffile action="write" file="#expandpath('./out.xml')#" output="#artxml#" />