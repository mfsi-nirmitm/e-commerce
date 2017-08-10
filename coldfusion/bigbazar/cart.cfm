<cfajaxproxy cfc="coldfusion.bigbazar.components.cartservices" jsclassname="jsClass">

<cfset variables.cartTotalPrice = 0 />
<cfset variables.cartarray = ArrayNew (1) />

<cfif structKeyExists(session,'loggedIn')>
	<cfset variables.getCartLoggedInUser = application.userService.getCartOfRegisteredUser(#session.loggedIn['customerID']#) />
	<cfoutput query="variables.getCartLoggedInUser">
		<cfset variables.cartbasket = StructNew() />
		<cfset variables.cartbasket['productwithsellerid'] = #variables.getCartLoggedInUser.PRODUCTWITHSELLERID# />
		<cfset variables.cartbasket['items'] = #variables.getCartLoggedInUser.ITEMS# />
		<cfset variables.cartbasket['productprice'] = #variables.getCartLoggedInUser.PRICE# />
		<cfset variables.cartbasket['productname'] = #variables.getCartLoggedInUser.PRODUCTNAME# />
		<cfset variables.cartbasket['sellername'] = #variables.getCartLoggedInUser.SELLERNAME# />
		<cfset variables.cartbasket['shippingprice'] = #variables.getCartLoggedInUser.SHIPPINGPRICE# />
		<cfset variables.cartbasket['imageurl'] = #variables.getCartLoggedInUser.IMAGEURL# />
		<cfset ArrayAppend(variables.cartarray, variables.cartbasket) />
	</cfoutput>
<cfelseif structkeyExists (session , 'cart') >
	<cfloop array = "#session.cart#" index = "thing">
		<cfset variables.cartbasket = StructNew() />
		<cfset variables.cartbasket['productwithsellerid'] = #thing['productwithsellerid']# />
		<cfset variables.cartbasket['items'] = #thing['items']#  />
		<cfset variables.cartbasket['productprice'] = #thing['productprice']# />
		<cfset variables.cartbasket['productname'] = #thing['productname']# />
		<cfset variables.cartbasket['sellername'] = #thing['sellername']# />
		<cfset variables.cartbasket['shippingprice'] = #thing['shippingprice']#  />
		<cfset variables.cartbasket['imageurl'] = #thing['imageurl']# />
		<cfset ArrayAppend(variables.cartarray, variables.cartbasket) />
	</cfloop>
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
	<script src="js/coldfusion.js"></script>

</head><!--/head-->

<body>
	<header id="header"><!--header-->
		<div class="header_top"><!--header_top-->
			<div class="container">
				<div class="row">
					<div class="col-sm-6">
						<div class="contactinfo">
							<ul class="nav nav-pills">
								<li><a href=""><i class="fa fa-phone"></i> +2 95 01 88 821</a></li>
								<li><a href=""><i class="fa fa-envelope"></i> info@domain.com</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="social-icons pull-right">
							<ul class="nav navbar-nav">
								<li><a href=""><i class="fa fa-facebook"></i></a></li>
								<li><a href=""><i class="fa fa-twitter"></i></a></li>
								<li><a href=""><i class="fa fa-linkedin"></i></a></li>
								<li><a href=""><i class="fa fa-dribbble"></i></a></li>
								<li><a href=""><i class="fa fa-google-plus"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header_top-->

		<div class="header-middle"><!--header-middle-->
			<div class="container">
				<div class="row">
					<div class="col-sm-4">
						<div class="logo pull-left">
							<a href="index.cfm"><img src="images/home/logo.png" alt="" /></a>
						</div>
					</div>
					<div class="col-sm-8">
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<li><a href="index.cfm">Home</a></li>
								<li><a href="cart.cfm" class="active"><i class="fa fa-shopping-cart"></i> Cart</a></li>
								<cfif structKeyExists(session,'loggedIn') >
									<li><a>Hello <cfoutput>#session.loggedIn['customerName']# !</cfoutput></a></li>
								<cfelse>
									<li><a href="login.cfm"><i class="fa fa-lock"></i> Login</a></li>
								</cfif>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->
	</header><!--/header-->

	<section id="cart_items">
		<div class="container head">
			<div class="table-responsive cart_info">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">Item</td>
							<td class="description"></td>
							<td class="price">Price of 1 Item</td>
							<td class="quantity">Quantity</td>
							<td class="shippingcost">Shipping(1 Item)</td>
							<td class="total">Total</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#variables.cartarray#" index="thing">
							<cfoutput>
								<cfset variables.tableID = "table" & "#thing['productwithsellerid']#" />
								<tr id = "#variables.tableID#">
									<td class="cart_product">
										<a href=""><img class="cart_images" src="#thing['imageurl']#" ></a>
									</td>
									<td class="cart_description">
										<h4>#thing['productname']#</h4>
										<p><b>SELELR : </b>#thing['sellername']#</p>
									</td>
									<td class="cart_price">
										<p>#thing['productprice']# Rs.</p>
									</td>
									<td class="cart_quantity">
										<div class="cart_quantity_button">
											<cfset variables.subButtonID = "subButton" & "#thing['productwithsellerid']#" />
											<cfif #thing['items']# gt 1>
												<button class="cart_quantity_down" id = "#variables.subButtonID#" onclick = "decrementItem(#thing['productwithsellerid']#)" > - </button>
											<cfelse>
												<button class="cart_quantity_down" id = "#variables.subButtonID#" onclick = "decrementItem(#thing['productwithsellerid']#)" disabled> - </button>
											</cfif>

											<input id="#thing['productwithsellerid']#" class="cart_quantity_input" type="text" name="quantity" value="#thing['items']#" autocomplete="off" size="2" readonly="readonly">

											<cfset variables.addButtonID = "addButton" & "#thing['productwithsellerid']#" />
											<button class="cart_quantity_up" id = "#variables.addButtonID#" onclick = "addItem(#thing['productwithsellerid']#);"> + </button>

										</div>
									</td>
									<td class="cart_price">
										<p>#thing['shippingprice']# Rs.</p>
									</td>
									<cfset variables.totalID = "total" & "#thing['productwithsellerid']#" />
									<cfset variables.totalPrice = "#thing['items']#" * (#thing['productprice']# + #thing['shippingprice']#) />
									<cfset variables.cartTotalPrice = #variables.cartTotalPrice# + #variables.totalPrice# />
									<td class="cart_total"  >
										<p class="cart_total_price" id = "#variables.totalID#"><span>#variables.totalPrice#</span> Rs.</p>
									</td>
									<td class="cart_delete">
										<button class="cart_quantity_delete" onclick = "removeProduct(#thing['productwithsellerid']#);" ><i class="fa fa-times"></i></button>
									</td>
								</tr>
							</cfoutput>
						</cfloop>
					</tbody>
				</table>
			</div>
		</div>
	</section> <!--/#cart_items-->

	<section id="do_action">
		<div class="container">

			<div class="row">
				<div class="col-sm-6">

				</div>
				<div class="col-sm-6">
					<div class="total_area">
						<ul>
							<li>Total Rupees <span id = "totalcartprice"><cfoutput>#variables.cartTotalPrice# </cfoutput></span></li>
						</ul>
							<a class="btn btn-default update" href="index.cfm"> < Back to Shopping</a>
							<a class="btn btn-default check_out" href="checkout.cfm">Check Out</a>
					</div>
				</div>
			</div>
		</div>
	</section><!--/#do_action-->

	<footer id="footer"><!--Footer-->

		<div class="footer-bottom">
			<div class="container">
				<div class="row">
					<p class="pull-left">Copyright © 2013 E-SHOPPER Inc. All rights reserved.</p>
				</div>
			</div>
		</div>

	</footer><!--/Footer-->

</body>
</html>