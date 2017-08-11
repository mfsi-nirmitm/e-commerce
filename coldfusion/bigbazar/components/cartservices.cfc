<!---
**
* cartservices
*
* @author mindfire
* @date 7/26/17
**
--->
<cfcomponent>
	<!--- checking the product is in cart or not --->
	<cffunction name = "isProductAlreadyInCart" access = "public" returntype = "boolean" hint = "checking weather the product exist or not" >
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "argument for productwithsellerid to check exist or not in session" >
		<cfargument name = "items" required = "true" type = "numeric" hint = "argumen to know the no of items on productwithsellerid" />
		<cfset local.hasProduct = false />
		<!--- taking the session for finding the product --->
		<cfloop array = "#session.cart#" index = "thing">
			<cfoutput>
				<cfif #thing['productwithsellerid']# EQ arguments.productWithSellerID>
					<cfset local.hasProduct = true />
					<cfset #thing['items']# = #thing['items']# + #arguments.items# />
				</cfif>
			</cfoutput>
		</cfloop>
		<cfreturn local.hasProduct />
	</cffunction>

	<!--- adding the cart for the guest user --->
	<cffunction name = "addCartForGuestUser" access = "public" returntype = "void" hint = "adding the cart to the session for guest user">
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "argument for productwithsellerid to find the product detail" />
		<cfargument name = "items" required = "true" type = "numeric" hint = "argument to get the no of items per product to seller" />
		<cfargument name = "productPrice" required = "true" type = "numeric" hint = "argument to get the price of one product" />
		<cfargument name = "productName" required = "true" type = "string" hint = "name of the product" />
		<cfargument name = "sellerName" required = "true" type = "string" hint = "name of the seller" />
		<cfargument name = "shippingPrice" required = "true" type = "numeric" hint = "shipping cost of the product" />
		<cfargument name = "imageURL" required = "true" type = "string" hint = "image url" />

		<!--- Checking session is running or not --->
		<cfif NOT structKeyExists ( session , 'cart' ) >

			<!--- Save cart data in the session scope for guest user --->
			<cfset session.cart = ArrayNew(1) />

		</cfif>
		<cfif NOT isProductAlreadyInCart(#arguments.productWithSellerID#,#arguments.items#) >
			<cfset sessionBasket = StructNew() />
			<cfset sessionBasket['productwithsellerid'] = arguments.productWithSellerID />
			<cfset sessionbasket['items'] = arguments.items />
			<cfset sessionbasket['productprice'] = arguments.productPrice />
			<cfset sessionbasket['productname'] = arguments.productName />
			<cfset sessionbasket['sellername'] = arguments.sellerName />
			<cfset sessionbasket['shippingprice'] = arguments.shippingPrice />
			<cfset sessionbasket['imageurl'] = arguments.imageURL />
			<cfset ArrayAppend(session.cart,sessionBasket) />
		</cfif>
	</cffunction>

	<!--- adding the product to the cart if product is already in cart --->
	<cffunction name = "addProductByProductWithSellerID" access = "remote"  returntype = "void" hint = "adding an product from the cart" >
		<cfargument name = 'productWithSellerID' required = "true" type = "numeric" />
		<!--- checking the session for logged In user and adding the product for logged in user --->
		<cfif structKeyExists(session,'loggedIn')>
			<cfset local.customerID = #session.loggedIn['customerID']# />
			<cftry>
				<cfquery >
					UPDATE CART
					SET ITEMS = ITEMS + 1
					WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
					AND CUSTOMERID = <cfqueryparam value = "#local.customerID#" cfsqltype = "cf_sql_numeric" />
				</cfquery>
				<!--- redirecting to the error page if database is not connected ---->
				<cfcatch type="any">
					<cflocation url = "error.cfm" addToken = "no" />
				</cfcatch>
			</cftry>
		<!--- adding the product for guest user --->
		<cfelseif structkeyExists (session , 'cart') >
			<cfloop index = "i" from ="1" to="#ArrayLen(session.cart)#" >
				<cfif #session.cart[i].productwithsellerid#  eq arguments.productWithSellerID>
					<cfset #session.cart[i].items# = #session.cart[i].items# + 1 />
				</cfif>
			</cfloop>
		</cfif>

	</cffunction>

	<!--- decrementign the product if product is already in the cart --->
	<cffunction name = "decrementProductByProductWithSellerID" access = "remote" returntype = "void" hint = "decrement an product form the cart">
		<cfargument name = "productWithSellerID" required ="true" type = "numeric" />

		<!--- checking the session exists or not --->
		<cfif structKeyExists(session,'loggedIn')>
			<cfset local.customerID = #session.loggedIn['customerID']# />
			<cftry>
				<cfquery >
					UPDATE CART
					SET ITEMS = ITEMS - 1
					WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
					AND CUSTOMERID = <cfqueryparam value = "#local.customerID#" cfsqltype = "cf_sql_numeric" />
				</cfquery>
				<!--- redirecting to the error page if database is not connected ---->
				<cfcatch type="any">
					<cflocation url = "error.cfm" addToken = "no" />
				</cfcatch>
			</cftry>
		<cfelseif structKeyExists(session, 'cart')>
			<cfloop index = "i" from = "1" to ="#ArrayLen(session.cart)#" >
				<cfif #session.cart[i].productwithsellerid# eq arguments.productWithSellerID >
					<cfset #session.cart[i].items# = #session.cart[i].items# -1 />
				</cfif>
			</cfloop>
		</cfif>
	</cffunction>


	<!--- getting the add of price and shipping price of the product  --->
	<cffunction  name = "getTotalPriceByProductWithSellerID" access = "remote" returntype = "numeric" hint = "calculating the total price of an product" >
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" />

		<cftry>
			<cfquery name = "local.getTotalPrice" >
				SELECT (SHIPPINGPRICE + PRICE) AS TOTALPRICE
				FROM PRODUCTSWITHSELLERS
				WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_integer" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected ---->
			<cfcatch type="any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfreturn local.getTotalPrice.TOTALPRICE />
	</cffunction>

	<!--- removing the product from the cart --->
	<cffunction name = "removeProductByProductWithSellerID" access = "remote" returntype = "void" hint = "removing an product" >
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" />
		<cfset local.targetIndex = 0 />
		<cfif structKeyExists(session, 'loggedIn')>
			<cfset local.customerID = #session.loggedIn['customerID']# />
			<cftry>
				<cfquery name = "removeProduct">
					DELETE Cart
					WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
					AND CUSTOMERID = <cfqueryparam value = "#local.customerID#" cfsqltype = "cf_sql_numeric" />
				</cfquery>
				<!--- redirecting to the error page if database is not connected ---->
				<cfcatch type="any">
					<cflocation url = "error.cfm" addToken = "no" />
				</cfcatch>
			</cftry>
		<cfelseif structkeyExists(session,'cart')>
			<cfloop index ="i" from = "1" to = "#ArrayLen(session.cart)#" >
				<cfif #session.cart[i].productwithsellerid# eq #arguments.productWithSellerID# >
					<cfset local.targetIndex = #i#  />
				</cfif>
			</cfloop>
			<cfset ArrayDeleteAt(#session.cart#, #local.targetIndex#) />
		</cfif>
	</cffunction>
</cfcomponent>