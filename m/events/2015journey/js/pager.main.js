/**
 * pager.main
 * 页面主要处理逻辑
 */
!function() {
	var needRenderPages = [];
	var currentPage = "index";
	pager.renderCount = 0;
	pager.main = {
		//页面方法主入口
		init: function() {
			var self = this;
			this.updateSize();

			$("#page-container").append('<div class="fixed-arrow"></div>');
			//初始化背景
			pager.background.start();
			self.pushPage("background");

			//初始化首页
			pager.index.start();
			self.pushPage("index");

			//初始化右上角的地球
			self.pushPage("earth");

            //渲染全部模板
            self.renderAllPage();

            //单页初始化
            self.SlidePage = new SlidePage({
                lastReturnFirst: false,
                // 页面切换成功
                successCallback: function(options) {
                    var index = options.pageNow;
                    var current = $(options.pages).eq(index).data("page");
                    var lastPage = currentPage;
                    //停掉之前页面的动画
                    if (pager[lastPage] && pager[lastPage].stop) {
                        pager[lastPage].stop();
                    }

                    //开启本页面的动画.
                    if (pager[current] && pager[current].start) {
                        pager[current].start();
                        self.pushPage(pager[current].name);
                    }

                    pager.earth.show(current);

                    currentPage = current;
                }
            });
            

            // 路径配置
            require.config({
                paths: {
                    echarts: pager.host + 'js/echarts'
                }
            });

            require(['echarts', 'echarts/chart/map'], function (ec) {
                    require('echarts/util/mapData/params').params.continent = {
                        getGeoJson: function (callback) {
                            callback(continentGeo);
                        }
                    }

                }
            );
			this.Run();
		},
		pushPage: function(name) {
			if(!name) return needRenderPages;
			var allPage = "_" + needRenderPages.join("_") + "_";
			if (!~allPage.indexOf("_" + name + "_")) {
				needRenderPages.push(name);
			}
			return needRenderPages;
		},
		Run: function() {
			pager.renderCount++;
			var self = this;
			var i = 0,
				len = needRenderPages.length;
			for (; i < len; i++) {
				if (pager[needRenderPages[i]] && pager[needRenderPages[i]].run) {
					pager[needRenderPages[i]].run();
				}
			}
			requestAnimationFrame(function() {
				self.Run.call(self);
			});
		},
		bindEvent: function() {
			var self = this;
			window.addEventListener("resize", function() {
				self.updateSize();
			});

            var eventName = !!("ontouchstart" in window) ? "touchstart":"mouseup";
            //dace统计
            $('body').on(eventName, function(e) {
                var nodeName = 'dace-node';
                var target = e.target;
                while (!target.getAttribute(nodeName) && 'BODY' !== target.tagName) {
                    target = target.parentElement;
                    if (!target) {
                        break;
                    }
                }
                if ('BODY' !== target.tagName) {
                    var daceData = target.getAttribute(nodeName);
                    try {
                        __dace.sendEvent(daceData);
                    } catch (e) {};
                }
            });
		},
		updateSize: function() {
			pager.width = window.innerWidth;
			pager.height = window.innerHeight;
		},
        renderAllPage: function() {
            var self = this;
            var html = '';
            //优先显示个人数据，展示整体数据
            var pages = pager.common.convertData();

            var userType = pager.userType;
            //登陆或者有数据的用户
            //1为正常，2为僵尸，3为未登录.
            if(userType == 1){
                try{__dace.sendEvent("0001");}catch(e){};
                pages = pages.concat([{
                    tname:"个人数据"
                },{
                    tname:"个人总结"
                },{
                    tname:"分享"
                }]);
                
            //未登陆用户
            }else{
                try{__dace.sendEvent("0002");}catch(e){};
                pages = pages.concat([{
                    tname:"虎扑数据"
                },{
                    tname:"分享"
                }]);
            }

            var channels = {
                "甘比亚": {
                    page: 'africa',
                    className: 'africa-page'
                },
                "NBA": {
                    page: 'nba',
                    className: 'nba-page'
                },
                "运动装备": {
                    page: 'zb',
                    className: 'zb-page'
                },
                "CBA": {
                    page: 'cba',
                    className: 'cba-page'
                },
                "国际足球": {
                    page: 'football',
                    className: 'football-page'
                },
                "中国足球": {
                    page: 'chinaFoot',
                    className: 'china-football-page'
                },
                "虎扑数据":{
                    page: 'count',
                    className: 'count-page mod-world-bg'
                },
                "个人数据":{
                    page: 'data',
                    className: 'data-page mod-world-bg'
                },
                "个人总结":{
                     page: 'result',
                     className: 'result-page'
                },
                "分享":{
                    page: 'share',
                    className: 'share-page mod-world-bg'
                }
            };
            _.map(pages, function(list, i){
                if(channels[list.tname]){
                    html += self.pageTpl(channels[list.tname], list, i);
                }
            });

            $('#index').after(html);

            if(pager.userType !== 1){
                $('body').addClass('type-islogin');
            }
        },
        /**
         * 甘比亚
         * @returns {string}
         */
        pageTpl: function(name, data, i) {
            var str = '<div class="m-page '+ name.className +' fn-hide" data-page="'+ name.page +'" data-key="'+ i +'">';

            if(pager.userType == 1){
                if(!_.isEmpty(data.first)){
                    str += _.template( $("#first-list-tpl").html())({datas: data.first});
                }

                // PV 10
                if(!_.isEmpty(data.nodata)){
                    var arr = [{
                        "str": data.nodata
                    }];

                    str += _.template( $("#first-list-tpl").html())({datas: arr, className: 'ui-transform-nodata'});
                }
            }

            str += '</div>';

            return str;
        }
	};
}();