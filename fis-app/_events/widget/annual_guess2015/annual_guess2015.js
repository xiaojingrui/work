var _ = require("underscore");
var liveCommon = require("events:widget/annual_common/annual_common.js")

var annual_guess = {
	init: function(){
		this.guess = {}
		this.counts = 0

		liveCommon.init();
		this.render();
		this.bind();
	},

	render: function(){
		this.listContainer = $("#J-list");
		this.tplListRender = _.template($("#J-list-tpl").html());

		this.iHeight = $(window).height();
		this.counts = 0;
	},

	bind: function(){
		var self = this;
		this.bindPred();

		$("body").css({
			"height": self.iHeight,
			"overflow": "hidden"
		});

		var count = 0;
		setInterval(function(){
			count++;
			self.updateUI()
			var max =  Math.ceil(self.maxHeight / self.iHeight)
			var index = count % max
			self.listContainer.find(".list-container").css("top", -self.iHeight*index);
		}, 5000);
	},

	bindPred: function(){
		var self = this;

		function add(data){
			var guessItem = {
				content : data.title,
				data: []
			}
			var len = data.option.length
			data.option.forEach(function(item, index){
				guessItem.data.push({
					opid: parseInt(item.opid),
					op: item.op,
					opCount: 0,
					opPercent: 0
				})
			})
			if(data.toid){
				self.guess[data.toid] = guessItem
			}
		}
		//新增
		liveCommon.on("predadd", add)

		//修改
		liveCommon.on("predchange", add)

		//开奖
		liveCommon.on("predopen", function(data){
			self.findGuessAndRemove(data.toid)
		})

		//流盘
		liveCommon.on("predremove", function(data){
			self.findGuessAndRemove(data.toid)
		})

		//参与预测
		liveCommon.on("preding", function(data){

			if(data.toid && self.guess[data.toid]){
					var uopid = parseInt(data.uop);
					var max = 0;
					$(self.guess[data.toid].data).map(function(idx, item){
						if(uopid == item.opid){
								item.opCount = parseInt(data.tc);
						}
						max += item.opCount;
					});

					if(max > 0){
						$(self.guess[data.toid].data).map(function(idx, item){
								item.opPercent = (item.opCount / max * 100) | 0;
						});
					}
			}
		})
	},
	findGuessAndRemove: function(id){
		if(this.guess[id]){
			delete this.guess[id]
		}
	},
	updateUI: function(){
		var datas = []
		for(var x in this.guess){
			if(this.guess.hasOwnProperty(x)){
				datas.push(this.guess[x])
			}
		}
		this.maxHeight = $(".list-container").height()
		var html = this.tplListRender({datas: datas});
		this.listContainer.html( html );
	}
}

module.exports = annual_guess;
