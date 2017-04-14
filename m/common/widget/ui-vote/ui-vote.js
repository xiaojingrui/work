/**
 * @class Vote
 * @name  论坛投票
 * @author yuhongfei@hupu.com
 * @param target 目标dom // <span class="_vote" data-vote="xxx"></span>
 * @param data.voteId
 * @param data.type 纯展示\单选\多选. //1\2\3
 * @param data.list
 * @param data.count
 * @param data.title
 */

var Toast = require("common:widget/ui-toast/ui-toast.js");
//var dace = require("common:widget/ui/page-dace/page-dace.js");

var voteRequest = function(){
  var api =  {
    //getVote : "/getVote", //test
    //saveVote: "/saveVote", //test
    getVote : "https://snsvote.hupu.com/ShowInner.php",//线上
    saveVote: "https://m.hupu.com/bbs/thread/vote"  //线上
  };
  api.ready = true;
  return api;
};

var _sid = 0;

function Vote(target, data){
  this.target = target;
  this.voteId = data.voteId;
  this.type = data.type || 1;
  this.title = data.title || "";
  this.options  = data.list  || [];
  this.selected = data.voteSelected;
  this.optionMax = data.voteMax || 1;
  this.count = data.count || 0;
  this.groupName = this.getItemId();
  this.container = null;
  this.init();
}
/**
 * {
 *   type: 3,
 *    title: "展示投票的demo (可多选)",
 *    list:[{
 *      name:"选项一",
 *      value: 1,
 *        percent: 30,
 *       count: 10020
 *    },{
 *       name:"选项二选项二",
 *       percent: 70,
 *       value: 2,
 *       count: 30020
 *    }],
 *    count: 40040
 *  }
 */
Vote.getVote = function(voteId, callback){
  $.ajax({
    type: "GET",
    url : voteRequest.getVote,
    data: {
      voteid : voteId,
      showtype: "touch",
      uid: HPM.getUserId,
      t: (new Date().getTime())
    },
    dataType: "json",
    success: function(res){
      var voteOptions  = {};
      res.voteclass = parseInt(res.voteclass, 10) || 1;
      voteOptions.voteId = voteId;
      voteOptions.type  = !res.canVote ? 1 : (res.voteclass == 1) ? 2 : 3;
      voteOptions.title = res.title;
      voteOptions.voteMax = res.voteclass;
      voteOptions.list  = res.votetext;
      voteOptions.count = parseInt(res.votepnum, 10);
      voteOptions.voteSelected = res.voteInfo ? res.voteInfo.split(",") : [];
      callback(voteOptions);
    }
  });
};

Vote.postVote = function(voteId, votes, callback){
  $.ajax({
    type: "GET",
    url : voteRequest.saveVote,
    async: false,
    data: {
      voteid : voteId,
      vote : votes.join("|"),
      uid: HPM.getUserId
    },
    dataType: "jsonp",
    jsonp: "jsoncallback",
    success: function(res){
      if(res && res.code == 1){
        callback && callback();
      }else{
        if(res && res.info){
          Toast.toast(res.info);
        }
      }
    }
  });
}

Vote.prototype = {
  init: function(){
    this.createContainer();
    this.render();
    this.bindEvent();
  },
  getItemId: function(){
    return "votegroup_" + (++_sid);
  },
  render: function(){
     switch(this.type){
       case 1:
        this.createShow();
        break;
       case 2:
        this.createForm("single");
        break;
       case 3:
        this.createForm("multiselect");
        break;
     }
  },
  createShow: function(){
    var list = [];
    var self = this;
    this.options.forEach(function(item, index){
        var percent = self.count > 0 ? (item.num * 100 / self.count).toFixed(1) : 0;
        var isSelected = ~$.inArray(index+1+"", self.selected);
        var title = item.title + (isSelected ? "（已选）":"");
        list.push(
          '<li>',
            '<div class="vote-option-title">',title,'</div>',
            '<div class="vote-detail">',
              '<div class="vote-progress">',
                '<div class="vote-inner" style="width:', percent ,'%"></div>',
              '</div>',
              '<div class="vote-count">',item.num,'票</div>',
              '<div class="vote-percent">', percent,'%</div>',
            '</div>',
          '</li>'
      )
    });
    var html = ["<ul>", list.join(""), "</ul>"].join("");
    this.$content.append(html);
  },
  createForm: function(type){
    var inputType = type === "single" ? "radio" : "checkbox";
    var self = this;
    var list = [];
    this.options.forEach(function(item, idx){
        var groupId = self.getItemId();
        var cls = idx != self.options.length - 1 ? "vote-selected":"";
        list.push(
          '<li class="', cls ,'">',
            '<input type="', inputType ,'" value="', (idx + 1) ,'" name="', self.groupName ,'" id="', groupId,'" class="with-gap">',
            '<label for="', groupId ,'">', item.title ,'</label>',
          '</li>'
      )
    });
    var html = ["<ul>", list.join(""), "</ul>"].join("");
    this.$content.append(html);
  },
  createContainer: function(){
    var bottomText = ["共有"+ this.count +"人投票（你已投票）", "投票"][this.type > 1 ? 1 : 0];
    var bottomCls = this.type === 1 ? "vote-disabled" : "";
    var titleLast = this.optionMax > 1 ? "（多选）": "（单选）";
    this.container = document.createElement("div");
    this.$container = $(this.container).addClass("vote-wrapper");
    this.$content = $("<div>").addClass("vote-main");
    this.$title = $("<h2>").text(this.title + titleLast);
    this.$bottom = $("<div>").addClass("vote-bottom " + bottomCls).text(bottomText);

    this.$content.append(this.$title);
    this.$container.append(this.$content);
    this.$container.append(this.$bottom);
    this.target.parentNode.replaceChild(this.container, this.target);
  },
  bindEvent: function(){
    var evtName = 'ontouchstart' in window ? 'touchend' : 'click';

    if(this.type == 1){
      return;
    }
    var self = this;
    this.$bottom.on("click", function(e){
        var handler = function(){
            var voteAnswers = [];
            self.$container.find("input[name="+ self.groupName +"]").each(function(idx, item){
              if(item.checked){
                voteAnswers.push( item.value );
              }
            });
            if(voteAnswers.length){
              if(voteAnswers.length <= self.optionMax ){
                //提交投票后, 替换当前的投票.
                Vote.postVote(self.voteId, voteAnswers, function(){
                    //dace.send("vote_" + voteRequest.type);
                        Vote.getVote(self.voteId, function(data){
                            new Vote(self.getTarget(), data);
                        });
                });
              } else{
                Toast.toast("无法提交，最多只能选择"+ self.optionMax + "项");
              }
            }else{
              Toast.toast("请选择投票选项");
            }
        }
        if(HPM.isLogin == "1"){
          handler();
        } else{
          HPM.popLogin();
        }
    });
  },
  getTarget: function(){
     return this.container;
  }
}

module.exports = function(elem){
   var vId = elem ? elem.getAttribute("data-vote") : '';
   if(vId){
       //初始化请求
       if(!voteRequest.ready){
         voteRequest = voteRequest();
       }
       Vote.getVote(vId, function(data){
           var voteInstance = new Vote(elem, data);
       });
   }
};
