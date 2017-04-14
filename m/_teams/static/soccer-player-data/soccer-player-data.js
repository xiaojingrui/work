(function(){

	var recentData = $("#J-recent-data");

	recentData.find("tbody tr").on("click", function(){
		location.href = $(this).attr("link");
	});

	recentData.find("tbody tr").on({
		mousedown: function(){
			$(this).addClass("click-effect");
		},
		mousemove: function(){
			$(this).removeClass("click-effect");
		},
		mouseup: function(){
			$(this).removeClass("click-effect");
		}
	});

})();
