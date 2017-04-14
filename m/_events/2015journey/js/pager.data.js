/**
 * pager.data
 * 首页处理
 */
!function() {
	var common = pager.common;
	pager.data = {
		name : "data",
		start: function() {
			var self = this;
			if(!this.init){
				this.init = true;
				this.container = $(".data-page");
				this.dialogTpl = $("#data-dialog-tpl").html();
				this.pageTpl = $("#data-page-tpl").html();

				this.container.delegate(".J-dialog", "click", function(e){
					self.showDialog();
				});
			}
			
			this.render();
			this.resetTmpData();
			this.round1 = this.container.find(".circle-data .item1 .round");
			this.round12 = this.container.find(".circle-data .item1 .round2");
			this.round2 = this.container.find(".circle-data .item2 .round");
			this.round22 = this.container.find(".circle-data .item2 .round2");
			this.round3 = this.container.find(".circle-data .item3 .round");
			this.round32 = this.container.find(".circle-data .item3 .round2");

			this.line1 = this.container.find(".line-data .item1 .inner");
			this.line2 = this.container.find(".line-data .item2 .inner");
			this.line3 = this.container.find(".line-data .item3 .inner");
			this.line4 = this.container.find(".line-data .item4 .inner");

			this.round12Show = false;
			this.round22Show = false;
			this.round32Show = false;
			setTimeout(function(){
				self.line1.css("width",common.transform(self.data.d4, 225));
				self.line2.css("width",common.transform(self.data.d5, 225));
				self.line3.css("width",common.transform(self.data.d6, 225));
				self.line4.css("width",common.transform(self.data.d7, 225));
			}, 200);
			this.running = true;
		},
		run: function() {
			if (!this.running) return;

			var tmpdata = this.tmpData;
			var data = this.data;
			var allPass = true;

			if(tmpdata.d1 <= data.d1){
				tmpdata.d1 += tmpdata.s1;
				allPass = false;
				if(tmpdata.d1 <= 50){
					this.round1.css({rotate: common.transform(tmpdata.d1, 360)});
				} else{
					this.round12.css({rotate: common.transform(tmpdata.d1-50, 360)});
				}
				//修正浮点运算
				if(tmpdata.d1 >= 50 && !this.round12Show){
					this.round12Show = true;
					this.round12.show();
					this.round1.css({rotate: "180deg"});
				}
				if(tmpdata.d1 >= 100){
					this.round12.css({rotate: "180deg"});
				}
			}
			if(tmpdata.d2 <= data.d2){
				tmpdata.d2+= tmpdata.s2;
				allPass = false;
				if(tmpdata.d2 <= 50){
					this.round2.css({rotate: common.transform(tmpdata.d2, 360)});
				} else{
					this.round22.css({rotate: common.transform(tmpdata.d2-50, 360)});
				}
				//修正浮点运算
				if(tmpdata.d2 >= 50 && !this.round22Show){
					this.round22Show = true;
					this.round22.show();
					this.round2.css({rotate: "180deg"});
				}
				if(tmpdata.d2 >= 100){
					this.round22.css({rotate: "180deg"});
				}
			}
			if(tmpdata.d3 <= data.d3){
				tmpdata.d3 += tmpdata.s3;
				allPass = false;
				if(tmpdata.d3 <= 50){
					this.round3.css({rotate: common.transform(tmpdata.d3, 360)});
				} else{
					this.round32.css({rotate: common.transform(tmpdata.d3-50, 360)});
				}
				//修正浮点运算
				if(tmpdata.d3 >= 50 && !this.round32Show){
					this.round32Show = true;
					this.round32.show();
					this.round3.css({rotate: "180deg"});
				}
				if(tmpdata.d3 >= 100){
					this.round32.css({rotate: "180deg"});
				}
			}

			if(allPass){
				this.stop();
			}

		},
		render: function(){
			var self = this;
			var renderPage = function(data){
				var html = _.template(self.pageTpl)(data);
				self.container.html(html);
			}
			if(this.data){
				renderPage(this.data);
			} else{
				this.getData("uid", function(data){
					self.data = data;
					renderPage(data);
				});
			}
		},
		getData: function(uid, callback){
			var userinfo = pager.showData.userbaseinfo;
			callback({
				d1: userinfo.shili_level,
				d2: userinfo.chijiu_level,
				d3: userinfo.chunjie_level,
				d4: userinfo.shengchan_level,
				d5: userinfo.shengwang_level,
				d6: userinfo.shengun_level,
				d7: userinfo.caifu_level,
				a_posts: userinfo.a_posts,
				a_replys: userinfo.a_replys,
				a_beitj: userinfo.a_beitj,
				a_beidl: userinfo.a_beidl,
				a_sonli: userinfo.a_sonli,
				a_dashang: userinfo.a_dashang,
				shengun_level:userinfo.shengun_level
			});
		},
		resetTmpData: function(){
			this.step = common.getRandom(50, 40);
			this.tmpData = {
				d1:0,
				d2:0,
				d3:0,
				s1: this.data.d1 / this.step,
				s2: this.data.d2 / this.step,
				s3: this.data.d3 / this.step
			};
			
		},
		showDialog: function(){
			if(!this.$mask){
				var self = this;
				this.$mask = $("<div class='mask'></div>");
				this.$dialog = $("<div class='state-popup'></div>");
				this.$dialog.html(this.dialogTpl);
				$("body").append(this.$mask);
				$("body").append(this.$dialog);

				this.$mask.on("click", function(e){
					self.hideDialog();
				});

				this.$dialog.delegate(".close","click", function(e){
					self.hideDialog();
				});
			}
			this.$mask.show();
			this.$dialog.show();
		},
		hideDialog: function(){
			this.$mask.hide();
			this.$dialog.hide();
		},
		stop: function() {
			this.running = false;
			this.resetTmpData();
		}
	};
}();