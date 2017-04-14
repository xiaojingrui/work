/**
 * @file video page script
 * @author yuhongfei@hupu.com
 */
(function(){
  var refreshController = require("common:widget/ui/refresh/refresh.js");

  var current = 5;
  var pageNum = 20;

  refreshController({
        isRefresh: false,
        finishText:"您太努力了，都拉到视频最后一页了",
        contentEl: '#J_content',
        loadingMoreCallback: function(complete) {

            var pageCount = parseInt(this.$content.attr("data-count"), 10);

            if ( current >= pageCount) {
                complete("finish");
            } else{
               current += pageNum;
               this.$content.find("li").each(function(idx){
                  if(idx <= current){
                      $(this).show();
                  }
               });  
               complete();
            }
        }
    });
})();