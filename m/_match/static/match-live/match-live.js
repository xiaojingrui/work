(function(){

var _ = require('underscore'),
    refresh = require("common:widget/ui/refresh/refresh.js"),
    gameId = $('.match-live').attr('game-id'),
    prevId = $('.match-live').attr('prev-id'),
    nextId = $('.match-live').attr('next-id'),
    isOver = $('.match-live').attr('isover'),
    stop = true;

var apiUrl = {
    newData : '/api/nba/game/getlastdata',
    oldData : '/api/nba/game/getolderdata'
};

var request = {
    interval: 15000,
    listen: null,
    isOver: isOver,
    start: function(){
        var self = this;
        if(this.isOver != 1){
            this.listen = setTimeout(function(){
                self.getNewData();
            }, this.interval);
        } else{
            this.stop();
        }
    },
    stop: function(){
        clearTimeout(this.listen);
        this.listen = null;
    },
    getOldData: function(callback){
        var url = apiUrl.oldData + '?gameid=' + gameId + '&pid='+ nextId;
        if(this.isOver == 1){
            url += '&isover=1';
        }
        this.stop();
        var self = this;
        var success = function(data){
            self.start();
            if(data.status == 200){
                callback && callback();
                $('.live-list').append( _.template( $('#live').html(),{datas: data.data.liveText,type:2}) );
                nextId = data.data.nextpid;
            }else{
                callback && callback("finish");
            }
        };
        var error = function(){
            callback && callback("finish");
        };
        this.ajax(url, success, error);
    },
    getNewData: function( callback ){
        this.stop();
        if(this.isOver == 1){
            callback && callback("finish");
            return;
        }
        var self = this;
        var url = apiUrl.newData + '?gameid=' + gameId + '&pid='+ prevId;
        var success = function(data){
            self.start();
            if(data.status == 200){
                callback && callback();
                $('.live-list').prepend( _.template( $('#live').html(),{datas: data.data.liveText,type:1}) );
                prevId = data.data.prevpid;
                $('#J_scoreortime').html(data.data.scoreortime);
                $('#J_process').html(data.data.process);
                setTimeout(function(){
                    $('.live-list').find('li.new').removeClass('new');
                }, 1200);
            }else{
                callback && callback("finish");
            }
        };
        var error = function(){
            callback && callback("finish");
        };
        this.ajax(url, success, error);
    },
    ajax: function(url, success, error){
        $.ajax({
          type: 'POST',
          url: url,
          dataType: 'json',
          timeout: 3000,
          success: success,
          error: error || function(){}
        });
    }
};

refresh({
    contentEl: '#J_content',
    interval : 2000,
    // 向上
    refreshCallback: function(complete) {
        request.getNewData(complete);
    },
    // 向下
    loadingMoreCallback: function(complete) {
        request.getOldData(complete);
    }
});

request.start();

})();