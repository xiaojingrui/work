$(function() {
    var bbsStar = {
        init: function() {
            this.starBtn = $('.focus');
            this.bind();
        },
        bind: function() {
            var self = this;

            this.starBtn.on('click', function() {
                if(!HPM.isLogin){
                    HPM.popLogin();
                    return;
                }
                var _del = $(this).hasClass('ing') ? 1 : 0;
                var $this = $(this);
                $.ajax({
                    url: '/bbs/forumcollection?fid='+HPM.fid+'&del='+_del,
                    type: 'GET',
                    dataType: 'json',
                    success: function(data){
                        if(data.code == 1){
                            if(!_del){
                                $this.addClass('ing').html('已关注');
                            }else{
                                $this.removeClass('ing').html('+关注');
                            }
                        }else if(data.code == -10){
                            HPM.popLogin();
                        }
                    }
                })
            })
        }

    }

    bbsStar.init();

})
