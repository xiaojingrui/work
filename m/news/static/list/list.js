/*
 * @file 新闻列表页页面js.
 **/
!function(){
   var _ = require('underscore'),
       curUrl = $('.news-list').data('url');

   var stop=true,
       _page = 1,
       _totalPage = $('.news-list').data('pagecount'),
       refreshController = require("common:widget/ui/refresh/refresh.js");

   // 没有新闻时的处理
   if(!document.getElementById('J_newstitle')){
      
     refreshController({
          contentEl: '#J_content',
          hideFooter: true,
          // 向上
          refreshCallback: function(complete) {
              window.location.reload();
          },
        
          loadingMoreCallback: function(complete) {
              // if(!_page){
              //     $('.news-list ul').find('li').each(function(index, el) {
              //         if( $(el).css('display') == 'none' ){
              //             $(el).show();
              //         }
              //     });

              //     _page++;

              //     complete();

              //     return;
              // }
              if( _page+1 > _totalPage ){
                return false;
              }
              if(stop==true){
                  stop=false;
                  $.ajax({
                    type: 'POST',
                    url: curUrl+(_page+1),
                    // data to be added to query string:
                    dataType: 'json',
                    timeout: 3000,
                    success: function(data){
                      $(".news-list ul").append( _.template( $("#t2").html(),{datas: data.newsList}) );
                      _page++;
                      if(data.page == data.pageCount){
                          complete("finish");

                      }else{
                        complete();
                      }
                      stop=true;

                    },
                    error: function(xhr, type){
                      //console.log('Ajax error!');
                    }
                  })
                
              }
          }
     });
   }
}();



 


