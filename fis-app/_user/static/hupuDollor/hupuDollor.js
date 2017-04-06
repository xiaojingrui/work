!function(){

    function initBridge(callback) {
        if(window.HupuBridge){
            callback();
        }else{
            document.addEventListener("hupuBridgeReady", function(){
                callback();
            });
        }
    }

    initBridge(function() {
        HupuBridge.send("hupu.ui.share", {
                open: false
            }, function() {}
        );
    });

    var _ = require('underscore'),
        refresh = require("common:widget/ui-refresh/ui-refresh.js");

    var App = function() {
        var $el = $('#detail-list'),
            isloading = false,
            pages = 1,
            isFirstFull = false,
            s_url = GM.payMonth,
            history_url = GM.payThreeMonth;

        var Init = function() {
            ajaxAction(s_url, function() {

                if( $el.find('li').size() < 20 ){
                    pages = 1;
                    ajaxAction(history_url, loadMore);
                }else{
                    loadMore();
                }
            });
        }

        var ajaxAction = function(url, callback) {

            if(isloading) return;

            $.ajax({
                type: 'Get',
                url: url,
                data:{
                    page: pages
                },
                cache: false,
                dataType: 'json',
                beforeSend : function () {
                    isloading = true;
                },
                success: function(data) {
                    appendData(data);
                    isloading = false;
                    if(data.length < 20) {
                        if(url.indexOf('3Month') != -1){
                            isFirstFull = true;
                            $('#loading').html('<p>没有更多了</p>').css('opacity', 1);
                            callback && callback('finish');
                            return;
                        }else{
                            isFirstFull = true;
                            pages = 1;
                        }
                    }else{
                        pages++;
                    }

                    callback && callback();
                }
            })
        };

        var appendData = function(data) {
            $.each(data, function(i, item) {
                var html,
                    gold_name,
                    gold_type;

                if( item.type == 1){
                    gold_name = 'color2';
                    gold_type = '+';
                }else{
                    gold_name = 'color1';
                    gold_type = '-';
                }
                html = [
                    '<li>',
                        '<div class="item-infor">',
                            '<h4>', item.title, '</h4>',
                            '<p>', item.time, '</p>',
                        '</div>',
                        '<div class="item-extra">',
                            '<b class="', gold_name ,'">', gold_type, item.amount , '</b>',
                        '</div>',
                    '</li>'
                ].join("");

                $el.append(html);
            });
        }

        var loadMore = function() {
            refresh({
                contentEl: '#detail-list',
                isRefresh: false,
                // 向下
                loadingMoreCallback: function(complete) {
                    var url = isFirstFull ? history_url : s_url;

                    ajaxAction(url, complete);
                }
            });
        }

        return {
            init: Init
        }
    }();

    $(document).ready(function() {
        App.init();
    });

}()
