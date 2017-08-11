<!---/**
 * userservices
 *
 * @author mindfire
 * @date 8/9/17
 **/--->
<cfcomponent extends="checkoutservices" >

	<!--- adding the user detail for registering user --->
	<cffunction name = "registerUser" access = "public" returntype="numeric" hint = "adding user detail for registration">
		<cfargument name = "firstName" required = "true" type = "string" hint = "first name of customer" />
		<cfargument name = "lastName" required = "true" type = "string" hint = "last name of the customer" />
		<cfargument name = "password" required = "true" type = "string"  hint = "password for customer" />
		<cfargument name = "email" required = "true" type = "string"  hint = "email of customer for registration" />
		<cfargument name = "customerTypeId" required = "true" type = "numeric" hint = "type of customer" />

		<cfset local.customerID=#Int(Super.insertCustomerDetail(#arguments.firstName#,#arguments.lastName#,#arguments.email#,#arguments.customerTypeId#))# />
		<cftry>
			<cfquery>
				INSERT INTO CUSTOMERLOGIN
				( PASSWORD , CUSTOMERID )
				VALUES
				(
					<cfqueryparam value = "#arguments.password#" cfsqltype = "cf_sql_string" /> ,
					<cfqueryparam value = "#local.customerID#" cfsqltype = "cf_sql_numeric" />
				)
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type="any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfreturn local.customerID />
	</cffunction>

	<!--- check if mail id already exists --->
	<cffunction name = "haveEmail" access = "public" returntype = "boolean" hint = "checking email already there is database or not ">
		<cfargument name = "email" required = "true" type = "string" hint = "email of customer" />
		<cfargument name = "customerTypeId" required = "true" type = "numeric" hint = "type of customer" />

		<cfset local.isEmailExist = false />
		<cftry>
			<cfquery name = "getMail">
				SELECT *
				FROM CUSTOMER
				WHERE EMAILADDRESS = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_string" />
				AND CUSTOMERTYPEID = <cfqueryparam value = "#arguments.customerTypeId#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
			<cfcatch type = "any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfif getMail.RecordCount GT 0>
			<cfset local.isEmailExist = true />
		</cfif>

		<cfreturn local.isEmailExist />
	</cffunction>

	<cffunction name = "doLogin" access = "public" returntype = "boolean" hint = "logging the custoer on valid input" >
		<cfargument name = "loginEmail" required = "true" type = "string" hint = "email of customer for login" />
		<cfargument name = "password" required = "true" type = "string" hint = "password of customer for login" />

		<cfset local.isValid = true />
		<cftry>
			<cfquery name = "getLogin">
				SELECT CUS.CUSTOMERID , CUS.FIRSTNAME
				FROM CUSTOMER AS CUS
				INNER JOIN CUSTOMERLOGIN AS CUSLOG
				ON CUS.CUSTOMERID = CUSLOG.CUSTOMERID
				AND CUS.EMAILADDRESS = <cfqueryparam  value = "#arguments.loginEmail#" cfsqltype = "cf_sql_string" />
				AND CUSLOG.PASSWORD = <cfqueryparam value = "#arguments.password#" cfsqltype = "cf_sql_string" />
			</cfquery>
			<!--- redirecting to error page if database is not connected --->
			<cfcatch type = "any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfif getLogin.RecordCount eq 0 >
			<cfset local.isValid = false />
		<cfelse>
			<cfset session.loggedIn['customerID'] = #getLogin.CUSTOMERID# />
			<cfset session.loggedIn['customerName'] = #getLogin.FIRSTNAME# />
			<cfif structKeyExists(session,'cart')>
				<cfloop array = "#session.cart#" index = "thing">
					<cfset addCartForRegisteredUser(#thing['productwithsellerid']#,#session.loggedIn['customerID']#,#thing['items']#) />
				</cfloop>
				<cfset structDelete(session,'cart') />
			</cfif>
		</cfif>

		<cfreturn local.isValid />
	</cffunction>

	<!--- adding the cart detial for the registered customer --->
	<cffunction name = "addCartForRegisteredUser" access = "public" returntype = "void" hint = "adding the cart for registered user">
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "productwithseller id to identify the product with seller" />
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "costumer's i'd" />
		<cfargument name = "items" required = "true" type = "numeric" hint = "no of items" />

		<cftry>
			<cfquery name = "isProductInCart">
				SELECT *
				FROM CART
				WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
				AND CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfif isProductInCart.RecordCount EQ 0 >
			<cftry>
				<cfquery name = "insertProduct">
					INSERT INTO CART
					( PRODUCTWITHSELLERID , CUSTOMERID, ITEMS )
					VALUES
					(
						<cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" /> ,
						<cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" /> ,
						<cfqueryparam value = "#arguments.items#" cfsqltype = "cf_sql_numeric" />
					)
				</cfquery>
				<!--- redirecting to the error page if database is not connected --->
				<cfcatch type = "any">
					<cflocation url = "error.cfm" addToken = "no" />
				</cfcatch>
			</cftry>
		<cfelse>
			<cftry>
				<cfquery name = "addProduct">
					UPDATE CART
					SET CART.ITEMS = CART.ITEMS + <cfqueryparam value = "#arguments.items#" cfsqltype = "cf_sql_numeric" />
					WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
					AND CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
				</cfquery>
				<!--- redirecting to the error page if database is not connected --->
				<cfcatch type = "any">
					<cflocation url = "error.cfm" addToken = "no" />
				</cfcatch>
			</cftry>
		</cfif>

	</cffunction>


	<!--- fetching the cart detail of registered customer --->
	<cffunction name = "getCartOfRegisteredUser" access = "public" returntype = "query" hint = "getting the cart for registered user">
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "customer id to identify the customer" />
		<cftry>
			<cfquery name = "getCart">
				SELECT C.CUSTOMERID , C.PRODUCTWITHSELLERID , C.ITEMS ,PWS.PRICE, PWS.SHIPPINGPRICE ,PWS.IMAGEURL , S.SELLERNAME , P.PRODUCTNAME
				FROM CART AS C
				INNER JOIN PRODUCTSWITHSELLERS AS PWS
				ON PWS.PRODUCTWITHSELLERID = C.PRODUCTWITHSELLERID
				AND C.CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
				INNER JOIN SELLER AS S
				ON PWS.SELLERID = S.SELLERID
				INNER JOIN PRODUCT AS P
				ON P.PRODUCTID = PWS.PRODUCTID
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfreturn getCart />
	</cffunction>

	<!--- fetching the detail of registered customer --->
	<cffunction name = "getUserDetail" access = "public" returntype = "query" hint = "getting the detail of user">
		<cfargument name  = "customerID" required = "true" type = "numeric" hint = "detail of the customer" />

		<cftry>
			<cfquery name = "userDetail">
				SELECT FIRSTNAME , SECONDNAME, EMAILADDRESS
				FROM CUSTOMER
				WHERE CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_type" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any">
				<cflocation url = "error.cfm" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfreturn userDetail />
	</cffunction>

	<!--- fetching the payment detail of the customer --->
	<cffunction name = "getUserPaymentDetail" access = "public" returntype = "query" hint = "getting the detail of payment">
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "detail of customer payment" />
		<cftry>
			<cfquery name = "getPaymentDetail">
				SELECT CREDITCARDTYPE , NAMEONCREDITCARD , CREDITCARDNUMBER , CREDITCARDEXPIRATIONMONTH , CREDITCARDEXPIRATIONYEAR
				FROM PAYMENT
				WHERE CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any" >
				<cflocation url = "error" addToken = "no" />
			</cfcatch>
		</cftry>
		<cfreturn getPaymentDetail />
	</cffunction>

	<!--- removing the address --->
	<cffunction name = "removeAddress" access= "public" returntype = "void" hint = "removing the address of customer">
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "i'd of customer" />
		<cftry>
			<cfquery>
				DELETE CUSTOMERADDRESS
				WHERE CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any" >
				<cflocation url = "error" addToken = "no" />
			</cfcatch>
		</cftry>
	</cffunction >

	<!--- removing the payment detail  --->
	<cffunction name = "removePayment" access = "public" returntype = "void" hint = "removing the payment detail of the user">
		<cfargument name = "customerID" required = "true" type = "numeric" cfsqltype = "cf_sql_numeric" />
		<cftry>
			<cfquery>
				DELETE PAYMENT
				WHERE CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any" >
				<cflocation url = "error" addToken = "no" />
			</cfcatch>
		</cftry>
	</cffunction>

	<!--- removing the cart detail  --->
	<cffunction name = "removeCart" access = "public" returntype = "void" hint = "removing the cart after transction payment">
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "i'd of customer" />
		<cftry>
			<cfquery>
				DELETE CART
				WHERE CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
			<!--- redirecting to the error page if database is not connected --->
			<cfcatch type = "any" >
				<cflocation url = "error" addToken = "no" />
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>