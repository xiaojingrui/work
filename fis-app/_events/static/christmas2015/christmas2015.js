(function() {
	var _ = require('underscore');
	var dace = require("common:widget/ui-dace/ui-dace.js");

	var xmas = {
		init: function() {
			this.render();
			this.bind();
			this.changeItem();

			var xurl = window.location.href;
			var ua = window.navigator.userAgent;

			if(xurl.indexOf("xmasurl")!=-1 && ua.indexOf("kanqiu")!=-1){
				xurl = xurl.replace(/&xmasurl=\d+/,"");
				window.location.href = xurl;
			}


			if(GM.url){
				window.history.pushState({}, "", GM.url);
			}
		},

		render: function() {
			this.page1 = $("#J-page1");
			this.page2 = $("#J-page2");
			this.submitBtn = $("#J-submit-btn");
			this.guessListContainer = $("#J-guess-list");
			this.changeListContainer = $("#J-change-list");
			this.shareBtn = $(".share-btn");
			this.inputQQ = $("#J-input-qq");
			this.inputCode = $("#J-input-code");
			this.error = $("#J-error");
			this.confirmBtn = $("#J-confirm-btn");
			this.changeLink = $("#J-change-link");
			this.moreBtn = $("#J-more");
			this.friendsGuessList = $("#J-friends-guess-list");
			this.queryBtn = $("#J-query-btn");

			this.tplMorePage = _.template($("#J-more-page-tpl").html() || "");
			this.tplJoinSuccess = _.template($("#J-join-success-tpl").html());

			this.iWidth = $(window).width();
			this.iHeight = $(window).height();

			this.isJoined = null;
			this.isSend = true;
			this.isCheck = true;
			this.isMore = true;
		},

		bind: function() {
			var self = this;
			var reg = /^[1-9][0-9]{5,15}$/;
			var guessOlder = [];
			var page = 2;
			var bOn = true;

			//提交按下样式
			self.submitBtn.on("touchstart", function() {
				$(this).addClass("submit-click");
			});
			self.submitBtn.on("touchmove", function() {
				$(this).removeClass("submit-click");
			});
			self.submitBtn.on("touchend", function() {
				$(this).removeClass("submit-click");
			});
			//领奖凭证弹层
			self.submitBtn.on("click", function() {
				bOn = true;
				self.confirmBtn.data("value", "");
				
				self.showBox($(".price-showBox"));
				guessOlder = [1,2,3,4,5,6];
				//document.getElementById("J-input-qq").focus();
				self.guessListContainer.find("li").each(function(index) {
					var index2 = parseInt($(this).css("top")) / 68;
					guessOlder[index2] = $(this).data("rank");
				});
				self.confirmBtn.data("value", guessOlder.join(""));
			});

			//分享按下样式
			self.shareBtn.on("touchstart", function() {
				$(this).addClass("share-btn-click");
			});
			self.shareBtn.on("touchmove", function() {
				$(this).removeClass("share-btn-click");
			});
			self.shareBtn.on("touchend", function() {
				$(this).removeClass("share-btn-click");
			});
			//分享提示弹层
			self.shareBtn.on("click", function() {
				dace.send("christmasact_sure1");
				self.showBox($(".remind-showBox"));
			});

			//QQ号验证
			self.inputQQ.on("blur", function() {
				var val = $(this).val();
				if (reg.test(val)) {
					self.error.hide();
				} else {
					$(this).val("");
					$(this).attr("placeholder", "请重新输入QQ号")
					self.error.show();
				}
			});

			//QQ中奖查询
			self.queryBtn.on("click", function(){
				var queryInputVal = $(".input-query-qq").val();
				if(self.isCheck){
					if (reg.test(queryInputVal)) {
						if(queryInputVal){
							self.checkQQ();
						}else{
							$(".input-query-error").html("您还没有输入QQ号");
						}
						self.isCheck = false;
					}else{
						$(".input-query-qq").val("");
						$(".input-query-error").html("您输入的QQ号格式不正确");
					}
				}
			});

			//修复移动端fixed与模拟键盘不兼容问题
			$(".input").on("click", function() {
				if (bOn) {
					$(".price-showBox").css("top", parseInt($(".price-showBox").css("top")) - 100);
					bOn = false;
				}
			});

			//验证码刷新
			self.changeLink.on("click", function() {
				var oldSrc = $(".code-img img").attr("src");
				$(".code-img img").attr("src", oldSrc + "?/t=" + new Date().getTime());
			});

			//提交表单
			self.confirmBtn.on("click", function() {
				if (self.inputQQ.val() && self.inputCode.val() && self.isSend) {
					self.sendMsg();
					self.isSend = false;
				} else {
					console.log("请输入QQ号和验证码");
				}
			});

			//加载更多
			self.moreBtn.on("click", function() {
				if(self.isMore){
					self.morePage(page, function() {
						page++;
					});
					self.isMore = false;
				}
			});


			$(window).on("load scroll resize", function() {
				self.showWrapH();
			});

			// 提醒分享图片
			$(".remind-showBox").css({
				"position": "fixed",
				"top": "5%"
			});


			var oldTopArr = [-72, -40, -60, -55, -30];
			var oldMrArr = [40, 60];

			//自适应
			$(window).on("resize load orientationchange", function() {
				var winW = $(window).width();
				if (winW > 750) {
					winW = 750;
				}

				//标题图片
				$(".auto-bg").each(function(index) {
					$(".auto-bg").eq(index).css({
						"top": winW * oldTopArr[index] / 320
					});
				});

				//下边距
				$(".auto-mr").each(function(index) {
					$(".auto-mr").eq(index).css({
						"margin-bottom": winW * oldMrArr[index] / 320
					});
				});
			});
		},

		changeItem: function() {
			var self = this;

			self.changeListContainer.find("li").on("touchstart", function() {
				$(this).addClass("click");
			});
			self.changeListContainer.find("li").on("touchmove", function() {
				$(this).removeClass("click");
			});
			self.changeListContainer.find("li").on("touchend", function() {
				$(this).removeClass("click");
			});

			self.changeListContainer.find("li").on("click", function() {
				var oldIndex = $(this).index();
				var item1 = null;
				var item2 = null;
				self.guessListContainer.find("li").each(function(index) {
					if (parseInt(self.guessListContainer.find("li").eq(index).css("top")) / 68 == oldIndex) {
						item1 = self.guessListContainer.find("li").eq(index);
					}
					if (parseInt(self.guessListContainer.find("li").eq(index).css("top")) / 68 == oldIndex + 1) {
						item2 = self.guessListContainer.find("li").eq(index);
					}
				});

				var oldTop1 = parseInt(item1.css("top"));
				var oldTop2 = parseInt(item2.css("top"));

				var oldRank1 = item1.find(".num span").html();
				var oldRank2 = item2.find(".num span").html();

				item1.css("top", oldTop2);
				item2.css("top", oldTop1);

				item1.find(".num span").html(oldRank2);
				item2.find(".num span").html(oldRank1);
			});
		},

		sendMsg: function() {
			var self = this;
			var unionid = "";
			if(GM.isweixin){
				unionid = self.confirmBtn.data("unionid")
			}
			$.ajax({
				url: "/christmasact/dealform",
				type: "POST",
				dataType: "json",
				data: {
					"unionid": unionid,
					"code": $(".code").val(),
					"qq": $(".qq").val(),
					"f": self.confirmBtn.data("f"),
					"value": self.confirmBtn.data("value")
				},
				success: function(data) {
					self.page2.find(".result-inner").append(self.tplJoinSuccess({
						datas: data.data
					}));
					self.isSend = true;
					if (data.error.code == 1) {
						self.error.show();
						self.error.html("您输入的验证码不正确！");
						var oldSrc1 = $(".code-img img").attr("src");
						$(".code-img img").attr("src", oldSrc1 + "?/t=" + new Date().getTime());
					}
					if (data.error.code == 2) {
						self.error.show();
						self.error.html("您输入的QQ号不规范！");
					}
					if (data.error.code == 3) {
						self.error.show();
						self.error.html("您的排序值有误：" + self.confirmBtn.data("value"));
					}
					if (data.error.code == 4) {
						self.error.show();
						self.error.html("您点开的分享链接地址有问题哟~");
					}
					if (data.error.code == 0 && data.type == 1) {
						$(".mod-show-mask").hide();
						$(".price-showBox").hide();
						self.page1.hide();
						self.page2.show();
						window.history.pushState({}, "", data.url);
						dace.send("christmasact_sure2");
					}
					if (data.type == 0) {
						$(".mod-show-mask").hide();
						$(".price-showBox").hide();
						self.page1.hide();
						self.page2.show();

						self.page2.find(".join-inner").show();
						self.page2.find(".unjoin-inner").hide();
						window.history.pushState({}, "", data.url);
						dace.send("christmasact_sure2");
					}
				}
			});
		},

		morePage: function(page, callback) {
			var self = this;
			var friendid = GM.friendid;
			$.ajax({
				//url: "/christmasact/getfriendsres_"+page, //本地测试
				url: "/christmasact/getfriendsres", //线上
				type: "GET",
				dataType: "json",
				data: {
					"f": friendid,
					"p": page
				},
				success: function(data) {
					self.friendsGuessList.append(self.tplMorePage({
						datas: data.data
					}));
					self.isMore = true;
					if (data.more == 0) {
						self.moreBtn.hide();
					}
					callback && callback();
				}
			});
		},

		checkQQ: function() {
			var self = this;
			$.ajax({
				url: "/christmasact/checkqq",
				type: "GET",
				dataType: "json",
				data: {
					"qqnum": $(".input-query-qq").val()
				},
				success: function(data) {
					self.isCheck = true;
					if(data.error.code == 1){
						$(".input-query-error").html("此QQ号未参与该活动");
					}else{
						var queryHref = window.location.href;
						queryHref = queryHref.substring(0, queryHref.indexOf("?"));
						window.location.href = queryHref + "?qqnum=" + $(".input-query-qq").val();
					}
				}
			});
		},

		showBox: function(obj) {
			var self = this;
			obj.show();
			$(".mod-show-mask").show();
			obj.find(".close").on("click", function() {
				obj.hide();
				$(".mod-show-mask").hide();
			});
			$(".mod-show-mask").on("click", function(e) {
				e.stopPropagation();
				obj.hide();
				$(".mod-show-mask").hide();
			});
			self.boxCenter($(".mod-showBox"));
		},

		showWrapH: function() {
			$(".mod-show-mask").css("height", $(document).height());
		},

		boxCenter: function(obj) {
			var self = this;
			var objWidth = obj.width();
			var objHeight = obj.height();

			if (obj.size() == 1) {
				obj.css({
					"left": (self.iWidth - objWidth) / 2,
					"top": (self.iHeight - objHeight) / 2
				});
			} else {
				obj.each(function() {
					$(this).css({
						"left": (self.iWidth - objWidth) / 2,
						"top": (self.iHeight - objHeight) / 2
					});
				});
			}
		}

	}

	xmas.init();
})();