
<cfset variables.emailError = "" />
<cfset variables.passwordError = "" />
<cfset variables.isValid = true />
<cfif structKeyExists(form,'login_submit')>
	<cfif Trim(form.login_email) eq "" >
		<cfset variables.isValid = false />
		<cfset variables.emailError = "Please! enter a valid email i'd"/>
	</cfif>
	<cfif Trim(form.login_password) eq "">
		<cfset variables.isValid = false />
		<cfset variables.passwordError = "Please! enter a valid password" />
	</cfif>
	<cfif variables.isValid >
		<cfset variables.isValid = application.userService.doLogin(#form.login_email#, #form.login_password#) />
		<cfif NOT variables.isValid>
			<cfset variables.passwordError = "Email or Password does not exist" />
		<cfelse>
			<cflocation url = "index.cfm" addToken = "no" />
		</cfif>
	</cfif>
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Home | E-Shopper</title>
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
	<script src = "js/check-out.js"></script>

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
								<li><a href="index.html">Home</a></li>
								<li><a href="cart.cfm"><i class="fa fa-shopping-cart"></i> Cart</a></li>
								<li><a href="login.cfm" class="active"><i class="fa fa-lock"></i> Login</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->
	</header><!--/header-->

	<section id="form"><!--form-->
		<div class="container">
			<div class="row">

				<div class="col-sm-4 col-sm-offset-2">
					<div class="login-form"><!--login form-->
						<h2>Login to your account</h2>
						<cfform onsubmit = "return submit_login();" >
							<cfoutput>
								<span class = "error" id = "login_email_error">#variables.emailError#</span>
								<cfinput type="text" name = "login_email" id = "login_email" placeholder="Email" />
								<span class = "error" id = "login_password_error">#variables.passwordError#</span>
								<cfinput type="password" placeholder = "Password" name = "login_password" id = "login_password" />
								<cfinput type="submit" value = "Login" name = "login_submit" class="btn btn-primary" />
							</cfoutput>
						</cfform>
					</div><!--/login form-->
				</div>
				<div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-sm-4 padding">

						<p><a href="registration.cfm">New User ? ( Registration )</a></p>
						<p><a href="checkout.cfm">Continue as guest user ?</a></p>

				</div>
			</div>
		</div>
	</section><!--/form-->


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

</body>
</html>