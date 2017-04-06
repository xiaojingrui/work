var Backbone = require("common:widget/lib/backbone/backbone.js");
var _ = require('underscore');
var Toast = require('common:widget/ui-toast/ui-toast.js');
var dace = require("common:widget/ui-dace/ui-dace.js");

var views = [],
  membersData = {},
  chineseName = {
    "FORWARD": "前锋",
    "MIDFIELD": "中场",
    "CENTERBACK": "中后卫",
    "LEFTWINGBACK": "左后卫",
    "RIGHTWINGBACK": "右后卫",
    "GOALKEEPER": "门将",
    "COACH": "教练"
  },
  data = [{
    "position": "FORWARD",
    "max": 3,
    "players": []
  }, {
    "position": "MIDFIELD",
    "max": 3,
    "players": []
  }, {
    "position": "CENTERBACK",
    "max": 2,
    "players": []
  }, {
    "position": "LEFTWINGBACK",
    "max": 1,
    "players": []
  }, {
    "position": "RIGHTWINGBACK",
    "max": 1,
    "players": []
  }, {
    "position": "GOALKEEPER",
    "max": 1,
    "players": []
  }, {
    "position": "COACH",
    "max": 1,
    "players": []
  }];

var BaseView = Backbone.View.extend({
  tagName: 'div',
  className: '',
  superInit: function() {
    this.$parentContainer = $("#container");
    this.memberContainer = $("#J-step1-member-container");
    this.memberTpl = _.template($("#J-member-tpl").html());
    this.dialogTpl = _.template($("#J-dialog-tpl").html());
    views.push(this);
  },
  show: function() {
    $(views).each(function(idx, view) {
      view.hide();
    });
    this.render();
    this.$el.css("display","block");
  },
  hide: function() {
    this.$el.css("display","none");
  },
  checkDataComplete:function(){
     var step = this.pageStep;
     var index = 0;
     if(step && step > 1){
        for(var i =0;i<data.length;i++){
          if(data[i].players.length < data[i].max){
            index = i;
            break;
          }
        }
        if(index < step){
            location.hash = "step" + index;
        }
     }
  },
  getChineseName: function(pos){
    return chineseName[pos];
  },
  pushMember: function(stepMembers){
    $.each(stepMembers, function(idx, members){
       $.each(members, function(id, member){
          membersData[id] = member;
       }); 
    });
  },
  getMember: function(id){
    return membersData[id];
  },
  getStepMemberData: function(step, callback){
     var self = this;
     $.ajax({
        //url : "/fifadreamteam/playersAjax_"+step,  //本地测试
        url : "/fifadreamteam/playersAjax",
        type: "get",
        dataType: "json",
        data: {
          "step": step
        },
        success: function(res){
          if(res.status == 200){
            self.pushMember(res.data.position);
            callback && callback(res.data);
          } else{
            Toast.toast(res.msg);
          }
        }
      });
  },
  getStepDataByName: function(name) {
    var stepData;
    for (var i = 0; i < data.length; i++) {
      if (data[i].position.toLowerCase() === name.toLowerCase()) {
        stepData = data[i];
        break;
      }
    }
    return stepData;
  },
  queuePush: function(pos, id) {
    var stepData = this.getStepDataByName(pos);

    if (typeof stepData != "undefined") {
      if (stepData.players.length < stepData.max) {
        stepData.players.push(id);
        this.updateChooseCount(stepData.players.length, pos);
        return true;
      } else {
        Toast.toast("选择" + stepData.max + "名" + this.getChineseName(pos) + "才可以进入下一步哦！");
      }
    }
    return false;
  },
  queuePop: function(pos, id) {
    var stepData = this.getStepDataByName(pos);
    if (typeof stepData != "undefined") {
      var index = _.indexOf(stepData.players, id);
      if (stepData.players.length > 0 && index != -1) {
        stepData.players.splice(index, 1);
        this.updateChooseCount(stepData.players.length, pos);
        return true;
      }
    }
    return false;
  },
  chooseHandler: function(e) {
    var target = $(e.currentTarget);
    var position = target.data("position");
    var id = target.data("id");

    if (target.hasClass("unchecked")) {
      if(this.queuePush(position, id)){
        target.siblings(".head").removeClass("unchecked-head").addClass("checked-head");
        target.removeClass("unchecked").addClass("checked");
      }
    } else{ 
      if(this.queuePop(position, id)) {
        target.siblings(".head").removeClass("checked-head").addClass("unchecked-head");
        target.removeClass("checked").addClass("unchecked");
      }
    }
  },
  checkStep: function(pos, callback) {
    var stepData = this.getStepDataByName(pos);
    if (typeof stepData != "undefined") {
      if (stepData.players.length == stepData.max) {
        callback && callback();
        return true;
      } else {
        Toast.toast("选择" + stepData.max + "名"+  this.getChineseName(pos) + "才可以进入下一步哦！");
      }
    }
    return false;
  },
  submitChoose: function(){
    if(this.checkStep("GOALKEEPER") && this.checkStep("COACH")){
        $.ajax({
          url : "/fifadreamteam/setmychosen",
          type: "post",
          dataType: "json",
          data: {
            "mychosen": data,
            "fd": GM.fd,
            "t": GM.t
          },
          success: function(res){
            if(res.status == 200){
              var href = location.href;
              href = href.substring(0, href.indexOf("?"));
              location.href = href + "?fd="+ GM.fd + "#result";
                
            } else{
              Toast.toast(res.msg);
            }
          }
        });
    }
  },
  gotoNext: function(e){
      var target = $(e.currentTarget);
      var action = target.data("href");
      switch(this.pageStep){
        case 1:
          this.checkStep("FORWARD", function(){
            location.hash = action;
          });
          break;
        case 2:
          this.checkStep("MIDFIELD", function(){
            location.hash = action;
          });
          break;
        case 3:
          this.checkStep("CENTERBACK", function(){
            location.hash = action;
          });
          break;
        case 4:
          if(this.checkStep("LEFTWINGBACK") && this.checkStep("RIGHTWINGBACK")){
            location.hash = action;
          }
          break;
      }
  },
  gotoPage: function(e){
      var target = $(e.currentTarget);
      var action = target.data("href");
      location.hash = action;
      dace.send("201601fifadreamteam_" + action);
  },
  showMember: function(e){
     var target = $(e.currentTarget);
     var pid = target.data("id");
     var self = this;

     var memberData = this.getMember(pid);
         memberData.id = pid;
         memberData.Honor = memberData.Honor || "";
     var html = this.dialogTpl(memberData);

     if(!this.mask){
       this.mask = $("<div class='mod-mask'></div>");
       this.dialogContent = $("<div class='mod-showBox'></div>");
       $("body").append(this.mask);
       $("body").append(this.dialogContent);
       this.mask.on("click", function(){
            self.hideMember();
            self.overFlow(0);
       });
       $("body").delegate(".mod-showBox .close", "click", function(){
            self.hideMember();
            self.overFlow(0);
       });
     }
     this.dialogContent.html(html);
     this.mask.show();
     this.dialogContent.show();
     self.overFlow(1);

     var width = this.dialogContent.width();
     var height = this.dialogContent.height();
     var winWidth = $(window).width();
     var winHeight = $(window).height();
     var left =  (winWidth - width) / 2;
     var top = (winHeight - height) / 4;
     this.dialogContent.css({"left":left,"top":top});
  },
  hideMember: function(){
     this.mask.hide();
     this.dialogContent.hide().empty();
  },
  overFlow: function(bon){
    if(bon==1){
      $("body").css({
        "height": $(window).height(),
        "overflow": "hidden"
      });
    }else{
      $("body").css({
        "height": "auto",
        "overflow": "auto"
      });
    }
  }
});
module.exports = BaseView;