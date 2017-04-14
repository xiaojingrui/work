var pager = require("common:widget/ui/page/page.js");

var showComment = {
    init: function() {
        this.btn = $('.comment-control');
        this.bind();
        if(HPM.author){
            setTimeout(function() {
               $(".replay_all").find(".title").get(0).scrollIntoView(); 
           },300)
            $(".ad-hide").hide();
        }
    },
    bind: function() {
        var self = this;
        this.btn.on('click', function() {
            if($(this).hasClass('all-commment')){
                //self.changeUrl();
                location.href = HPM.Url;
            }else{
                //self.changeUrl("1");
                location.href = HPM.baseUrl + "/bbs/" + HPM.tid +"_" + HPM.puid + ".html"; 
            }
            
        })
    },
    changeUrl: function(name) {
        //location.href = HPM.baseUrl+'/bbs/'+name+'/'+HPM.tid+'-1.html';
        if(name){
           location.href = HPM.baseUrl + "/bbs/" + HPM.tid +"_" + HPM.puid + ".html"; 
        }else{
           location.href = HPM.Url;
        }
        
    }
};

module.exports = showComment;
