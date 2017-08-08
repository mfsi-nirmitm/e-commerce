var nirmit = 'nirmit';
$(document).ready
		(function()
		{
				alert("before");
				$("#here").html("this is hey");
				$.ajax
				({

					url: "https://127.0.0.1/coldfusion/experiment/components/something.cfc?method=abc&returnFormat=JSON",
					global: false,
					type: "POST",
					data: {name:nirmit},
					dataType: "json",
					//data: {username:name,password:pass},
					async:false,
					success: function(msg){
						alert(msg);
					}
				});
				alert("after");
		});
