$(function() {	
	$(".setting").on({
		
		"mouseover focus" : function() {
			var state = $('.updateBox').css('display');
			if (state == 'none') {
				$('.updateBox').show();
			}
		},

		"mouseout blur" : function() { // 포커스를 뗐을 때
			$('.updateBox').hide();
		}
	});
});