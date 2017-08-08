/*
Page functionality : javascript validation
Date - 17-jul-2017

*/
function hasValue(id,name)
{
	var value = $(id).val().trim();
	var error_id = id+"_error";
	if(value === "" || value === null || value === undefined)
	{
		$(error_id).text("Please! enter "+name);
		$(id).css("background-color","#FFE4E1");
		return false;
	}
	else
	{
		$(error_id).text("");
		return true;
	}
}
$(document).ready(function(){
	$("input").focusin(function(){
		$(this).css({"background-color" : "#FFFFF0", "color" : "#000000"});
	}).focusout(function(){
		$(this).css({"background-color" : "#FFFFFF", "color" : "#000000"});
	});
	$("#username").focusout(function(){
		if(!hasValue("#username","Username")) username_valid = false;
		else username_valid = true;
	});
	$("#login_password").focusout(function(){
		if(!hasValue("#login_password","Password")) password_valid = false;
		else password_valid = true;
	});
	$("#email").focusout(function(){
		var value = $(this).val().trim();
		if(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value))
		{
			email_valid =true;
			$("#email_error").text("");
		}
		else
		{ 
			email_valid = false;
			$("#email_error").text("Please! enter a valid email");
			$(this).css("background-color","#FFE4E1");
		}
	});
	$("#password").focusout(function(){
		var value = $(this).val();
		if(/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[$@!%*?&])[A-Za-z\d@$!%*?&\s]{4,}$/.test(value) )
		{ 
			password_valid = true;
			$("#password_error").text("");
		}
		else{
			password_valid = false;
			$("#password_error").text("Password length should be minimum 4 and atleat 1 small letter , 1 upper letter , 1 digit and 1 special character _!@$%");
			$(this).css("background-color","#FFE4E1");
		}
		var cnf_pass = $("#confirm_password").val();
		if(value !== cnf_pass && cnf_pass!== "")
		{
			confirm_password_valid = false;
			$("#confirm_password_error").text("Password should be same ");
			$(this).css("background-color","#FFE4E1");
		}
	});
	$("#confirm_password").focusout(function(){
		var value = $(this).val();
		if(!hasValue("#confirm_password","Confirm Password")) confirm_password_valid = false;
		else if( value !== $("#password").val())
		{
			confirm_password_valid = false;
			$("#confirm_password_error").text("Password should be same ");
			$(this).css("background-color","#FFE4E1");
		}
		else 
		{
			confirm_password_valid = true;
			$("#confirm_password_error").text("");
		}
	});
});