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

var voteRequest = function(type){
  var base = "/1/7.0.9.0";
  type = type || "bbs";
  var api = null;
  switch(type){
    case "bbs":
      api =  {
        getVote : base + "/threads/voteInfo",
        saveVote: base + "/threads/vote"
      };
      break;
    case "news":
      api = {
        getVote : base + "/news/voteInfo",
        saveVote: base + "/news/vote"
      }
      break;
  }
  api.ready = true;
  return api
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
      client : "x"
    },
    dataType: "json",
    success: function(res){
      var  voteOptions  = {};
      var resData = res.result;
      resData.voteclass = parseInt(resData.voteclass, 10);
      voteOptions.voteId= voteId;
      voteOptions.type  = 1;
      voteOptions.title = resData.title;
      voteOptions.voteMax = resData.voteclass;
      voteOptions.list  = resData.votetext;
      voteOptions.count = parseInt(resData.votenum, 10);
      voteOptions.voteSelected = resData.voteInfo ? resData.voteInfo.split(",") : [];
      callback(voteOptions);
    }
  });
}

Vote.prototype = {
  init: function(){
    this.createContainer();
    this.render();
  },
  getItemId: function(){
    return "votegroup_" + (++_sid);
  },
  render: function(){
     this.createShow();
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
  createContainer: function(){
    var bottomText = ["已有"+ this.count +"人投票", "投票"][this.type > 1 ? 1 : 0];
    var bottomCls = this.type === 1 ? "vote-disabled" : "";
    var titleLast = this.voteMax > 1 ? "（多选）": "（单选）";
    this.container = document.createElement("div");
    this.$container = $(this.container).addClass("vote-wrapper");
    this.$content = $("<div>").addClass("vote-main");
    this.$title = $("<h2>").text(this.title + titleLast);
    this.$bottom = $("<div>").addClass("vote-bottom " + bottomCls).text(bottomText);

    this.$content.append(this.$title);
    this.$container.append(this.$content);
    this.$container.append(this.$bottom);
    this.target.parentNode.replaceChild(this.container, this.target);
  }
}

module.exports = function(type, elem){
   var vId = elem ? elem.getAttribute("data-vote") : '';
   if(vId){
       //初始化请求
       if(!voteRequest.ready){
         voteRequest = voteRequest(type);
       }
       Vote.getVote(vId, function(data){
           var voteInstance = new Vote(elem, data);
       });
   }
};
