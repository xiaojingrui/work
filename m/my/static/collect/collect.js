/**
 * @file 用户收藏的js
 */
!function(){
    "use strict";
    var Tips = require('common:widget/ui/tips/tips.js');
    var pageId = __daceDataNameOfPage;
    /**
     * 接口地址
     */
    var apiUrl = {
        // 回帖
        post: '/bbs/threads'
    };

    var Collect = {
        init: function() {
            var that = this;

            this.$button = $('#J_buttonCollect');

            if(!this.$button.length) {
                return;
            }

            this.$list = $('#J_collectWrap li');

            this.bind();
        },
        bind: function() {
            var that = this;

            // 编辑按扭
            this.$button
                .off('click')
                .on('click', function() {

                    $(this).toggleClass('showOn');

                    if($(this).hasClass('showOn')){
                        $(this).text('取消').attr('dace-node',pageId + '_cancel');
                        that.render();
                    }else{
                        $(this).text('编辑').attr('dace-node',pageId + '_edit');
                        that.cancel();
                    }
                });

            // 选中/取消选中
            this.$list
                .on('click', function() {
                    $(this).toggleClass('on');
                    $('.del-num').html( $('#J_collectWrap li.on').length );
                })

            

        },
        /**
         * 渲染
         */
        render: function() {
            var that = this;
            var tpl_tips = [
                '<div class="select-fn-tips">',
                    '<div class="fn-left">',
                        '<label class="icon-selected"></label>',
                        '已选中<span class="del-num">0</span>个选项',
                    '</div>',
                    '<a href="javascript:" dace-node=' + pageId + '"_delete" class="button-delete">删除</a>',
                '</div>'
            ].join('');

            this.$list.append('<div class="select-black-bg"><div class="select-icon"></div></div>');

            $('body')
                .addClass('editor-body')
                .append(tpl_tips);
                
            $('.m-page').append('<div class="select-black-bg"></div>');
            $('.m-footer-row').append('<div class="select-black-bg"></div>');

            this.submitDel();
            
        },
        /**
         *  取消
         */
        cancel: function() {
            this.$list.removeClass('on');

            $('.select-black-bg').remove();

            $('body')
                .removeClass('editor-body')
                .find('.select-fn-tips').remove();
        },

        submitDel: function(){
            // 提交删除
            $('.button-delete').on('click', function() {
                var listArr = '',
                    _list = $('#J_collectWrap li.on'),
                    len = _list.length,
                    _data = {};

                if(len <= 0){
                    alert("还未选中任何帖子");
                }

                for (var i = 0; i < len; i++){
                    var str = '' ;
                    if(i == len-1){
                        str = $(_list[i]).data('tid') ;
                    }else{
                        str = $(_list[i]).data('tid') + ',';
                    }
                    listArr += str ;
                }

                _data.uid = HPM.uid;
                _data.tid = listArr;
                _data.do = 'del';

                $.ajax({
                    url: '/my/usercollectedthreads',
                    type: 'GET',
                    dataType: 'json',
                    data: _data,
                    success: function(data) {
                        if(data.status == 200){
                            Tips("删除成功");
                            setTimeout(function(){
                                location.href = location.href ;
                            },800);
                            
                        }else{
                            Tips(data.msg);
                        }
                    }
                })
                
            })
        }
    }

    $(function(){
        Collect.init();
    })
}();