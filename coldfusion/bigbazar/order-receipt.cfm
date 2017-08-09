
<cfif NOT structkeyExists(session,'totalCart') >
	<cflocation url="index.cfm" addToken="no" />
</cfif>


<cfset variables.getAddress = application.orderService.getAddress(#session.totalCart['cartCustomerId']#) />
<cfset variables.getOrderDetail = application.orderService.getOrderDetail(#session.totalCart['transactionId']#) />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Checkout | E-Shopper</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" >
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
								<li><a href="cart.html"><i class="fa fa-shopping-cart"></i> Cart</a></li>
								<li><a href="login.html"><i class="fa fa-lock"></i> Login</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->


	</header><!--/header-->

	<section id="cart_items">
		<div class="container">
			<div class="register-req">
				<p>Thank You for Shopping. Please check your bill</p>
			</div><!--/register-req-->

			<div class="shopper-informations">
				<div class="row">
				<cfset variables.index =1 />
				<cfoutput>
					<div class="col-sm-5">
						<div class="shopper-info">
							<p>Shipping Address</p>
							<span>#getAddress.CUSTOMERADDRESS[variables.index]#</span><br>
							<span>#getAddress.CUSTOMERCITY[variables.index]#</span><br>
							<span>#getAddress.CUSTOMERSTATE[variables.index]#</span><br>
							<span>#getAddress.CUSTOMERZIPCODE[variables.index]#</span>
						</div>
					</div>
					<cfif #getAddress.ADDRESSTYPEID[1]# NEQ 3>
						<cfset variables.index = 2 />
					</cfif>
					<div class="col-sm-5 clearfix">
						<div class="bill-to">
							<p>Billing Address</p>
							<span>#getAddress.CUSTOMERADDRESS[variables.index]#</span><br>
							<span>#getAddress.CUSTOMERCITY[variables.index]#</span><br>
							<span>#getAddress.CUSTOMERSTATE[variables.index]#</span><br>
							<span>#getAddress.CUSTOMERZIPCODE[variables.index]#</span>
						</div>
					</div>
				</div>
				</cfoutput>
			</div>
			<div class="review-payment">
				<h2>Your Orders ( Transaction :  )</h2>
			</div>

			<div class="table-responsive cart_info">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">Item</td>
							<td class="description"></td>
							<td class="price">Price</td>
							<td class="quantity">Quantity</td>
							<td class="price">Shipping</td>
							<td class="total">Total</td>
						</tr>
					</thead>
					<tbody>

						<cfoutput query = "variables.getOrderDetail">
								<tr>
									<td class="cart_product">
										<a  href=""><img class = "cart_images" src="#variables.getOrderDetail.IMAGEURL#" alt=""></a>
									</td>
									<td class="cart_description">
										<h4>#variables.getOrderDetail.PRODUCTNAME#</h4>
										<p><b>SELELR : #variables.getOrderDetail.SELLERNAME# </p>
									</td>
									<td class="cart_price">
										<p>#variables.getOrderDetail.PRICE# Rs.</p>
									</td>
									<td class="cart_quantity">
										<div class="cart_quantity_button">

											<input class="cart_quantity_input" type="text" name="quantity" value="#variables.getOrderDetail.ORDERITEMS#" autocomplete="off" size="2" readonly = "readonly" >

										</div>
									</td>
									<td class = "cart_price">
										<p>#variables.getOrderDetail.SHIPPINGPRICE# Rs.</p>
									</td>
									<td class="cart_total">
										<p class="cart_total_price"><span>#variables.getOrderDetail.ORDERTOTALCOST#</span> Rs.</p>
									</td>
								</tr>
						</cfoutput>
							<td colspan="4">&nbsp;</td>
							<td colspan="2">
								<table class="table table-condensed total-result">
									<tr>
										<td>Total Rupees</td>
										<td><span><cfoutput>#session.totalCart['cartTotalPrice']#</cfoutput> Rs.</span></td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</section> <!--/#cart_items-->

	<footer id="footer"><!--Footer-->

		<div class="footer-bottom">
			<div class="container">
				<div class="row">
					<p class="pull-left">Copyright © 2013 E-SHOPPER Inc. All rights reserved.</p>
					<p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
				</div>
			</div>
		</div>

	</footer><!--/Footer-->



    <script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>