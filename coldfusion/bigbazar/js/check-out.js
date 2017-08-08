var billing_address_fields = ["#billing_first_name","#billing_email","#billing_address","#billing_state","#billing_city","#billing_zip"];
var shipping_address_fields = ["#shipping_address","#shipping_state","#shipping_city","#shipping_zip"];
var payment_detail_fields = ["#credit_card_name","#credit_card_number","#card_security_code","#card","#card_expiration_month","#card_expiration_year"];

$("#same_address").click(function(){
	if($(this).prop("checked"))
	{
		$(".bill-to #bill_add").hide();
	}
	else
	{
		$(".bill-to #bill_add").show();
	}
});

/*$("#submit").click(function(){

});*/
function submit_form()
{
	var isValid = true;
	jQuery.each(billing_address_fields,function(index,ids){
		var val = $(ids).val().trim();
		if(val === undefined || val === "" || val === null)
		{	
			isValid = false;
			var newid = ids+"_error";
			$(newid).html("Please! enter this field");
		}
		else if(ids === "#billing_email")
		{
			if(!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(val)))
			{
				isValid = false;
				var newid =  ids+"_error";
				$(newid).html("Please! enter a valid email i'd");
			}
		}
		else if(ids === "#billing_zip")
		{
			if(!(/^[1-9](\d){5}$/.test(val)))
			{
				isValid = false;
				var newid = ids+"_error";
				$(newid).html("Please! enter a valid zip code of 6 digits");
			}
		}
	});
	if(!($("#same_address").prop("checked")))
	{
		jQuery.each(shipping_address_fields,function(index,ids){
			var val = $(ids).val().trim();
			var newid = ids+"_error";
			if(val === undefined || val === "" || val === null)
			{	
				isValid = false;
				$(newid).html("Please! enter this field");
			}
			else if(ids === "#shipping_zip")
			{
				if(!(/^[1-9](\d){5}$/.test(val)))
				{
					isValid = false;
					$(newid).html("Please! enter a valid zip code of 6 digits");
				}
			}
		});
	}
	jQuery.each(payment_detail_fields,function(index,ids){
		var val = $(ids).val().trim();
		var newid = ids+"_error";
		if(val === undefined || val === "" || val === null)
		{
			isValid = false;
			$(newid).html("Please! enter this field");
		}
		else if(ids === "#credit_card_number")
		{
			if(!(/^[1-9](\d){11}$/.test(val)))
			{
				isValid = false;
				$(newid).html("Please! enter a valid card number of 12 digits");
			}
		}
		else if(ids === "#card_security_code")
		{
			if(!(/^[1-9](\d){2}$/.test(val)))
			{
				isValid = false;
				$(newid).html("Please! enter a valid 3 digit security code");
			}
		}
		
	});
			
		
	return isValid;
}