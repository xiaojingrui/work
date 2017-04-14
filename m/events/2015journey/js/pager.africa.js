/**
 * pager.africa
 * 甘比亚处理
 */
!function() {
    var common = pager.common;
    pager.africa = {
        name : "africa",
        start: function() {
            var self = this;

            if(!this.init){
                this.init = true;
                this.$wrap = $('.africa-page');

                this.mainTpl = $('#africa-main-tpl').html();

                var str = this.mainTpl,
                    pageIndex = this.$wrap.attr('data-key'),
                    data = pager.common.convertData()[pageIndex];

                this.$wrap.append(str);

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

                pager.common.transformList(self.$wrap);
            }


            this.running = true;
        },
        map: function() {
            var self = this;


            require(['echarts', 'echarts/chart/map'], function (ec) {
                    // 基于准备好的dom，初始化echarts图表
                    self.myChart = ec.init(document.getElementById('J_africaMap'));

                    var placeList = [
                        {name:'d1', geoCoord:[32,-15]},
                        {name:'d2', geoCoord:[24,-10]},
                        {name:'d3', geoCoord:[50,10]},
                        {name:'d4', geoCoord:[10,20]},
                        {name:'d5', geoCoord:[-18,18]}
                    ];

                    if(self._isShowLine){
                        var option = {
                            series : [
                                {
                                    name: '非洲',
                                    type: 'map',
                                    mapType: 'continent|非洲',
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
                                        '非洲': '甘比亚'
                                    },
                                    textFixed : {
                                        '非洲' : [0, -60]
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
                                            {name: "text"}
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
                                                {name:'line2'}
                                            ],
                                            [
                                                {name:'line3'},
                                                {name:'line2'}
                                            ],
                                            [
                                                {name:'line5'},
                                                {name:'line4'}
                                            ]
                                        ]
                                    },
                                    geoCoord: {
                                        'line2':[26,38],
                                        'line3':[24,38],
                                        'line4':[27,38],
                                        'line5':[30,28],
                                        "text":[32,18]
                                    }
                                },
                                {
                                    name: '非洲',
                                    type: 'map',
                                    mapType: 'continent|非洲',
                                    hoverable: false,
                                    data : [],
                                    markPoint : {
                                        symbol : 'circle',
                                        symbolSize: 6,
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
                                    name: '非洲',
                                    type: 'map',
                                    mapType: 'continent|非洲',
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
                                        '非洲': '甘比亚'
                                    },
                                    textFixed : {
                                        '非洲' : [0, -60]
                                    },
                                    markPoint : {
                                        symbol : 'circle',
                                        symbolSize: 6,
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
            //pager.common.removeTips();
            this.myChart.clear();
            this.myChart.dispose();
            this.$wrap.find('.ui-map').html('');
        }
    };
}();