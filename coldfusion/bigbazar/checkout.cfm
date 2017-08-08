<cfset variables.cartTotalPrice = 0 />
<cfset variables.cartarray = ArrayNew (1) />
<cfif structkeyExists (session , 'cart') >
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


<cfparam name = "form.billing_first_name" default = "" >
<cfparam name = "form.billing_last_name" default = "" >
<cfparam name = "form.billing_email" default = "" >
<cfparam name = "form.billing_address" default = "">
<cfparam name = "form.billing_state" default = "">
<cfparam name = "form.billing_city" default = "">
<cfparam name = "form.billing_zip" default = "">
<cfparam name = "form.shipping_address" default = "">
<cfparam name = "form.shipping_state" default = "">
<cfparam name = "form.shipping_city" default = "">
<cfparam name = "form.shipping_zip" default = "">
<cfparam name = "form.card" default = "">
<cfparam name = "form.credit_card_name" default = "">
<cfparam name = "form.credit_card_number" default  = "">
<cfparam name = "form.card_expiration_month" default = "">
<cfparam name = "form.card_expiration_year" default = "">
<cfparam name = "form.card_security_code" default = "">
<cfparam name = "form.same_address" default = "off">

<cfset variables.customerId = 0 />

<cfset variables.billingFirstNameError = "" />
<cfset variables.billingEmailError = "" />
<cfset variables.billingAddressError = "" />
<cfset variables.billingStateError = "" />
<cfset variables.billingCityError = "" />
<cfset variables.billingZipError = "" />
<cfset variables.shippingAddressError = "" />
<cfset variables.shippingStateError= "" />
<cfset variables.shippingCityError = "" />
<cfset variables.shippingZipError = "" />
<cfset variables.cardError = "" />
<cfset variables.creditCardNameError = "" />
<cfset variables.creditCardNumberError = "" />
<cfset variables.creditExpirationMonthError = "" />
<cfset variables.creditExpirationYearError = "" />
<cfset variables.cardSecurityCodeError = "" />

<cfset variables.isFormValid = true />

<cfif structKeyExists(form,'submit')>
	<cfif Trim(form.billing_first_name) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.billingFirstNameError = "Please! enter this field" />
	</cfif>

	<cfif Trim(form.billing_email) EQ "" >
		<cfset variables.isFormValid = false />
		<cfset variables.billingEmailError = "Please! enter this field" />
	<cfelseif NOT IsValid('email', Trim(form.billing_email)) >
		<cfset variables.isFormValid = false />
		<cfset variables.billingEmailError = "Please! enter a valid email " />
	</cfif>

	<cfif Trim(form.billing_address) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.billingAddressError = "Please! enter this field" />
	</cfif>

	<cfif Trim(form.billing_state) EQ "">
		<cfset variables.isFormValid =  false />
		<cfset variables.billingStateError = "Please! enter this field" />
	</cfif>

	<cfif Trim(form.billing_city) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.billingCityError = "Please! enter this field" />
	</cfif>

	<cfif Trim(form.billing_zip) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.billingZipError = "Please! enter this field">
	<cfelseif NOT IsValid('regex',Trim(form.billing_zip),"^[1-9](\d){5}$")>
		<cfset variables.isFormValid = false />
		<cfset variables.billingZipError = "Please! enter a valid zip code of 6 digits" />
	</cfif>

	<cfif form.same_address NEQ 'on'>

		<cfif Trim(form.shipping_address) EQ "">
			<cfset variables.isFormValid = false />
			<cfset variables.shippingAddressError = "Please! enter this field" />
		</cfif>

		<cfif Trim(form.shipping_state) EQ "">
			<cfset variables.isFormValid = false />
			<cfset variables.shippingStateError = "Please! enter this field" />
		</cfif>

		<cfif Trim(form.shipping_city) EQ "">
			<cfset variables.isFormValid = false />
			<cfset variables.shippingCityError = "Please! enter this field" />
		</cfif>

		<cfif Trim(form.shipping_zip) EQ "" >
			<cfset variables.isFormValid = false />
			<cfset variables.shippingZipError = "Please! enter this field" />
		<cfelseif NOT IsValid('regex',Trim(form.billing_zip),"^[1-9](\d){5}$")>
			<cfset variables.isFormValid = false />
			<cfset variables.shippingZipError = "Please! enter a valid zip code of 6 digits" />
		</cfif>
	</cfif>

	<cfif Trim(form.card) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.cardError = "Please! enter this field">
	</cfif>

	<cfif Trim(form.credit_card_name) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.creditCardNameError = "Please! enter this field" />
	</cfif>

	<cfif Trim(form.credit_card_number) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.creditCardNumberError = "Please! enter this field">
	<cfelseif NOT IsValid('regex',Trim(form.credit_card_number),'^[1-9](\d){11}$')>
		<cfset variables.isFormValid = false />
		<cfset variables.creditCardNumberError = "Please! enter a valid card number of 12 digits" />
	</cfif>

	<cfif Trim(form.card_expiration_month) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.creditExpirationMonthError ="Please! enter this field" />
	</cfif>

	<cfif Trim(form.card_expiration_year) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.creditExpirationYearError = "Please! enter this field" />
	</cfif>

	<cfif Trim(form.card_security_code) EQ "">
		<cfset variables.isFormValid = false />
		<cfset variables.cardSecurityCodeError = "Please! enter this field" />
	<cfelseif NOT IsValid('regex',Trim(form.card_security_code),'^[1-9](\d){2}$')>
		<cfset variables.isFormValid = false />
		<cfset variables.cardSecurityCodeError = "Please! enter a valid 3 digit security code" />
	</cfif>

	<cfif variables.isFormValid>
		<cfset variables.customerId = #Int(application.checkoutService.insertCustomerDetail(Trim(form.billing_first_name),Trim(form.billing_last_name),Trim(form.billing_email)))# />
		<cfset session.totalCart['cartCustomerId'] = #variables.customerId# />
		<cfif form.same_address EQ 'on'>
			<cfset application.checkoutService.insertCustomerAddress(Trim(form.billing_address),Trim(form.billing_state),Trim(form.billing_city),Trim(form.billing_zip),3,variables.customerId) />
		<cfelse>
			<cfset application.checkoutService.insertCustomerAddress(Trim(form.shipping_address),Trim(form.shipping_state),Trim(form.shipping_city),Trim(form.shipping_zip),1,variables.customerId) />
			<cfset application.checkoutService.insertCustomerAddress(Trim(form.billing_address),Trim(form.billing_state),Trim(form.billing_city),Trim(form.billing_zip),2,variables.customerId) />
		</cfif>
		<cfset application.checkoutService.addPaymentOption(Trim(form.card),Trim(form.credit_card_name),Trim(form.credit_card_number),Trim(form.card_expiration_month),Trim(form.card_expiration_year),variables.customerId) />


	</cfif>
