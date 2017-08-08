<!---
 * Application
 *
 * @author mindfire
 * @date 7/21/17
 --->
<cfcomponent>

	<!--- fetching the name of categories and name of subcategories --->
	<cffunction name = "getCategoryByGroup" access = "public" returntype = "query" hint = "returning all the categories by group" >
		<cfquery name = "local.resultCategories">
			SELECT CAT.CATEGORYID AS CATEGORYID, CAT.CATEGORYNAME AS CATEGORY , SUB.SUBCATEGORYNAME AS SUBCATEGORY,SUB.SUBCATEGORYID AS SUBCATEGORYID
			FROM CATEGORY CAT INNER JOIN SUBCATEGORY SUB
			ON CAT.CATEGORYID = SUB.CATEGORYID
			ORDER BY CATEGORY
		</cfquery>
		<cfreturn local.resultCategories />
	</cffunction >

	<!--- fetching the product detail by SUBCATEGORYID  --->
	<cffunction name = "getProductDetailBySubCategoryID" access = "public" returntype = "query" hint = "fetching the product detail" >
		<cfargument name="subCategoryID" required = "true" type = "numeric" hint = "username argument" />
		<cfquery name = "local.resultProductDetail">
			SELECT P.PRODUCTID PRODUCTID, P.PRODUCTNAME PRODUCTNAME, PWS.PRICE PRICE, PWS.IMAGEURL IMAGEURL , PWS.PRODUCTWITHSELLERID PRODUCTWITHSELLERID
			FROM PRODUCT P INNER JOIN PRODUCTSWITHSELLERS PWS
			ON P.PRODUCTID = PWS.PRODUCTID
			AND P.SUBCATEGORYID = <cfqueryparam value="#arguments.subCategoryID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn local.resultProductDetail />
	</cffunction>

	<!--- fetching the product detail by  PRODUCTWITHSELLERID--->
	<cffunction name = "getProductDetailByProductWithSellerID" access = "public" returntype = "query" hint = "fetching the product detail" >
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "productwithsellerid" />
		<cfquery name = "local.resultProductDetail" >
			SELECT P.PRODUCTNAME PRODUCTNAME , PWS.PRICE PRICE, PWS.IMAGEURL IMAGEURL, PWS.INSTOCK INSTOCK ,
			 P.PRODUCT_DESCRIPTION DESCRIPTION , PWS.PRODUCTWITHSELLERID PRODUCTWITHSELLERID , PWS.SHIPPINGPRICE SHIPPINGPRICE , S.SELLERNAME SELLERNAME
			FROM PRODUCT P INNER JOIN PRODUCTSWITHSELLERS PWS
			ON P.PRODUCTID = PWS.PRODUCTID AND PWS.PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_integer" />
			INNER JOIN SELLER S ON S.SELLERID = PWS.SELLERID
		</cfquery>
		<cfreturn local.resultProductDetail />
	</cffunction>

	<!--- fetching the features of product a seller have by given PRODDUCTWITHSELLERID --->
	<cffunction name = "getProductFeatureByProductWithSellerID" access = "public" returntype = "query" hint = "fetching the product features" >
		<cfargument name = "productWithSellerID" required = "true" type = "numeric" hint = "productwithsellerid" />
		<cfquery name = "local.resultProductFeatures" >
			SELECT O.OPTIONNAME FEATURE,OV.OPTIONVALUENAME FEATURENAME, PF.PRODUCTID
			FROM PRODUCTFEATURES PF INNER JOIN OPTIONSVALUES OV
			ON OV.OPTIONVALUEID = PF.OPTIONVALUEID AND PRODUCTWITHSELLERID = <cfqueryparam value = "#arguments.productWithSellerID#" cfsqltype = "cf_sql_integer" />
			INNER JOIN OPTIONS O ON O.OPTIONID = OV.OPTIONID
		</cfquery>
		<cfreturn local.resultProductFeatures />
	</cffunction>
</cfcomponent>