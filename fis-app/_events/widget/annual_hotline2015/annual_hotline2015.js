var liveCommon = require("events:widget/annual_common/annual_common.js")
var _ = require("underscore");

function formatNum(count){
  return count < 10 ? "0" + count : count;
}

var hotline = {
  init: function(){
    this.pageOutContainer = $("#J-bd-container");
    this.pageContainer = $("#J-pager-hotline");
    this.container = $("#J-hotline-container");

    this.tpl = $("#J-hotline-tpl").html();

    this.msgs = [];

    var winHeight = $(window).height();
    this.pageOutContainer.css({
        "height": winHeight
    });
    this.pageContainer.css({
        "min-height": winHeight
    });

    liveCommon.init()
    this.bindLive()

    this.showMsg();
  },
  showMsg: function(){
     var self = this;
     var msg = this.getData();
     if(msg){
         this.append(msg);
     }

     var speed = this.getSpeed();
     setTimeout(function(){
       self.showMsg();
     }, speed);
  },
  getSpeed: function(){
    var speed = 1000;
    var msgLength = this.msgs.length;

    if(msgLength > 50){
       return speed / 8;
    }else if(msgLength > 30){
       return speed / 4;
    }else if(msgLength > 20){
       return speed / 2;
    } else if(msgLength > 10){
       return speed;
    } else if(msgLength > 5){
       return speed * 2;
    } else if(msgLength > 2){
       return speed * 4;
    }
  },
  bindLive: function(){
    var self = this
    liveCommon.on("hotline", function(data){
        if(data.cnt){
            self.pushData({
                type: 1,
                username: data.un,
                content: data.cnt
            })
        }
    })

    liveCommon.on("zhuboline", function(data){
        if(data.cnt){
            self.pushData({
                type: 2,
                username: data.an,
                content: data.cnt,
                col: 'yellow'
            })
        }
    })

    liveCommon.on("gift", function(data){
        self.pushData({
            type: 2,
            username: data.un,
            content: data.cnt,
            col: 'yellow'
        })
    })

  },
  append: function(data){
    var html = _.template(this.tpl, data);
    var winHeight = $(window).height();
    var contentHeight = this.container.height();
    this.container.append(html);

    if(contentHeight > 3000){
      this.container.find("li").eq(0).remove();
      contentHeight = this.container.height();
    }

    if(contentHeight > winHeight){
      this.container.css(
          "margin-top", (-(contentHeight - winHeight) +"px")
      );
    }
  },
  pushData: function(msg){
     var now = new Date();
     msg.date = [formatNum(now.getHours()), formatNum(now.getMinutes()), formatNum(now.getSeconds())].join(":")
     this.msgs.push(msg)
  },
  getData: function(){
     var shiftMsg = this.msgs.pop() || null;
     return shiftMsg
  }
}

module.exports = hotline;
