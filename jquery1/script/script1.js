var basic_info_form_ids = ["#first_name", "#last_name", "#email", "#contact", "#password", "#confirm_password", "#dob"];
var basic_info_fields = ["First Name", "Last Name", "Email Id", "Contact", "Password", "Confirm Password", "Date Of Birth"];
var first_name_valid = true, last_name_valid = true, email_valid = true, contact_valid = true, password_valid =true, confirm_password_valid = true, dob_valid =true; 
var address_form_ids = ["#address" , "#city", "#state", "#country", "#pin"];
var address_form_fields=["Address", "City" , "State", "Country", "PIN"];
var address_valid = true , city_valid = true, state_valid = true, country_valid= true, pin_valid = true;
var answer_valid = true;
function submit_basic_form()
{
	var valid = true;
	valid = validation(basic_info_form_ids,basic_info_fields);
	if (!$('input[name=user_gender]:checked').val() ) 
	{
		$("#user_gender_error").text('Please! select gender');
		valid = false;
	}
	else $("#user_gender_error").text('');
	if(!first_name_valid || !last_name_valid || !email_valid || !contact_valid || !password_valid || !confirm_password_valid || !dob_valid) valid = false;
	return valid;
}
function submit_address_form()
{
	var valid = true;
	valid = validation(address_form_ids,address_form_fields);
	if(!address_valid || !city_valid || !state_valid || !country_valid || !pin_valid ) valid= false;
	return valid;
}
function submit_interest_form()
{
	var valid = true;
	if(!$('input[name=user_interest]:checked').val())
	{
		$('#user_interest_error').text("Please! select your interest");
		valid = false;
	}
	var answer = $("#answer").val().trim();
	if(answer === "" || answer === null || answer === undefined) 
	{
		$("#answer_error").text("Please! enter Answer ");
		$("#answer").css("background-color","#FFE4E1");
	}
	if(!answer_valid) valid = false;
	if(valid) alert("Your form submitted");
	
	return valid;
	
}
function validation(ids,names)
{
	var valid = true;
	jQuery.each(ids ,function(index,field_id){
		var value = $(field_id).val();
		var new_id = field_id+"_error";
		if(field_id!="#password" && field_id!="#confirm_password") value = value.trim();
		if(value === "" || value === null || value === undefined )
		{
			$(new_id).text("Please! enter "+names[index]);
			$(field_id).css("background-color","#FFE4E1");
			valid=false;
		}
	});
	return valid;
}
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
		$(this).css({"background-color" : "#e8eeef", "color" : "#8a97a0"});
	});
	$("#first_name").focusout(function(){
		if(!hasValue("#first_name","First Name")) first_name_valid = false;
		else first_name_valid = true;
	});
	$("#last_name").focusout(function(){
		if(!hasValue("#last_name","Last Name")) last_name_valid = false;
		else last_name_valid = true;
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
	$("#contact").focusout(function(){
		var value = $(this).val().trim();
		if(/^[1-9](\d){9}$/.test(value))
		{ 
			contact_valid = true;
			$("#contact_error").text("");
		}
		else 
		{
			contact_valid = false;
			$("#contact_error").text("Please! enter a valid contact number");
			$(this).css("background-color","#FFE4E1");
		}
	});
	$("#password").focusout(function(){
		var value = $(this).val();
		if(/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[$@!%*#?&])[A-Za-z\d@$!%*#?&\s]{4,}$/.test(value) )
		{ 
			password_valid = true;
			$("#password_error").text("");
		}
		else{
			password_valid = false;
			$("#password_error").text("Password lenght should be minimum 4 and atleat 1 small letter , 1 upper letter , 1 digit and 1 special character ");
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
	$("#dob").focusout(function(){
		var value = $(this).val().trim();
		var all= value.split("/");
		dob_valid = true;
		if(all.length!==3 || !(/^(\d){1,2}\/(\d){1,2}\/(\d){4}$/.test(value)) ) 
		{
			$("#dob_error").text("Please! Enter a valid date in formate dd/mm/yyyy or d/m/yyyy");
			$(this).css("background-color","#FFE4E1");
			dob_valid = false;
		}
		else
		{
			var day  =parseInt(all[0]);
			var month=parseInt(all[1]);
			var year =parseInt(all[2]);
			var today = new Date();
			var today_day = today.getDate();
			var today_month = today.getMonth()+1;
			var today_year = today.getFullYear();
			var leap_year = isLeap(year);
			if(day <= 0 || month <= 0 || month >12 || year < 1960 || day >31)
			{
				$("#dob_error").text("Please! Enter a valid date in formate dd/mm/yyyy or d/m/yyyy");
				$(this).css("background-color","#FFE4E1");
				dob_valid = false;
			}
			else if(year > today_year || (month >today_month && year === today_year) || (day >= today_day && month === today_month && year === today_year))
			{
				$("#dob_error").text("Please! Enter a pervious date");
				$(this).css("background-color","#FFE4E1");
				dob_valid = false;
			}
			if((month === 2) && (day === 29 ) && dob_valid)
			{
				if(!leap_year)
				{
					$("#dob_error").text(year+" is not an leap year");
					$(this).css("background-color","#FFE4E1");
					dob_valid = false;
				}
			}
			if((month === 2 && day > 29) || ((month === 4 || month === 6 || month === 9 || month === 11 ) && day === 31) && dob_valid)
			{
				$("#dob_error").text("Please! Enter a vaid date in formate dd/mm/yyyy or d/m/yyyy");
				$(this).css("background-color","#FFE4E1");
				dob_valid = false;
			}
			if(dob_valid)
			{
				$("#dob_error").text("");
			}
		}
	});
	$('input[name=user_gender]').click(function(){
		if ($('input[name=user_gender]:checked').val() ) 
		$("#user_gender_error").text("");
	}); 
	$("#address").focusin(function(){
		$(this).css({"background-color" : "#FFFFF0", "color" : "#000000"});
	}).focusout(function(){
		if(!hasValue("#address","Address")) address_valid = false;
		else
		{ 
			$(this).css({"background-color" : "#e8eeef", "color" : "#8a97a0"});
			address_valid = true;
		}
	});
	$("#city").focusout(function(){
		if(!hasValue("#city","City")) city_valid = false;
		else city_valid = true;
	});
	$("#state").focusout(function(){
		if(!hasValue("#state","State")) state_valid = false;
		else state_valid = true;
	});
	$("#country").focusout(function(){
		if(!hasValue("#country","Country")) country_valid = false;
		else country_valid = true;
	});
	$("#pin").focusout(function(){
		var value = $(this).val().trim();
		if(/^[1-9](\d){5}$/.test(value))
		{
			$("#pin_error").text("");
			$(this).css({"background-color" : "#e8eeef", "color" : "#8a97a0"});
			pin_valid = true;
		}
		else{
			$("#pin_error").text("Please! Enter a valid pin");
			$(this).css("background-color","#FFE4E1");
			pin_valid= false;
		}
	});
	$('input[name=user_interest]').click(function(){
		if ($('input[name=user_interest]:checked').val() ) 
		$("#user_interest_error").text("");
	});
	$('#answer').focusout(function(){
		var value = $(this).val().trim();
		if(value === "" || value === null || value === undefined)
		{
			$("#answer_error").text("Please enter the answer");
			$(this).css("background-color","#FFE4E1");
			answer_valid = false;
		}
		else if(parseInt(value) !== ans)
		{
			answer_valid = false;
			$("#answer_error").text("Please Try again!");
			$(this).css("background-color","#FFE4E1");
			captcha();
		}
		else 
		{
			$("#answer_error").text("");
			$(this).css({"background-color" : "#e8eeef", "color" : "#8a97a0"});
			answer_valid = true;
		}
	});
});
function isLeap(year)
{
	if(year%400 === 0)
		return true;
	if(year % 100 === 0)
		return false;
	if(year % 4 === 0)
		return true;
	return false;
}
var sign = ["+", "-", "*", "/"];
var operation = "";
var ans=0, num1 = 0 , num2 = 0 ;

function random_number()
{
	return Math.floor((Math.random() * 10) + 1);
}
function devide()
{
	while(num1%num2 !=0 )
	{
		var temp = num1 % num2;
		num1 = num1 + num2 - temp;
	}
}
function minus()
{
	var temp =0;
	if(num1 < num2 )
	{
		temp = num1;
		num1 = num2;
		num2 = temp;
	}
}
function captcha()
{
	operation = sign[random_number()%4];
	num1 = random_number();
	num2 = random_number();
	if(operation === "/")
	{
		devide();
		ans = num1 / num2;
	}
	else if(operation === "+")
		ans= num1 +  num2;
	else if(operation === "-")
	{
		minus();
		ans = num1 - num2;
	}
	else ans = num1 * num2;

	$("#sign").text(operation);
	$("#num1").text(num1);
	$("#num2").text(num2);
}