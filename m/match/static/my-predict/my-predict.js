(function() {
    var _ =  require('underscore'),
        refresh = require("common:widget/ui/refresh/refresh.js");

    var apiUrl = {
        oldData : '/predict/page'
    };
    
    var request = {
        page: 2,
        uid: HPM.userid,
        mindate: HPM.mintime,
        more: HPM.more,
        getOldData: function(callback, type) {
            var url = apiUrl.oldData;
            var self = this;
            var data = {
                "uid": this.uid,
                "page": this.page,
                "mindate": this.mindate
            };
            var success = function(data){
                if(data.code == 200){

                    $('#J_content').append(_.template( $("#predict-histoty").html(), {datas: data.data,isself: HPM.isself}));
                    self.page ++;
                    self.mindate = data.mindate;

                    if( data.more ){
                        callback && callback();
                    }else{
                        if(type){
                            self.more = 0;
                            return false;
                        }
                        callback && callback("finish");
                    }
                }else{
                    if(type){
                        self.more = 0;
                        return false;
                    }
                    callback && callback("finish");
                }
            };
            var error = function(){
                callback && callback("finish");
            };
            this.ajax(url, data, success, error);
        },
        ajax: function(url, data, success, error){
            $.ajax({
                type: 'POST',
                url: url,
                dataType: 'json',
                data: data,
                timeout: 3000,
                success: success,
                error: error || function(){}
            });
        }

    };

    // 检查同步接口的数据是不是够滚动加载的高度（判断有没有5条）
    (function() {
        function check() {
            
            var container = $('#J_content'),
                item = '.prediction-info';
            if(container.find(item).length <= 4){
                request.getOldData(check, 1);
            }else{
                return;
            }
        }
        if(HPM.more == 1){
            check();
        }
        
    })();

    refresh({
        isRefresh: false,
        contentEl: '#J_recordWrap',
        // 向下
        loadingMoreCallback: function(complete) {
            if(request.more == 1){
                request.getOldData(complete);
            }else{
                complete('finish');
            }
        }
    });


})()