
(function(){
    var Util = require('common:widget/ui/util/util.js');

    var SlideBoard = function() {
        this.init();
    }

    SlideBoard.prototype = {
        init: function() {
            this.boardList = $('.board-list');
            this.tab = $('.sidebar li');
            this.tabFn();
        },
        tabFn: function() {
            var self = this;

            this.boardList.eq(0).show();
            this.tab.eq(0).addClass('cur');

            this.tab.on('click', function() {
                var index = $(this).index(),
                    tag = $(this).data('fid');

                self.tab.eq(index).addClass('cur').siblings().removeClass('cur');


                // 如果点击收藏(没有fid),不发送请求
                if(!$(this).data('fid')){
                    self.boardList.hide().eq(index).show();
                }else{
                    $.ajax({
                       url: '/bbs/todayadd',
                       type: 'post',
                       data: {
                           thistag: tag
                       },
                       dataType: 'json',
                       success: function(data) {
                            self.update(data.data, index);
                            self.boardList.hide().eq(index).show();
                       }
                   })
                }
            })
        },
        update: function(infoArr, conIndex) {
            var conArr = this.boardList.eq(conIndex).find('li');
            for(var i in infoArr) {
                for(var j = 0; j < conArr.length; j++) {
                    if($(conArr[j]).data('fid') == i){
                        if(infoArr[i] != 0){
                            $(conArr[j]).find('i').html(infoArr[i] + "&nbsp;帖");
                        }
                    }
                }
            }
        }

    }

    new SlideBoard();

}());
