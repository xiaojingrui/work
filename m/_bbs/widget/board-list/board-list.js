
var boardList = {
	init: function() {
		this.bind();
	},
	bind:function() {
		var arrowBoard = $(".arrow_board h4");
		//导航折叠收起
		arrowBoard.on("click",function() {
			$(this).toggleClass("arrowH4");
			var $content = $(this).parents().find(".content");
			$content.toggle()
			//$content.animate({"height":'0px',"overflow": "hidden"},5000);
		})
	}
}

module.exports = boardList;