/**
 * pager.chinaFoot
 * 中国足球
 */
!function() {
    pager.chinaFoot = {
        name : "chinaFoot",
        start: function() {
            var self = this;

            if(!this.init){
                this.init = true;
                this.$wrap = $('.china-football-page');

                this.mainTpl = $('#chinaFootball-main-tpl').html();

                var str = this.mainTpl,
                    pageIndex = this.$wrap.attr('data-key'),
                    data = pager.common.convertData()[pageIndex];

                this.$wrap.append(str);

                pager.common.gameTips(this.$wrap, data);
                pager.common.tipsRender(this.$wrap, data);

                this.$tips = this.$wrap.find('.ui-tips-info');
                this._isShowLine = pager.common.isMapLine(data);
                this.myChart = null;

                //文本逐个显示出来.
                this.transitTion(self.$tips, {
                    opacity: 1,
                    translate: [0, -10],
                    delay : 500
                }, function() {
                });

                pager.common.gameTransform(self.$wrap);
                pager.common.transformList(self.$wrap);
            }

            this.running = true;
        },
        map: function() {
            var self = this;

            require(['echarts', 'echarts/chart/map'], function (ec) {
                    // 基于准备好的dom，初始化echarts图表
                    self.myChart = ec.init(document.getElementById('J_chinaFootMap'));

                    var placeList = [
                        {name:'d1', geoCoord:[121,25]},
                        {name:'d2', geoCoord:[80,45]},
                        {name:'d3', geoCoord:[100,43]},
                        {name:'d4', geoCoord:[125,53]},
                        {name:'d5', geoCoord:[115,40]}
                    ];

                    if(self._isShowLine) {

                        var option = {
                            series : [
                                {
                                    name: '中国',
                                    type: 'map',
                                    mapType: 'continent|中国',
                                    hoverable: false,
                                    itemStyle:{
                                        normal:{
                                            areaStyle:{
                                                color: 'rgba(71,76,94,0)'
                                            }
                                        }
                                    },
                                    data : [],
                                    nameMap: {
                                        '中国': '中国足球'
                                    },
                                    markPoint : {
                                        symbol:'emptyCircle',
                                        symbolSize : function (v){
                                            return 10 + v/100
                                        },
                                        effect : {
                                            show: true,
                                            color: '#fff',
                                            shadowBlur : 0
                                        },
                                        itemStyle:{
                                            normal:{
                                                label:{show:false}
                                            }
                                        },
                                        data : [
                                            {name: "text", value: 193}
                                        ]
                                    },
                                    markLine : {
                                        symbol: ['none', 'none'],
                                        itemStyle : {
                                            normal: {
                                                borderWidth:1,
                                                color: '#fff',
                                                lineStyle: {
                                                    type: 'solid'
                                                }
                                            }
                                        },
                                        data : [
                                            [
                                                {name:'text'},
                                                {name:'line1'}
                                            ],
                                            [
                                                {name:'line2'},
                                                {name:'line1'}
                                            ],
                                            [
                                                {name:'line4'},
                                                {name:'line3'}
                                            ]
                                        ]
                                    },
                                    geoCoord: {
                                        'line1':[113,68],
                                        'line2':[110,68],
                                        'line3':[113.5,68],
                                        'line4':[116,60],
                                        "text":[120,45]
                                    }
                                },
                                {
                                    name: '中国',
                                    type: 'map',
                                    mapType: 'continent|中国',
                                    hoverable: false,
                                    data : [],
                                    nameMap: {
                                        '中国': 'CBA'
                                    },
                                    markPoint : {
                                        symbol : 'circle',
                                        symbolSize: 5,
                                        large: true,
                                        effect : {
                                            show: true,
                                            type: 'scale',
                                            color: '#30d0fc',
                                            shadowBlur : 0
                                        },
                                        itemStyle:{
                                            normal:{
                                                label:{show:false}
                                            }
                                        },
                                        data : (function(){
                                            var data = [];
                                            var len = 5;
                                            var geoCoord
                                            while(len--) {
                                                geoCoord = placeList[len % placeList.length].geoCoord;
                                                data.push({
                                                    name : placeList[len % placeList.length].name + len,
                                                    geoCoord : [
                                                        geoCoord[0] + Math.random() * 5 - 2.5,
                                                        geoCoord[1] + Math.random() * 3 - 1.5
                                                    ]
                                                })
                                            }
                                            return data;
                                        })()
                                    }
                                }
                            ]
                        };

                    }else{
                        var option = {
                            series : [
                                {
                                    name: '中国',
                                    type: 'map',
                                    mapType: 'continent|中国',
                                    hoverable: false,
                                    itemStyle:{
                                        normal:{
                                            areaStyle:{
                                                color: 'rgba(71,76,94,0)'
                                            }
                                        }
                                    },
                                    data : [],
                                    nameMap: {
                                        '中国': '中国足球'
                                    },
                                    markPoint : {
                                        symbol : 'circle',
                                        symbolSize: 5,
                                        large: true,
                                        effect : {
                                            show: true,
                                            type: 'scale',
                                            color: '#30d0fc',
                                            shadowBlur : 0
                                        },
                                        itemStyle:{
                                            normal:{
                                                label:{show:false}
                                            }
                                        },
                                        data : (function(){
                                            var data = [];
                                            var len = 5;
                                            var geoCoord
                                            while(len--) {
                                                geoCoord = placeList[len % placeList.length].geoCoord;
                                                data.push({
                                                    name : placeList[len % placeList.length].name + len,
                                                    geoCoord : [
                                                        geoCoord[0] + Math.random() * 5 - 2.5,
                                                        geoCoord[1] + Math.random() * 3 - 1.5
                                                    ]
                                                })
                                            }
                                            return data;
                                        })()
                                    }
                                }
                            ]
                        };
                    }

                    // 为echarts对象加载数据
                    self.myChart.setOption(option);
                }
            );
        },
        run: function() {
            if (!this.running) return;
            var self = this;
            var options = {
                opacity: 1,
                translate: [0,20],
                duration: 800,
                easing: 'in'
            };

            this.map();


            this.running = false;
        },
        transitTion: function($elem, config, callback) {
            var options = callback ? $.extend(config, {
                complete: callback
            }) : config;
            $elem.transition(options);
        },
        stop: function() {
            //pager.common.removeListAttr();
            this.myChart.clear();
            this.myChart.dispose();
            this.$wrap.find('.ui-map').html('');
            //this.$tips.attr('style', '');
        }
    };
}();