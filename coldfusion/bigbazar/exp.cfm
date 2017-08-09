<!--- testing to show the data of categories and subcategories

<cfset resultCategories = application.productService.getCategoryByGroup() />


<cfoutput query = "resultCategories" group = "CATEGORY">
	<p>
		#resultCategories.CATEGORYID# .  #resultCategories.CATEGORY# ->
		<cfoutput>
			#resultCategories.SUBCATEGORY#
		</cfoutput>
	</p>
</cfoutput>
--->
<!--- product price and name
<cfset resultProductDetail = application.productService.getProductDetailBySubCategoryID(1) />

<cfoutput query = "resultProductDetail">
	<p>
		<img src = "#resultProductDetail.IMAGEURL#">
	</p>
	<p>
		#resultProductDetail.PRODUCTID# - #resultProductDetail.PRODUCTNAME# #resultProductDetail.PRICE#
	</p>
</cfoutput>
--->
<!---
<cfset resultProductDetail = application.productService.getProductDetailByProductWithSellerID(1) />

<cfoutput>
	<p>
		<img src = "#resultProductDetail.IMAGEURL#"/>
	</p>
	<p>
		#resultProductDetail.PRODUCTNAME# - #resultProductDetail.PRICE# - #resultProductDetail.INSTOCK#
	</p>
</cfoutput>

<!--- fetching the details of all the feature of product with a perticular seller --->
<cfset resultProductFeatures = application.productService.getProductFeatureByProductWithSellerID(1) />

<cfoutput query = "resultProductFeatures">
	<p>
		#resultProductFeatures.FEATURE# - #resultProductFeatures.FEATURENAME#
	</p>
</cfoutput>
--->
