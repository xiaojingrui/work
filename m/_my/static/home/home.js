$(function() {
    var dace = require("common:widget/ui/page-dace/page-dace.js");
    var pageId = __daceDataNameOfPage;

    /**
     * 接口地址
     */
    var apiUrl = {
        notification: "/notifications/json",
        ignore: "/my/remind/read"
    };


    /**
     * 消息
     * @type {{init: Function, bind: Function, ignore: Function}}
     */
    var MessageIgnore = {
        init: function(){
            var that = this;

            this.$message = $('#J_notificationList');

            if(!this.$message.length){
                return;
            }

            this.$buttonClose = this.$message.find('.J_buttonMessageClose');
            this.$link = this.$message.find('li a');

            this.bind();
        },
        bind: function(){
            var that = this;

            this.$buttonClose.on('tap', function(){
                that.ignore($(this));
                dace.send(pageId + "_msm_close");
            });

            this.$link.on('tap', function(){
                that.ignore($(this));

                var link = $(this).attr('href');

                if(/m.hupu.com\/bbs/.test(link)){
                    dace.send(pageId + "_5051");
                }else{
                    dace.send(pageId + "_7100");
                }

            });

            $('#J_buttonIgnoreAll').on('tap', function(){
                that.ignore();
            });
        },
        ignore: function(elem) {
            var that = this;

            if(elem){
                var $parent = elem.parents('li'),
                    id = $parent.attr('data-mid');
                    $parent.removeClass('no-view');
            }else{
                var id = -1;
                that.$message.find(".J_messageLi").removeClass('no-view');
                $(".message-unread-num").hide();
            }

            $.ajax({
                url: apiUrl.ignore,
                type: "GET",
                dataType: "json",
                data: {
                    id: id
                },
                success: function(data){
                    if(data.status == 200){
                        if(elem){
                            location.href = elem.data("href");
                        }else{
                            $('#J_buttonIgnoreAll').hide();
                        }
                    }
                }
            });
        }
    }



    /**
     * 我的版块
     * @type {{init: Function}}
     */
    var BoardList = {
        init: function(){
            var that = this;

            this.$wrap = $('#J_boardItem');

            if(!this.$wrap.length){
                return;
            }

            this.$content = this.$wrap.find('.board-list-wrap');
            this.$button = this.$wrap.find('.J_buttonUnfold');

            //
            if(this.$wrap.height() < this.$content.height()){
                this.$button.show();
                this.bind();
            }
        },
        bind: function() {
            var that = this;

            this.$button.on('click', function(){
                $(this).toggleClass('button-collapse');
                that.$wrap.toggleClass('board-item-collapse');
            });
        }
    }

    BoardList.init();
    MessageIgnore.init();
});
