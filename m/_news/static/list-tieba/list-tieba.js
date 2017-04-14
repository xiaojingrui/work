/*
 * @file 贴吧新闻列表页点击加载更多
 **/
!function(){
    var _ = require('underscore');

    var MoreList = {
        init: function() {
            this.$wrap = $('.news-list');
            this.$button = $('#J_buttonViewMore');

            if (!this.$wrap.length && !this.$button.length) {
               return;
            }

            this.$loading = $('.preloader-loading');

            this.inStop = true;
            this.pageCount = 2;
            this.totalPage = parseInt(this.$wrap.data('pagecount'));
            this.apiUrl = this.$wrap.data('url');

            this.bind();
        },
        bind: function() {
            var that = this;

            this.$button.tap(function() {
                that.getList();
            });
        },
        getList: function() {
            var that = this;

            if (this.pageCount > this.totalPage || !this.inStop) {
                return;
            }

            this.inStop = false;
            this.$loading.show();
            this.$button.hide();

            $.ajax({
                type: 'POST',
                url: this.apiUrl + this.pageCount + location.search,
                dataType: 'json',
                timeout: 3000,
                success: function(data){
                    $(".news-list ul").append( _.template( $("#t2").html(),{datas: data.newsList}) );

                    if (that.pageCount >= that.totalPage) {
                        $('.more-button-inner').hide();
                    }

                    that.pageCount++;
                    that.inStop = true;
                    that.$loading.hide();
                    that.$button.show();

                },
                error: function(xhr, type){
                }
            })
        }
    }

    $(function(){
        MoreList.init();
    });

}();

