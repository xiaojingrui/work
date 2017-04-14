var commonPager = require("common:widget/ui/page/page.js");
var _ = require("underscore");

var pager = {
	init: function (){
		var $container = $("#J-page");
		if($container.size()){
			commonPager({
                isAjax: true,
                container:"#J-page",
                currntPage: 1,
                pageCount: HPM.pageCount,
                indexLink: "/news/"+ HPM.tid +".html",
                pageChange: function(page){
                    var url = HPM.curUrl + HPM.tid + '-' + page +'.html';

                    $.ajax({
                        url: url,
                        type: "POST",
                        dataType: 'json',
                        success: function(data) {
                            if ( data.status === 200 ) {
                               var html = _.template( $("#more-reply-template").html(), {datas: data.commentsInfo} );
                               $('#J_replyContent').find('.newest-reply .reply-inner').html( html );
                               $(".newest-reply").get(0).scrollIntoView();
                                // 回复分页大于5页，显示下载APP
                               if ( page === 5 && parseInt(data.pageCount) > 5 ) {
                                   $('#J_replyDownKanApp').removeClass('fn-hide');
                               }
                           }
                        }
                    });
                }
            });
		}
	}
};

module.exports = pager;