</cfif>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Checkout | E-Shopper</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
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
							<a href="index.html"><img src="images/home/logo.png" alt="" /></a>
						</div>
						<div class="btn-group pull-right">
							<div class="btn-group">
								<button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
									USA
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a href="">Canada</a></li>
									<li><a href="">UK</a></li>
								</ul>
							</div>

							<div class="btn-group">
								<button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
									DOLLAR
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a href="">Canadian Dollar</a></li>
									<li><a href="">Pound</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-sm-8">
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<li><a href=""><i class="fa fa-user"></i> Account</a></li>
								<li><a href=""><i class="fa fa-star"></i> Wishlist</a></li>
								<li><a href="checkout.html" class="active"><i class="fa fa-crosshairs"></i> Checkout</a></li>
								<li><a href="cart.html"><i class="fa fa-shopping-cart"></i> Cart</a></li>
								<li><a href="login.html"><i class="fa fa-lock"></i> Login</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->

		<div class="header-bottom"><!--header-bottom-->
			<div class="container">
				<div class="row">
					<div class="col-sm-9">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>
						<div class="mainmenu pull-left">
							<ul class="nav navbar-nav collapse navbar-collapse">
								<li><a href="index.html">Home</a></li>
								<li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="shop.html">Products</a></li>
										<li><a href="product-details.html">Product Details</a></li>
										<li><a href="checkout.html" class="active">Checkout</a></li>
										<li><a href="cart.html">Cart</a></li>
										<li><a href="login.html">Login</a></li>
                                    </ul>
                                </li>
								<li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="blog.html">Blog List</a></li>
										<li><a href="blog-single.html">Blog Single</a></li>
                                    </ul>
                                </li>
								<li><a href="404.html">404</a></li>
								<li><a href="contact-us.html">Contact</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="search_box pull-right">
							<input type="text" placeholder="Search"/>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-bottom-->
	</header><!--/header-->

	<section id="cart_items">
		<div class="container">

			<div class="review-payment">
				<h2>Review & Payment</h2>
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
						<cfloop array="#variables.cartarray#" index="thing">
							<cfoutput>
								<tr>
									<td class="cart_product">
										<a  href=""><img class = "cart_images" src="#thing['imageurl']#" alt=""></a>
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

											<input class="cart_quantity_input" type="text" name="quantity" value="#thing['items']#" autocomplete="off" size="2" readonly = "readonly" >

										</div>
									</td>
									<td class = "cart_price">
										<p>#thing['shippingprice']# Rs.</p>
									</td>
									<cfset variables.totalPrice = "#thing['items']#" * (#thing['productprice']# + #thing['shippingprice']#) />
									<cfset variables.cartTotalPrice = #variables.cartTotalPrice# + #variables.totalPrice# />
									<cfset session.totalCart['cartTotalPrice'] = #variables.cartTotalPrice# />
									<td class="cart_total">
										<p class="cart_total_price"><span>#variables.totalPrice#</span> Rs.</p>
									</td>
								</tr>
							</cfoutput>
						</cfloop>
						<tr>
							<td colspan="4">&nbsp;</td>
							<td colspan="2">
								<table class="table table-condensed total-result">
									<tr>
										<td>Total</td>
										<td><span><cfoutput>#variables.cartTotalPrice#</cfoutput> Rs.</span></td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="shopper-informations">
				<cfform onsubmit = "return submit_form();">
				<cfoutput>
				<div class="row">
					<div class="col-sm-4">
						<div class="shopper-info">
							<p>Billing Address</p>
								<cfinput type = "hidden" name = "cartTotalPrice" value = "#variables.cartTotalPrice#" />
								<span class="error" id = "billing_first_name_error">#variables.billingFirstNameError#</span>
								<cfinput type="text" placeholder="First Name" value = "" name = "billing_first_name" id = "billing_first_name">
								<cfinput type="text" placeholder="Last Name" value = "" name = "billing_last_name" id = "billing_last_name">
								<span class="error" id = "billing_email_error">#variables.billingEmailError#</span>
								<cfinput type="text" placeholder="Email" value = "" name = "billing_email" id = "billing_email">
								<span class="error" id = "billing_address_error">#variables.billingAddressError#</span>
								<cfinput type="text" placeholder="Address" value = "" name = "billing_address" id = "billing_address">
								<span class="error" id = "billing_state_error">#variables.billingStateError#</span>
								<cfinput type="text" placeholder="State" value = "" name = "billing_state" id = "billing_state">
								<span class="error" id = "billing_city_error">#variables.billingCityError#</span>
								<cfinput type="text" placeholder="City" value = "" name = "billing_city" id = "billing_city">
								<span class="error" id = "billing_zip_error">#variables.billingZipError#</span>
								<cfinput type="text" placeholder="zip" value = "" name = "billing_zip" maxlength="6" id = "billing_zip">


						</div>
					</div>
					<div class="col-sm-4 clearfix">
						<div class="bill-to">
							<p>Shipping Address</p>
								<label><cfinput type="checkbox" name = "same_address" id = "same_address" > Same address as billing address</label>
								<div id = "bill_add">
									<span class="error" id = "shipping_address_error">#variables.shippingAddressError#</span>
									<cfinput type="text" placeholder="Shipping Address" value = "" name = "shipping_address" id = "shipping_address">
									<span class="error" id = "shipping_state_error">#variables.shippingStateError#</span>
									<cfinput type="text" placeholder="State" value = "" name = "shipping_state" id = "shipping_state">
									<span class="error" id = "shipping_city_error">#variables.shippingCityError#</span>
									<cfinput type="text" placeholder="City" value = "" name = "shipping_city" id = "shipping_city">
									<span class="error" id = "shipping_zip_error">#variables.shippingZipError#</span>
									<cfinput type="text" placeholder="zip" value = "" name = "shipping_zip" maxlength="6" id = "shipping_zip">
								</div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class = "payment-to">
							<p>Payment Details</p>
							<span class="error" id = "card_error">#variables.cardError #</span>

								<cfselect name = "card" id = "card">
									<option value = "" >--- Payment Card Type ---</option>
									<option value = "visa">VISA</option>
									<option value = "master_card">MASTER CARD</option>
									<option value = "rupay">RUPAY</option>
								</cfselect>
								<span class="error" id = "credit_card_name_error" >#variables.creditCardNameError#</span>
								<cfinput type = "text"  placeholder = "Name on Credit Card" value = "" name = "credit_card_name" id = "credit_card_name">
								<span class="error" id = "credit_card_number_error">#variables.creditCardNumberError#</span>
								<cfinput type = "text" placeholder = "Credit Card Number" value = "" name = "credit_card_number" maxlength="12" id = "credit_card_number">
								<span class="error" id = "card_expiration_month_error">#variables.creditExpirationMonthError#</span>
								<cfselect name = "card_expiration_month" id = "card_expiration_month" >
									<option value = "" >--- Credit Card Expiration Month ---</option>
									<option value = "1" >1</option>
									<option value = "2" >2</option>
									<option value = "3" >3</option>
									<option value = "4" >4</option>
									<option value = "5" >5</option>
									<option value = "6" >6</option>
									<option value = "7" >7</option>
									<option value = "8" >8</option>
									<option value = "9" >9</option>
									<option value = "10" >10</option>
									<option value = "11" >11</option>
									<option value = "12" >12</option>
								</cfselect>
								<span class="error" id = "card_expiration_year_error">#variables.creditExpirationYearError#</span>
								<cfselect name = "card_expiration_year" id = "card_expiration_year" >
									<option value = "">--- Credit Card Expiration Year ---</option>
									<option value = "2017">2017</option>
									<option value = "2018">2018</option>
									<option value = "2019">2019</option>
									<option value = "2020">2020</option>
									<option value = "2021">2021</option>
									<option value = "2022">2022</option>
									<option value = "2023">2023</option>
									<option value = "2024">2024</option>
									<option value = "2025">2025</option>
								</cfselect>
								<span class="error" id = "card_security_code_error">#variables.cardSecurityCodeError#</span>
								<cfinput type = "text" placeholder = "Security Code" value = "" name = "card_security_code" maxlength = "3" id = "card_security_code">

								<cfinput type = "submit"  class="btn btn-primary" value = "Continue Payment" name = "submit" id = "submit">

						</div>
					</div>
				</div>
				</cfoutput>
				</cfform>
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
	<script src="js/check-out.js"></script>
</body>
</html>