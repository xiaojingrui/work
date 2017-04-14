/**
 * @file 足球比赛列表
 * @author wangjun@hupu.com
 * @date 2015-07-21
 */

"use strict";

    var _ = require("underscore");
    var refresh = require("common:widget/ui/refresh/refresh.js");
    var Tips = require('common:widget/ui/tips/tips.js');

    /**
     * 接口地址
     */
    var apiUrl = {
        // 更多比赛列表
        matchMore: location.pathname

    };

    /**
     * 比赛未开始提示层
     */
    function notLink() {

        if($('.J_matchListNotLink').length) {
            $('.J_matchListNotLink')
                .off()
                .on('click', function() {
                    Tips('比赛尚未开始');
                });
        }
    }


    notLink();


    var $content = $('#J_content')
        ,startTime = $content.attr('data-start-time')
        ,endTime = $content.attr('data-end-time')
        ,isLoad = true
        ,flag = true;

    refresh({
        contentEl: '#J_content',
        // 向上
        refreshCallback: function(complete) {
            $.ajax({
                url: apiUrl.matchMore,
                type: "GET",
                data: {
                    match_day: startTime
                    ,'order': 1
                },
                dataType: 'json',
                success: function(data) {
                    if( !isLoad ) {
                        return;
                    }

                    isLoad = false;

                    // 是否有数据
                    if (Object.keys(data.gameList).length) {
                        var tpl = _.template( $("#list-template").html(), {
                            datas: data
                        } );

                        $content.prepend( tpl );
                        complete();
                        startTime = data.startTime;
                        isLoad = true;
                    } else {
                        $('.top-tips').show();
                        complete("finish");
                    }
                }
            });
        },
        loadingMoreCallback: function(complete) {
            $.ajax({
                url: apiUrl.matchMore,
                type: "GET",
                data: {
                    match_day: endTime,
                    'order': 2
                },
                dataType: 'json',
                success: function(data) {
                    if( !flag || !isLoad ) {
                        return;
                    }

                    isLoad = false;

                    // 是否有数据
                    if (Object.keys(data.gameList).length) {
                        var tpl = _.template( $("#list-template").html(), {
                            datas: data
                        } );

                        $content.append( tpl );
                        complete();
                        endTime = data.endTime;
                        notLink();
                        isLoad = true;
                    } else {
                        flag = false;
                        complete("finish");
                        $('.bottom-tips').show();
                    }
                }
            });

        }
    });
