/**
 * pager.football
 * 国际足球
 */
!function() {
    pager.football = {
        name : "football",
        start: function() {
            var self = this;

            if(!this.init){
                this.init = true;
                this.$wrap = $('.football-page');

                this.mainTpl = $('#football-main-tpl').html();

                var str = this.mainTpl,
                    pageIndex = this.$wrap.attr('data-key'),
                    data = pager.common.convertData()[pageIndex];

                var template = _.template(str);

                str = template(data);

                this.$wrap.append(str);

                pager.common.gameTips(this.$wrap, data);
                pager.common.tipsRender(this.$wrap, data, 'ui-tips-info-1');

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
                    self.myChart = ec.init(document.getElementById('J_footballMap'));

                    if(self._isShowLine) {
                        var option = {
                            series: [
                                {
                                    name: '欧洲',
                                    type: 'map',
                                    mapType: 'continent|欧洲1',
                                    mapLocation: {x: '0', y: '5%', width: '90%'},
                                    hoverable: false,
                                    itemStyle: {
                                        normal: {
                                            areaStyle: {
                                                color: 'rgba(71,76,94,0)'
                                            }
                                        }
                                    },
                                    data: [],
                                    markPoint: {
                                        symbol: 'emptyCircle',
                                        symbolSize: function (v) {
                                            return 10 + v / 100
                                        },
                                        effect: {
                                            show: true,
                                            color: '#fff',
                                            shadowBlur: 0
                                        },
                                        itemStyle: {
                                            normal: {
                                                label: {show: false}
                                            }
                                        },
                                        data: [
                                            {name: "text1", value: 193}
                                        ]
                                    },
                                    markLine: {
                                        symbol: ['none', 'none'],
                                        itemStyle: {
                                            normal: {
                                                borderWidth: 1,
                                                color: '#fff',
                                                lineStyle: {
                                                    type: 'solid'
                                                }
                                            }
                                        },
                                        data: [
                                            [
                                                {name: 'text1'},
                                                {name: 'line10'}
                                            ],
                                            [
                                                {name: 'line11'},
                                                {name: 'line10'}
                                            ],
                                            [
                                                {name: 'line12'},
                                                {name: 'line13'}
                                            ]
                                        ]
                                    },
                                    geoCoord: {
                                        'line10': [26, 64],
                                        'line11': [23, 64],
                                        'line12': [28, 55],
                                        'line13': [27, 64],
                                        "text1": [28, 45]
                                    }
                                },
                                {
                                    name: '南美洲',
                                    type: 'map',
                                    mapType: 'continent|南美洲',
                                    mapLocation: {x: '45%', y: '45%'},
                                    hoverable: false,
                                    itemStyle: {
                                        normal: {
                                            areaStyle: {
                                                color: 'rgba(71,76,94,0)'
                                            }
                                        }
                                    },
                                    data: [],
                                    nameMap: {
                                        '南美洲': '国际足球'
                                    },
                                    textFixed: {
                                        '南美洲': [-50, -90]
                                    }
                                }
                            ]
                        };
                    }else{
                        var option = {
                            series: [
                                {
                                    name: '欧洲',
                                    type: 'map',
                                    mapType: 'continent|欧洲1',
                                    mapLocation: {x: '0', y: '5%', width: '90%'},
                                    hoverable: false,
                                    itemStyle: {
                                        normal: {
                                            areaStyle: {
                                                color: 'rgba(71,76,94,0)'
                                            }
                                        }
                                    },
                                    data: []
                                },
                                {
                                    name: '南美洲',
                                    type: 'map',
                                    mapType: 'continent|南美洲',
                                    mapLocation: {x: '45%', y: '45%'},
                                    hoverable: false,
                                    itemStyle: {
                                        normal: {
                                            areaStyle: {
                                                color: 'rgba(71,76,94,0)'
                                            }
                                        }
                                    },
                                    data: [],
                                    nameMap: {
                                        '南美洲': '国际足球'
                                    },
                                    textFixed: {
                                        '南美洲': [-50, -90]
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
            //pager.common.removeTips();
            this.myChart.clear();
            this.myChart.dispose();
            this.$wrap.find('.ui-map').html('');
            //this.$userText1.attr('style', '');
            //this.$userText2.attr('style', '');
            //this.$userActive1.attr('style', '');
            //this.$userActive2.attr('style', '');
        }
    };
}();