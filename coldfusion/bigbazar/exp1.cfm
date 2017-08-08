<!---
<cfset ThingsILike = arrayNew(1) />

<cfset FruitBasket = structNew() />

<cfset FruitBasket['productwithsellerid'] = 1  />
<cfset FruitBasket['items'] = 2  />

<cfset ArrayAppend(ThingsILike,FruitBasket)  />

<cfset FruitBasket = structNew() />
<cfset FruitBasket['productwithsellerid'] = 2  />
<cfset FruitBasket['items'] = 4  />

<cfset ArrayAppend(ThingsILike,FruitBasket) />
<cfset index1 = 0 />
<cfloop array="#ThingsILike#" index="thing">
    <cfoutput>
		<p>#thing['productwithsellerid']# - #thing['items']#</p>
		<cfif #thing['productwithsellerid']# EQ 1>
			<cfset  index1 = ArrayFind(#ThingsILike#,#thing#) />
		</cfif>
	</cfoutput>
</cfloop>
<cfset ArrayDeleteAt(#ThingsILike#,#index1#) />
after delete
<cfloop array="#ThingsILike#" index="thing">
    <cfoutput>
		<p>#thing['productwithsellerid']# - #thing['items']#</p>
	</cfoutput>
</cfloop>
--->
<!---<cfif structKeyExists ( session , 'cart' ) >
	<cfloop array = "#session.cart#" index = "thing">
		<cfoutput>
			<p>#thing['productwithsellerid']# - #thing['items']#</p>
		</cfoutput>
	</cfloop>
	<!---
	<cfset StructDelete(Session,"cart")>
	--->
</cfif>
--->
<!---
<cfif structkeyExists (session , 'cart') >
	<cfset variables.cartarray = ArrayNew (1) />

	<cfloop array = "#session.cart#" index = "thing">
		<cfset variables.cartbasket = StructNew() />
		<cfset variables.cartbasket['productwithsellerid'] = #thing['productwithsellerid']# />
		<cfset variables.cartbasket['items'] = #thing['items']#  />
		<cfset ArrayAppend(variables.cartarray, variables.cartbasket) />
	</cfloop>
</cfif>
	<cfloop array="#variables.cartarray#" index="thing">
	    <cfoutput>
			<!---<p>#thing['productwithsellerid']# - #thing['items']#</p>
			--->
			<cfset variables.resultProductDetail = application.productService.getProductDetailByProductWithSellerID(#thing['productwithsellerid']#) />
			<img src="#variables.resultproductDetail.imageurl#" > <br>
			<p>
				#variables.resultProductDetail.PRODUCTNAME# - #variables.resultProductDetail.PRICE# - #variables.resultProductDetail.INSTOCK#
			</p>
		</cfoutput>
	</cfloop>


--->
<!--->
<cffunction name="TEST" returntype="string" output="false">
    <cfreturn "This is test. The time is " & timeformat(now(), "HH:MM:SS")>
</cffunction>

<cfform>

		<cfinput name="TEST" type="button" value="#test()#">
</cfform>
--->


<!--- This is the solution for calling the coldfusion function from the javascript function

<cfajaxproxy cfc="coldfusion.bigbazar.components.experiment" jsclassname="jsClass">
<script type="text/javascript">
    var _myFuncs = new jsClass()

    function buttonClicked() {
       alert(_myFuncs.getRecords());
    }

</script>
<button onclick = "buttonClicked();">click</button>
--->

<cfoutput>#Int('')#</cfoutput>


