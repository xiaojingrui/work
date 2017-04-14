/**
 * pager.result
 * 结束
 */
!function() {
    pager.result = {
        name : "result",
        start: function() {
            var self = this;

            if(!this.init){
                this.init = true;
                this.$wrap = $('.result-page');
                var str = _.template( $("#result-tpl").html())({datas:  pager.showData.summary});

                var data = pager.common.convertData();

                this.$wrap.html(str);

                this.$map = this.$wrap.find('.ui-map');
                this.$text = this.$wrap.find('.result-text');


                this.mapData = [
                    // 甘比亚
                    {name: '非洲', value: 0},
                    {name: '中国', value: 0},
                    // NBA
                    {name: '加拿大美国', value: 0},
                    // 国际足球
                    {name: '欧洲1', value: 0},
                    {name: '欧洲', value: 0},
                    {name: '南美洲', value: 0},
                    // 装备
                    {name: '澳大利亚', value: 0}
                ];

                if(data.length){
                    var isChina = false;

                    _.map(data, function(list, i) {
                        switch (list.tname){
                            case '甘比亚':
                                self.mapData[0]['value'] = list.score;
                                break;
                            case '运动装备':
                                self.mapData[6]['value'] = list.score;
                                break;
                            case 'NBA':
                                self.mapData[2]['value'] = list.score;
                                break;
                            case 'CBA':
                            case '中国足球':
                                if(!isChina){
                                    self.mapData[1]['value'] = list.score;
                                    isChina = true;
                                }
                                break;
                            case '国际足球':
                                self.mapData[3]['value'] = list.score;
                                self.mapData[4]['value'] = list.score;
                                self.mapData[5]['value'] = list.score;
                                break;
                            default:
                                break;
                        }
                    });
                }

            }


            this.running = true;
        },
        map: function() {
            var self = this;

            require(['echarts', 'echarts/chart/map'], function (ec) {
                    // 基于准备好的dom，初始化echarts图表
                    var myChart = ec.init(document.getElementById('J_resultMap'));

                    var option = {
                        dataRange: {
                            show: false,
                            min: 0,
                            max: 100,
                            splitNumber:0,
                            color: ['#ff9400','#ffaf41','#e0b77e','#ae8449','#c2811b','#474c5e']
                        },
                        series : [
                            {
                                name: '洲',
                                type: 'map',
                                mapType: 'continent',
                                itemStyle:{
                                    normal:{
                                        areaStyle:{
                                            color: '#474c5e'
                                        }
                                    }
                                },
                                data: self.mapData
                            }
                        ]
                    };

                    // 为echarts对象加载数据
                    myChart.setOption(option);
                }
            );
        },
        run: function() {
            if (!this.running) return;
            var self = this;
            var options = {
                opacity: 1,
                translate: [0,-20],
                duration: 500,
                easing: 'in'
            };

            this.map();

            this.transitTion(self.$map, options, function() {

                self.transitTion(self.$text, options, function() {
                });

            });


            this.running = false;
        },
        transitTion: function($elem, config, callback) {
            var options = callback ? $.extend(config, {
                complete: callback
            }) : config;
            $elem.transition(options);
        },
        stop: function() {
            this.$map
                .html('')
                .removeAttr('style');
        }
    };
}();