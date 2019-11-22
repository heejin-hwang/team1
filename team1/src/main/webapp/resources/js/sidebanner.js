$(document).ready(function() {
	/* controller(); */
	
	var date  = $('#date').val();
	console.log("========================", date);
	var date2 = new Date(date);
	console.log("===================", date2);
	var date3 = new Date(date);
	
	
	$( "#mydiv" ).draggable();

	$( "#sidebanner" ).draggable();
	
	$('#homeup').click(function() {
		$('body,html').animate({
			scrollTop : 0
		}, 800);
		return false;
	});	//onclick

	var scrollHeight = $(document).height();
	$('#homedown').click(function() {
		$('body,html').animate({
			scrollTop : scrollHeight
		}, 800);
		return false;
	});	//onclick
	
	$('#prevM').on("click",function() {
		prev_Move(date2,date3);
	});
	
	$('#nextM').on("click", function() {
		next_Move(date2,date3);
	});	//onclick
	
});	//document.ready


var count = 0;

function prev_Move(date2,date3) {

	if (count > 1) {
		count--;
		
	}		
	
	var offset = $("#div" + count).offset();
	$('html, body').animate({
		scrollTop : offset.top
	}, 500);
	
	if(date3.getMonth() < date2.getMonth()){
		console.log('count -- :', count);
		
		var m = date2.getMonth();
		console.log('------------------------------m', m);
		date2.setUTCMonth(m-1);
		
		var year = date2.getFullYear();
		var month = date2.getMonth()+1;
		
		var result = year+"-"+month;
		
		$('.change_month').text(result);
	}

}	//function



function next_Move(date2,date3) {
	
	if (count < 5) {
		count++;
	}
	
	var offset = $("#div" + count).offset();
	$('html, body').animate({
		scrollTop : offset.top
	}, 500);
	
	if(count>1){
		if(date3.getMonth()+4 > date2.getMonth()){
			
			var m = date2.getMonth();
			date2.setMonth(m+1);
			
			var year = date2.getFullYear();
			var month = date2.getMonth()+1;
			
			console.log("-------------------------------------year-",year);
			console.log("-------------------------------------month-",month);
			var result = year+"-"+month;
			console.log("--------------------------------------result-",result);
	
			$('.change_month').text(result);
			
		}
	}
/* 		$('.change_month').text(result); */ 
	
	console.log('count ++ :', count);

}	//function

/*var x_styleLeft, y_styleTop, x_accept, y_accept;


$(function() {

	$(document).ready(function(){ 
		$('.sidebanner').mousedown(function(event) {
			x_styleLeft = event.clientX - $(".sidebanner").offset().left;
			y_styleTop = event.clientY - $(".sidebanner").offset().top;

			$(document).mousemove(function(event){ 
				x_accept = event.clientX - x_styleLeft;
				y_accept = event.clientY - y_styleTop;
				$(".sidebanner").css("left",x_accept+"px"); 
				$(".sidebanner").css("top",y_accept+"px"); 
			});
		});
	}).mouseup(function(){

		$(this).off('mousemove');
	});
	$('.sidebanner').css('cursor', 'move')

});*/
