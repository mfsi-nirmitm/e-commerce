<!---/**
 * userservices
 *
 * @author mindfire
 * @date 8/9/17
 **/--->
<cfcomponent extends="checkoutservices" >

	<cffunction name = "registerUser" access = "public" returntype="numeric" hint = "adding user detail for registration">
		<cfargument name = "firstName" required = "true" type = "string" hint = "first name of customer" />
		<cfargument name = "lastName" required = "true" type = "string" hint = "last name of the customer" />
		<cfargument name = "password" required = "true" type = "string"  hint = "password for customer" />
		<cfargument name = "email" required = "true" type = "string"  hint = "email of customer for registration" />
		<cfargument name = "customerTypeId" required = "true" type = "numeric" hint = "type of customer" />

		<cfset local.customerID=#Int(Super.insertCustomerDetail(#arguments.firstName#,#arguments.lastName#,#arguments.email#,#arguments.customerTypeId#))# />

		<cfquery>
			INSERT INTO CUSTOMERLOGIN
			( PASSWORD , CUSTOMERID )
			VALUES
			(
				<cfqueryparam value = "#arguments.password#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#local.customerID#" cfsqltype = "cf_sql_numeric" />
			)
		</cfquery>
		<cfreturn local.customerID />
	</cffunction>

	<cffunction name = "haveEmail" access = "public" returntype = "boolean" hint = "checking email already there is database or not ">
		<cfargument name = "email" required = "true" type = "string" hint = "email of customer" />
		<cfargument name = "customerTypeId" required = "true" type = "numeric" hint = "type of customer" />

		<cfset local.isEmailExist = false />
		<cfquery name = "getMail">
			SELECT *
			FROM CUSTOMER
			WHERE EMAILADDRESS = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_string" />
			AND CUSTOMERTYPEID = <cfqueryparam value = "#arguments.customerTypeId#" cfsqltype = "cf_sql_numeric" />
		</cfquery>
		<cfif getMail.RecordCount GT 0>
			<cfset local.isEmailExist = true />
		</cfif>

		<cfreturn local.isEmailExist />
	</cffunction>

	<cffunction name = "doLogin" access = "public" returntype = "boolean" hint = "logging the custoer on valid input" >
		<cfargument name = "loginEmail" required = "true" type = "string" hint = "email of customer for login" />
		<cfargument name = "password" required = "true" type = "string" hint = "password of customer for login" />

		<cfset local.isValid = true />

		<cfquery name = "getLogin">
			SELECT CUS.CUSTOMERID , CUS.FIRSTNAME
			FROM CUSTOMER AS CUS
			INNER JOIN CUSTOMERLOGIN AS CUSLOG
			ON CUS.CUSTOMERID = CUSLOG.CUSTOMERID
			AND CUS.EMAILADDRESS = <cfqueryparam  value = "#arguments.loginEmail#" cfsqltype = "cf_sql_string" />
			AND CUSLOG.PASSWORD = <cfqueryparam value = "#arguments.password#" cfsqltype = "cf_sql_string" />
		</cfquery>
		<cfif getLogin.RecordCount eq 0>
			<cfset local.isValid = false />
		<cfelse>
			<cfset session.loggedIn['customerID'] = #getLogin.CUSTOMERID# />
			<cfset session.loggedIn['customerName'] = #getLogin.FIRSTNAME# />
		</cfif>

		<cfreturn local.isValid />
	</cffunction>

	<cffunction name = "addCartForRegisteredUser" access = "public" returntype = "void" hint = "adding the cart for registered user">
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "productwithseller id to identify the product with seller" />
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "costumer's i'd" />
		<cfargument name = "items" required = "true" type = "numeric" hint = "no of items" />

		<cfquery name = "isProductInCart">
			SELECT *
			FROM CART
			WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
			AND CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
		</cfquery>
		<cfif isProductInCart.RecordCount EQ 0 >
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
		<cfelse>
			<cfquery name = "addProduct">
				UPDATE CART
				SET CART.ITEMS = CART.ITEMS + <cfqueryparam value = "#arguments.items#" cfsqltype = "cf_sql_numeric" />
				WHERE PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" />
				AND CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			</cfquery>
		</cfif>

	</cffunction>
</cfcomponent>