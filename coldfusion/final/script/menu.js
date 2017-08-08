// JavaScript Document
$(document).ready(function(){
	$('#menu ul li:has(ul)').hover(function(){
		$('ul', this).slideToggle(300);
	})//endHover
})//end ready