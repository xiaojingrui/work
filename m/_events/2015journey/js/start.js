!function(){
	/**
	 * pager.common
	 * 公共方法
	 */
	pager.common = {
		formatNum: function(Num){
			var showNum = parseInt(Num, 10);
			showNum = showNum.toString();
			var len = showNum.length;
			if (len <= 3) {
				return showNum;
			}
			var r = len % 3;
			return r > 0 ? showNum.slice(0, r) + "," + showNum.slice(r, len).match(/\d{3}/g).join(",") : showNum.slice(r, len).match(/\d{3}/g).join(",");
		},
        eventName: ("touchstart" in window ? "touchend" : "click"),
	    getRandom: function(end, start){
	        start = start || 0;
	        var range = end - start;
	        var rand = Math.random();   
	        return(start + Math.round(rand * range));
	    },
	    template: function(template, data){
		    return template.replace(/\{([\w\.]*)\}/g, function(str, key) {
			    var keys = key.split("."), v = data[keys.shift()];
			    for (var i = 0, l = keys.length; i < l; i++) v = v[keys[i]];
			    return (typeof v !== "undefined" && v !== null) ? v : "";
			 });
	    },
        transformList: function($wrap) {
            var $list = null;

            if(pager.userType == 1){
                $list = $wrap.find('.ui-transform-text li');
            }else{
                $list = $wrap.find('.ui-islogin-tips li');
            }

            if($list.length){
                var duration = 0;

                if(pager.userType == 1){
                    duration = 1000;
                }

                $list.each(function(){
                    duration += 500;
                    $(this).transition({
                        opacity: 1,
                        translate: [0,-20],
                        delay : duration
                    }, 500);
                });
            }
        },
        removeListAttr: function(){
            if($('.ui-transform-text li').length){
                $('.ui-transform-text li').removeAttr('style');
            }
        },
        tipsRender: function($elem, data) {
            var template = '';

            // 正常用户
            if(pager.userType == 1){
                template = _.template( $("#tips-info-tpl").html())
            }else{
                template = _.template( $("#islogin-data-tips").html());

                //data.posts = pager.common.formatNum(data.posts);
                //data.reply = pager.common.formatNum(data.reply);
                //data.light = pager.common.formatNum(data.light);
                //
                //if(typeof data.games !== "undefined"){
                //    data.games = pager.common.formatNum(data.games);
                //}
            }

            var str = template(data);

            $elem.append(str);
        },
        removeTips: function(){
            if($('.ui-tips-info').length){
                $('.ui-tips-info').removeAttr('style');
            }
        },
        /**
         * 比赛
         * @param $page
         * @param data
         */
        gameTips: function($page, data) {
            // 正常用户
            if(pager.userType == 1){
                var template = _.template($("#tips-game-tpl").html())(data);

                $page.append(template);
            }
        },
        gameTransform: function($page) {
            var selt = this;

            if($page.find('.user-comment-tips').length) {
                var $userText1 = $page.find('.user-comment-tips .user-text'),
                    $userActive1 = $page.find('.user-comment-tips .user-active');

                pager.common.transitTion($userActive1, {
                    opacity: 1
                }, function(){
                    pager.common.transitTion($userText1, {
                        opacity: 1,
                        translate: [10,0]
                    }, function(){

                    });
                });
            }

            if($page.find('.user-live-player').length){
                var $userText2 = $page.find('.user-live-player .user-text'),
                    $userActive2 = $page.find('.user-live-player .user-active');

                pager.common.transitTion($userActive2, {
                    opacity: 1,
                    delay : 500
                }, function(){
                    pager.common.transitTion($userText2, {
                        opacity: 1,
                        translate: [-10,0]
                    }, function(){

                    });
                });
            }

        },
        /**
         * 地图画线
         */
        isMapLine: function(data) {
            var value = false;

            // 正常用户
            if(pager.userType == 1){
                try {
                    if(parseInt(data.posts, 10) !== 0 || parseInt(data.reply, 10) !== 0 || parseInt(data.light, 10) !== 0) {
                        value = true;
                    }

                    if(typeof data.games !== "undefined" && parseInt(data.games, 10) !== 0) {
                        value = true;
                    }

                }catch(err) {}
            }


            return value;
        },
        /**
         * 转换数据
         */
        convertData: function() {
            // 正常用户
            if(pager.userType == 1){
                return pager.showData.mapplatedata;
            }

            return pager.showData.hupumapplatedata;
        },
	    transform: function(cur, max){
	    	return Math.round(cur * max * .01);
	    },
        transitTion: function($elem, config, callback) {
            var options = callback ? $.extend(config, {
                complete: callback
            }) : config;
            $elem.transition(options);
        },
	    loadJs: function(url, loadCallback){
	    	var head = document.getElementsByTagName('head')[0];
	    	var script = document.createElement('script');

	        if ('onload' in script) {
	            script.onload = loadCallback;
	        }
	        else {
	            script.onreadystatechange = function() {
	                if (this.readyState == 'loaded' || this.readyState == 'complete') {
	                    loadCallback();
	                }
	            }
	        }
	        
	        script.type = 'text/javascript';
	        script.src = url;
	        head.appendChild(script);
	        return script;
	    },
        showLoading: function(){
            var self = this;
            if(!this.$loading){
                this.$loading = $(
                '<div class="share-loading">'+
                    '<div class="loading-icon"></div>'+
                    '正在查找...'+
                '</div>'
                );
                $("body").append(this.$loading);

                this.$loading.on(this.eventName, function(e){
                    self.hideSearch();
                });
            }
            this.$errmsg.empty();
            this.$loading.show();
        },
        hideLoading: function(){
            this.$loading && this.$loading.hide();
        },
        showSearch: function(){
            if(!this.$searchMask){
                var self = this;
                this.$searchMask = $("<div class='mask'></div>");
                this.$serachBox = $(
                    '<div class="search">'+
                        '<div class="search-box clearfix">'+
                            '<div class="fl-ipt">'+
                              '<input type="text" placeholder="请输入虎扑昵称" maxlength="30">'+
                            '</div>'+
                            '<div class="fr-btn J-find-user">查看</div>'+
                            '<i class="clearmsg">×</i>'+
                        '</div>'+
                        '<div class="err-msg"></div>'+
                        '<div class="search-tips">忘记昵称?请 <a href="https://passport.hupu.com/m/2?jumpurl=http://m.hupu.com/zhengtu/index">登录</a> 还没有虎扑账号? <a href="/zhengtu/index?f=1&from=suibian">随便看看</a>~ </div>'+
                    '</div>'
                );
                this.$input = this.$serachBox.find("input");
                this.$errmsg = this.$serachBox.find(".err-msg");

                $("body").append(this.$searchMask);
                $("body").append(this.$serachBox);

                this.$searchMask.on(this.eventName, function(e){
                    self.hideSearch();
                });
                this.$serachBox.find(".J-find-user").on(this.eventName, function(e){
                    self.checkUser();
                });
                this.$serachBox.find(".clearmsg").on(this.eventName, function(e){
                    self.$input.val("");
                });
                try{__dace.sendEvent("0004");}catch(e){};
            }
            this.$searchMask.show();
            this.$serachBox.show();
            this.$errmsg.empty();
            if(this.$input && this.$input.size()){
                this.$input[0].focus();
            }
        },
        hideSearch: function(){
            this.$searchMask.hide();
            this.$serachBox.hide();
            this.$input.val("");
            this.hideLoading();
        },
        checkUser: function(){
            var userName = this.$input.val().trim();
            var self = this;
            if(userName){
                this.showLoading();
                $.ajax({
                    type:"GET",
                    url:"/zhengtu/getuserinfobyuname",
                    data:{
                        uname: userName
                    },
                    dataType:"json",
                    success: function(res){
                        self.hideLoading();
                        if(res.code === 1){
                            setTimeout(function(){
                                var url = "/zhengtu/index?uname=" + encodeURIComponent(userName) + "&from=zhengtu";
                                location.href = url;
                            }, 0);
                        } else{
                            self.$errmsg.text("查无此人");
                        }
                    }
                });
            }
        }
	};
	/**
	 * pager.loading
	 * 页面loading
	 */
	pager.loading = {
		start: function(){
			var self = this;
			this.loadingContainer = document.querySelector("#loading");
			this.loadShow = this.loadingContainer.querySelector(".load-show");

			this.loadResource(function(){
				$(self.loadingContainer).hide();
				//页面方法主入口
				pager.main.init();
			});
		},
		loadResource: function(callback){
			var res = [
				pager.host + 'js/pager.main.js?v='+ pager.ver,
				pager.host + 'js/pager.background.js?v='+ pager.ver,
                pager.host + 'js/echarts/echarts.js',
                pager.host + 'js/echarts/continent_geo.js',
				pager.host + 'js/pager.index.js?v='+ pager.ver,
				pager.host + 'js/pager.africa.js?v='+ pager.ver,
				pager.host + 'js/pager.zb.js?v='+ pager.ver,
				pager.host + 'js/pager.nba.js?v='+ pager.ver,
				pager.host + 'js/pager.cba.js?v='+ pager.ver,
				pager.host + 'js/pager.chinaFoot.js?v='+ pager.ver,
				pager.host + 'js/pager.football.js?v='+ pager.ver,
				pager.host + 'js/pager.result.js?v='+ pager.ver,
				pager.host + 'js/pager.data.js?v='+ pager.ver,
				pager.host + 'js/pager.earth.js?v='+ pager.ver,
				pager.host + 'js/pager.count.js?v='+ pager.ver,
				pager.host + 'js/pager.share.js?v='+ pager.ver,
				pager.host + 'js/lib/requestAnimationFrame.js',
				pager.host + 'js/lib/underscore.js',
                pager.host + 'js/lib/jquery.all.js'
            ];
			var self = this;
			var resLen = res.length, 
				index = 0;
			var _callback = function(){
				index++;
				self.loadShow.innerText = "("+ index +"/"+ resLen +")";
				if(index === resLen){
					callback && callback();
				}
			};
			for(var i=0;i<resLen;i++){
				pager.common.loadJs(res[i], _callback);
			}
		}
	};
	pager.loading.start();
}();