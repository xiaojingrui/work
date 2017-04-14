var dace = require("common:widget/ui/page-dace/page-dace.js");
var pageId = __daceDataNameOfPage;

var SupportTeam = {
    init: function(){
        this.balBtn = $('.bal-btn .btn');
        this.homeBtn = $('.home-btn .btn');
        this.awayBtn = $('.away-btn .btn');
        this.matchId = $('.balance-info').attr("match-id");
        this.tips = $('.tips');
        this.teamIndex = 0;
        this.status = $('.match-banner').data('status');
        this.bind();

    },
    bind: function(){
       var that = this;
       that.balBtn.click(function(event) {
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }
            var $this = $(this),
                _index = ( $(this).parent().hasClass('home-btn') ? 1 : 2);
            
            var daceNeed = "";

            if(that.status == "3"){
                var _url = "/g/nba/apiUserForcast?matchId="+that.matchId+"&teamFlag="+_index ;
                daceNeed = pageId + "_forecast";
            }else{
                var _url = "/g/nba/apiUserVote?matchId="+that.matchId+"&teamFlag="+_index ;
                daceNeed = pageId + "_for";
            }
            $.ajax({
                url: _url,
                type: "POST",
                dataType: 'json',
                success: function(data) {
                    if(data.status == 200){
                        dace.send(daceNeed);

                        $this.find('span').addClass('cur').cssEnd(function(){
                            $(this).removeClass('cur');
                        });
                        // $('.home-rate').html(data.data.homeWith);
                        $('.home-rate').html(data.data.homeWidth);

                        $('.away-rate').html(data.data.awayWidth);
                        $('.home-bar').css('width',data.data.homeWidth);
                        that.showTips(data.msg);
                    }else{
                        that.showTips(data.msg);
                    }
                   

                }
            })

            
       });
    },
    showTips: function(str){
        var that = this;
        this.tips.html(str).show();
        setTimeout(function(){
            that.tips.hide();
        },1000);
    }
}
SupportTeam.init();

$.fn.cssEnd = function ( callback ){
    var EventAnimateEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
    this.one(EventAnimateEnd , callback);
    return this;
};