<!---**
 * checkoutservices
 *
 * @author mindfire
 * @date 8/8/17
 **/--->
<cfcomponent>

	<cffunction name = "insertCustomerDetail" access = "public" returntype = "string" hint = "inserting the customer details" >
		<cfargument name = "firstName" required = "true" type = "string" hint = "first name of customer" />
		<cfargument name = "lastName" required ="true" type = "string" hint = "last name of customer" />
		<cfargument name = "email" required = "true" type = "string" hint = "email address of the customer" />

		<cfquery name = "customerID">
			INSERT INTO CUSTOMER
			(FIRSTNAME, SECONDNAME, EMAILADDRESS)
			VALUES
			(
				<cfqueryparam value = "#arguments.firstName#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.lastName#"  cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.email#"     cfsqltype = "cf_sql_string" />
			);
			SELECT SCOPE_IDENTITY() AS ID
		</cfquery>
		<cfreturn customerID.ID />
	</cffunction>

	<cffunction name = "insertCustomerAddress" access = "public" returntype = "void" hint = "adding customer address values">
		<cfargument name = "address" required = "true" type = "string" hint = "address of customer" />
		<cfargument name = "state" required = "true" type = "string" hint = "customer's state" />
		<cfargument name = "city" required = "true" type = "string" hint = "customer's city" />
		<cfargument name = "zip" required = "true" type = "string" hint = "customer's pin code">
		<cfargument name = "addressType" required  = "true" type = "numeric" hint = "type of address" />
		<cfargument name = "customerId" required  = "true" type = "numeric" hint = "customer's id" />

		<cfquery>
			INSERT INTO CUSTOMERADDRESS
			(CUSTOMERADDRESS,CUSTOMERCITY,CUSTOMERSTATE,CUSTOMERZIPCODE,ADDRESSTYPEID,CUSTOMERID)
			VALUES
			(
				<cfqueryparam value = "#arguments.address#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.city#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.state#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.zip#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.addressType#" cfsqltype = "cf_sql_numeric" /> ,
				<cfqueryparam value = "#arguments.customerId#" cfsqltype = "cf_sql_numeric" />
			)
		</cfquery>
	</cffunction>

	<cffunction name = "addPaymentOption" access = "public" returntype = "void" hint = "adding payment options">
		<cfargument name = "creditCardType" required = "true" type = "string" hint = "type of credit card" />
		<cfargument name = "nameOnCreditCard" required = "true" type = "string" hint = "name on credit card" />
		<cfargument name = "cardNumber" required = "true" type = "string" hint = "card number" />
		<cfargument name = "expirationMonth" required = "true" type = "string" hint = "expiration month of credit card" />
		<cfargument name = "expirationYear" required = "true" type = "string" hint = "expiration year of credit card" />
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "customer id" />

		<cfquery>
			INSERT INTO PAYMENT
			( CREDITCARDTYPE , NAMEONCREDITCARD , CREDITCARDNUMBER , CREDITCARDEXPIRATIONMONTH , CREDITCARDEXPIRATIONYEAR , CUSTOMERID )
			VALUES
			(
				<cfqueryparam value = "#arguments.creditCardType#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.nameOnCreditCard#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.cardNumber#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.expirationMonth#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.expirationYear#" cfsqltype = "cf_sql_string" /> ,
				<cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			)
		</cfquery>

	</cffunction>

	<cffunction name = "addTransaction" access = "public" returntype = "string" hint = "adding transaction for customer">
		<cfquery name = "getTransactionID">
			INSERT INTO CUSTOMERTRANSACTION
			( TOTALCOST , DATE  )
			VALUES
			(
				#session.totalCart['cartTotalPrice']# ,
				GETDATE()
			);
			SELECT SCOPE_IDENTITY() AS ID
		</cfquery>
		<cfreturn getTransactionID.ID />
	</cffunction>

	<cffunction name = "addOrders" access = "public" returntype = "void" hint = "adding orders for customer" >
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "seller id of the product" />
		<cfargument name = "transactionID" required = "true" type = "numeric" hint = "transaction id" />
		<cfargument name = "items" required = "true" type = "numeric" hint = "no of product in order" />
		<cfargument name  = "totalCost"  required = "true" type = "numeric" hint = "total cost of product"/>
		<cfargument name  = "customerID" required = "true" type = "numeric" hint = "customer's id" />

		<cfquery>
			INSERT INTO CUSTOMERORDERS
			( PRODUCTWITHSELLERID ,  CUSTOMERTRANSACTIONID , ORDERITEMS , ORDERTOTALCOST , CUSTOMERID )
			VALUES
			(
				<cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_numeric" /> ,
				<cfqueryparam value = "#arguments.transactionID#" cfsqltype = "cf_sql_numeric" /> ,
				<cfqueryparam value = "#arguments.items#" cfsqltype = "cf_sql_numeric" /> ,
				<cfqueryparam value = "#arguments.totalCost#" cfsqltype = "cf_sql_numeric" /> ,
				<cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			)
		</cfquery>
	</cffunction>

</cfcomponent>