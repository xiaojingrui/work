! function() {
	var getel = $("#preference");
	var popcontent = $("#pop");
	var mask = $("#mask");
	var totop = $("#totop");
	var cancel = $("#cancel");
    

	getel.on("click", function() {
		mask.css("height", Math.max($(document).height(), window.screen.height));
		
		var left = ($(window).width() - 300) / 2;
		popcontent.show().css("left", left);
		mask.show();
		$("html,body").addClass("hide-body-scroll");
		$("html,body").scrollTop(0);
	});


	var closeHandler = function() {
		popcontent.hide();
		mask.hide();
		$("html,body").removeClass("hide-body-scroll");
	}
	cancel.on("click", closeHandler);
	mask.on("click", closeHandler);
}();