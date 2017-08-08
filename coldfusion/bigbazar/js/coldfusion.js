
var _myFuncs = new jsClass();

function addItem(arg) 
{
   _myFuncs.addProductByProductWithSellerID(arg);
   var newid = "#"+ arg;
   var val = parseInt($(newid).val()) + 1;
   $(newid).val(val);
   if(val == 2) 
   {
	   var buttonid = "#subButton" + arg;
	   $(buttonid).removeAttr("disabled");
   }	   
   var price = getTotalPrice(arg,val);
   var id = "#total"+arg +" span";
   var totalcartprice = parseInt($("#totalcartprice").html()) - parseInt($(id).html());
   totalcartprice = totalcartprice + price;
   $("#totalcartprice").html(totalcartprice);
   $(id).html(price);
}
function decrementItem(arg)
{
	_myFuncs.decrementProductByProductWithSellerID(arg);
	var newid = "#"+arg;
	var val = parseInt($(newid).val()) ;
	if(val > 1) val = val - 1;
	$(newid).val(val);
	if(val == 1)
	{
		var buttonid = "#subButton" + arg;
		$(buttonid).attr("disabled","true");
	}
	var price = getTotalPrice(arg,val);
	var id = "#total"+arg +" span";
	var totalcartprice = parseInt($("#totalcartprice").html()) - parseInt($(id).html());
	totalcartprice = totalcartprice + price;
	$("#totalcartprice").html(totalcartprice);
	$(id).html(price);
}

function getTotalPrice(productwithsellerid, items)
{
	var price = _myFuncs.getTotalPriceByProductWithSellerID(productwithsellerid) * items;
	return price;
}
function removeProduct(productwithsellerid)
{
	_myFuncs.removeProductByProductWithSellerID(productwithsellerid);
	var table_id = "#table" + productwithsellerid;
	$(table_id).remove();
}
