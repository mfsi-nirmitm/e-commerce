<h2>Find People</h2>
<cfform action="https://127.0.0.1/coldfusion/experiment/components/services.cfc?method=getEmp" method="post">
    <p>Enter employee's last Name:</p>
    <cfinput type="Text" name="lastName">
    <cfinput type="Hidden" name="method" value="getEmp">
    <cfinput type="Submit" title="Submit Query" name= "submit" ><br>
</cfform>