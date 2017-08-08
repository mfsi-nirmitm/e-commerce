var index_arr =["first_name","last_name","email","contact","password","confirm_password","dob"];
var index_name_field=["First Name","Last Name","Email Id","Contact Number","Password","Confirm Password","Date Of Birth"];
var index1_arr = ["address" ,  "city", "state", "country", "pin"] ;
var index1_field = ["Address", "City", "State", "Country", "Pin Code"];
var sign = ["+", "-", "*", "/"];
var operation = "";
var ans=0, num1 = 0 , num2 = 0 ;
function check_field(value,id,name)
{
	var field= id+"_error";
	if( value=="" || value==null || value==undefined )
	{
		document.getElementById(field).innerHTML="Please! Enter the "+name;
		return false;
	}
	else if(id === "password")
	{
		document.getElementById(field).innerHTML = "";
		if(!(/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[$@!%*#?&])[A-Za-z\d$@!%*#?&\s]{4,}$/.test(value) ))
		{
			document.getElementById(field).innerHTML = "Password lenght should be 4 and atleat 1 small case letter , 1 upper case letter , 1 digit and 1 special character ";
			return false;
		}
		else
		return true;
	}
	else if(id === "confirm_password")
	{
		document.getElementById(field).innerHTML = "";
		var new_password = document.getElementById("password").value;
		var confirm_password= value;
		if(new_password === confirm_password)
			return true;
		else
		{
			document.getElementById(field).innerHTML="Password did not match!";
			return false;
		}
	}
	else if(id === "contact")
	{
		if(/^[1-9](\d){9}$/.test(value))
		{
			document.getElementById(field).innerHTML = "";
			return true;
		}
		else 
		{
			document.getElementById(field).innerHTML="Please! Enter 10 digit mobile number";
			return false;
		}
	}
	else if(id=== "email")
	{
		document.getElementById(field).innerHTML="";
		if(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value))
		{
			return true;
		}
		else
		{
			document.getElementById(field).innerHTML="Please! Enter a valid email id";
			return false;
		}
	}
	else if(id === "dob")
	{
		document.getElementById(field).innerHTML="";
		var all= value.split("/");
		if(all.length!==3 || !(/^(\d){1,2}\/(\d){1,2}\/(\d){4}$/.test(value))) 
		{
			document.getElementById(field).innerHTML="Please! Enter a valid date in formate dd/mm/yyyy or d/m/yyyy";
			return false;
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
			var leap_year =isLeap(year);
			if(day <= 0 || month <= 0 || month >12 || year < 1960 || day >31)
			{
				document.getElementById(field).innerHTML="Please! Enter a valid date in formate dd/mm/yyyy or d/m/yyyy";
				return false;
			}
			if(year > today_year || (month >today_month && year === today_year) || (day >= today_day && month === today_month && year === today_year))
			{
				document.getElementById(field).innerHTML="Please! Enter a pervious date";
				return false;
			}
			if((month === 2) && (day === 29 ))
			{
				if(!leap_year)
				{
					document.getElementById(field).innerHTML=year+" is not an leap year";
					return false;
				}
				else
					return true;
			}
			if((month === 2 && day > 29) || ((month === 4 || month === 6 || month === 9 || month === 11 ) && day === 31))
			{
				document.getElementById(field).innerHTML="Please! Enter a vaid date in formate dd/mm/yyyy or d/m/yyyy";
				return false;
			}
			
			return true;
		}
	}
	else if(id === "pin")
	{
		if(/^[1-9](\d){5}$/.test(value))
		{
			document.getElementById(field).innerHTML = "";
			return true;
		}
		else
		{
			document.getElementById(field).innerHTML = "Please! Enter a valid PIN of 6 numbers";
			return false;
		}
	}
	else 
	{
		document.getElementById(field).innerHTML = "";
		return true;
	}
}
function validation(arr,name_field)
{
	var valid=true;
	for(var i in arr)
	{
		var value=document.getElementById(arr[i]).value;
		if(arr[i]!="password" && arr[i]!="confirm_password") value = value.trim();
		if(!check_field(value,arr[i],name_field[i]))
			valid=false;
	}
	return valid;
}
function submit_basic_info()
{
	var valid=validation(index_arr, index_name_field);
	if(!hasValue("user_gender")) valid=false;
	return valid;
}
function submit_address()
{
	return validation(index1_arr, index1_field);
}
function sign_up()
{
	var valid = hasValue("user_interest");
	if(!valid) captcha();
	var answer_value = document.getElementById("answer").value;
	if(!check_field(answer_value,"answer","Answer")) valid=false;
	var ans2 = parseInt(answer_value);
	if(ans !== ans2)
	{
		valid = false;
		document.getElementById("answer_error").innerHTML ="Please! try again";
		captcha();
	}
	if(valid) alert("You are registered now ");
	return valid;
}
function hasValue(element_name)
{
	var all = document.getElementsByName(element_name);
	var has = false;
	for (var i in all )
	{
		if ( all [i].checked )
		{
			has = true; 
			break;
		}
	}
	if(!has)
	{
		document.getElementById(element_name+"_error").innerHTML= "Please! select an field";
	}
	else document.getElementById(element_name+"_error").innerHTML= "";
	return has;
}
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

	document.getElementById("sign").innerHTML= operation;
	document.getElementById("num1").innerHTML=num1;
	document.getElementById("num2").innerHTML=num2;
}