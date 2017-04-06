import {checkLogin, getInfo} from './app'
import dace from './dace'
import $ from 'common/zepto'
let _sid = 0;
let scope = null

let voteRequest = (type = 'bbs', typeid, getVote, saveVote) => {
  let api = {};
  api.getVote = getVote;
  api.saveVote = saveVote;
  api.type   = type;
  api.typeid = typeid;
  api.ready = true;
  return api
};

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
  voteRequest.getVote.updateQuery({voteid: voteId}).execute(({data})=>{
      let  voteOptions  = {};
      let resData = data.result;
      resData.voteclass = parseInt(resData.voteclass, 10) || 1;
      voteOptions.voteId= voteId;
      voteOptions.type  = !resData.canVote ? 1 : (resData.voteclass == 1) ? 2 : 3;
      voteOptions.title = resData.title;
      voteOptions.voteMax = resData.voteclass;
      voteOptions.list  = resData.votetext;
      voteOptions.count = parseInt(resData.votenum, 10);
      voteOptions.voteSelected = resData.voteInfo ? resData.voteInfo.split(",") : [];
      callback(voteOptions);
  })
}
Vote.postVote = function(voteId, votes, callback){
  let params = {
                voteid : voteId,
                typeid : voteRequest.typeid,
                vote   : votes.join("|")
                };

  voteRequest.saveVote.bind(params).execute(({data})=>{
      if(data && data.result && data.result.status == 1){
        callback && callback();
      }else{
        if(data && data.error && data.error.text){
          scope.$emit("toast", data.error.text);
        }
      }
  })
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
    let list = [];
    let self = this;
    this.options.forEach(function(item, index){
        let percent = self.count > 0 ? (item.num * 100 / self.count).toFixed(1) : 0;
        let isSelected = ~$.inArray(index+1+"", self.selected);
        let title = item.title + (isSelected ? "（已选）":"");
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
    let html = ["<ul>", list.join(""), "</ul>"].join("");
    this.$content.append(html);
  },
  createForm: function(type){
    let inputType = type === "single" ? "radio" : "checkbox";
    let self = this;
    let list = [];
    this.options.forEach(function(item, idx){
        let groupId = self.getItemId();
        let cls = idx != self.options.length - 1 ? "vote-selected":"";
        list.push(
          '<li class="', cls ,'">',
            '<input type="', inputType ,'" value="', (idx + 1) ,'" name="', self.groupName ,'" id="', groupId,'" class="with-gap">',
            '<label for="', groupId ,'">', item.title ,'</label>',
          '</li>'
      )
    });
    let html = ["<ul>", list.join(""), "</ul>"].join("");
    this.$content.append(html);
  },
  createContainer: function(){
    let bottomText = ["共有"+ this.count +"人投票（你已投票）", "投票"][this.type > 1 ? 1 : 0];
    let bottomCls = this.type === 1 ? "vote-disabled" : "";
    let titleLast = this.optionMax > 1 ? "（多选）": "（单选）";
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
    if(this.type == 1){
      return;
    }
    let self = this;
    this.$bottom.on("click", function(e){
        let handler = function(){
            let voteAnswers = [];
            self.$container.find("input[name="+ self.groupName +"]").each(function(idx, item){
              if(item.checked){
                voteAnswers.push( item.value );
              }
            });
            if(voteAnswers.length){
              if(voteAnswers.length <= self.optionMax ){
                //提交投票后, 替换当前的投票.
                Vote.postVote(self.voteId, voteAnswers, function(){
                    dace.send("vote_" + voteRequest.type);
                    Vote.getVote(self.voteId, function(data){
                        new Vote(self.getTarget(), data);
                    });
                });
              } else{
                scope.$emit("toast", `无法提交，最多只能选择${self.optionMax }项`);
              }
            }else{
              //Toast.toast("请选择投票选项");
              scope.$emit("toast", "请选择投票选项");
            }
        }
        let na = getInfo()
        if(na.islogin){
          handler();
        } else{
          checkLogin(function(){
            Vote.getVote(self.voteId, function(data){
                new Vote(self.getTarget(), data);
            });
          });
        }
    });
  },
  getTarget: function(){
     return this.container;
  }
}

module.exports = (option) => {
   let vId = option.elem ? option.elem.getAttribute("data-vote") : '';
   if(vId){
       let scope = option.scope
       //初始化请求
       if(!voteRequest.ready){
         voteRequest = voteRequest(option.type, option.typeid, option.getVote, option.saveVote);
       }
       Vote.getVote(vId, function(data){
           let voteInstance = new Vote(option.elem, data);
       });
   }
}
