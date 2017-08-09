<!---/**
 * order-receipt
 *
 * @author mindfire
 * @date 8/9/17
 **/ --->
<cfcomponent>
	<cffunction name = "getAddress" returntype = "query" access = "public" hint = "accessing the address of customer"  >
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "customer's id" />

		<cfquery name = "getAddress">
			SELECT ADDRESSTYPEID , CUSTOMERADDRESS , CUSTOMERSTATE , CUSTOMERCITY , CUSTOMERZIPCODE
			FROM CUSTOMERADDRESS
			WHERE CUSTOMERID = <cfqueryparam value = "#arguments.customerID#" cfsqltype="cf_sql_numeric" />
		</cfquery>

		<cfreturn getAddress />

	</cffunction>

	<cffunction name = "getOrderDetail" returnType = "query" access = "public" hint = "accessing the order details" >
		<cfargument name = "customerID" required = "true" type = "numeric" hint = "customer's id" />

		<cfquery name  = "getOrderDetail">
			SELECT P.PRODUCTNAME , PWS.IMAGEURL, PWS.PRICE , PWS.SHIPPINGPRICE  , O.ORDERITEMS , S.SELLERNAME , O.ORDERTOTALCOST
			FROM PRODUCTSWITHSELLERS AS PWS
			INNER JOIN CUSTOMERORDERS AS O
			ON PWS.PRODUCTWITHSELLERID = O.PRODUCTWITHSELLERID
			AND O.CUSTOMERTRANSACTIONID = <cfqueryparam value = "#arguments.customerID#" cfsqltype = "cf_sql_numeric" />
			INNER JOIN SELLER AS S
			ON S.SELLERID = PWS.SELLERID
			INNER JOIN PRODUCT AS P
			ON P.PRODUCTID = PWS.PRODUCTID
		</cfquery>

		<cfreturn getOrderDetail />
	</cffunction>

	<cffunction name = "getTransactionNumber" returntype = "string" access = "public" hint = "accessing the transaction number">
		<cfargument name = "transactionId" required = "true" type = "numeric" hint = "transaction payment id" />

		<cfquery name = "getTransaction">
			SELECT TRANSACTIONNUMBER
			FROM CUSTOMERTRANSACTION
			WHERE CUSTOMERTRANSACTIONID = <cfqueryparam value = "arguments.transactionId" cfsqltype = "cf_sql_numeric" />
		</cfquery>

		<cfreturn getTransaction.TRANSACTIONNUMBER />
	</cffunction>
</cfcomponent>