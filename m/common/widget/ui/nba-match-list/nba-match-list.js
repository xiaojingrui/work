var nbaMatchList = {
    init: function() {
        this.bind();
    },

    bind: function() {
        var _ = require('underscore'),
            curUrl = $('.news-list').data('url');

        // /api/nba/gameslist?test=1&date=2015-05-12&order=2
        var apiUrl = null;
        if(GM.type == "team"){
            apiUrl = "/nba/teams/"+GM.en_name+"/schedule/ajax";
        }else{
            apiUrl = "/api/nba/gameslist";
        }

        var stop = true,
            _page = 0,
            _totalPage = $('.news-list').data('pagecount'),
            flag = true,
            refreshController = require("common:widget/ui/refresh/refresh.js");

        refreshController({
            contentEl: '#J_content',
            // 向上
            refreshCallback: function(complete) {
                // window.location.reload();
                var _date = $('.match-list-wrap').find('section').first().attr('match-date');

                $.ajax({
                    type: 'POST',
                    url: apiUrl + '?date=' + _date + '&order=2',
                    dataType: 'json',
                    timeout: 3000,
                    success: function(data) {
                        if (data.status == 200) {
                            $(".match-list-wrap").prepend(_.template($("#t2").html(), {
                                datas: data.data
                            }));
                            stop = true;
                            complete();
                        } else {
                            $('.top-tips').show();
                            complete("finish");
                        }


                    },
                    error: function(xhr, type) {
                        // alert('Ajax error!');
                    }
                });

                complete();
            },

            loadingMoreCallback: function(complete) {
                var _date = $('.match-list-wrap').find('section').last().attr('match-date');
                if (!flag) {
                    return false;
                }
                if (stop == true) {

                    stop = false;

                    $.ajax({
                        type: 'POST',
                        url: apiUrl + '?date=' + _date + '&order=1',
                        dataType: 'json',
                        timeout: 3000,
                        beforeSend: function() {
                            $('.loading-more').show();
                        },
                        success: function(data) {
                            if (data.status == 200) {
                                $(".match-list-wrap").append(_.template($("#t2").html(), {
                                    datas: data.data
                                }));
                                $('.loading-more').hide();
                                stop = true;
                                complete();
                            } else {
                                $('.bottom-tips').show();
                                flag = false;
                                complete("finish");
                            }
                        },
                        error: function(xhr, type) {
                            // alert('Ajax error!');
                        }
                    });
                }
            }
        });
    }
}

module.exports = nbaMatchList;
