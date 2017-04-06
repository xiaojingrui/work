var BaseView = require("./baseview");
var _ = require('underscore');
var Toast = require('common:widget/ui-toast/ui-toast.js');

var ViewRank = BaseView.extend({
  className: "rank",
  events: {
    
  },
  initialize: function() {
     this.superInit();
     this.tpl = _.template($("#J-rank-tpl").html());
  },
  render: function() {
     this.getRankData();
       
  },
  getRankData: function(fd){
     var self = this;
     $.ajax({
        url : "/fifadreamteam/ranktable",
        type: "get",
        dataType: "json",
        success: function(res){
          if(res.status == 200){
            self.renderPage(res.data);
          } else{
            Toast.toast(res.msg);
          }
        }
      });
  },
  renderPage: function(tmpData){
      var myData = [];
      for(var key in tmpData){
          var posData = {};
          posData.name = this.getChineseName(key);
          posData.members = [];
          $.each(tmpData[key], function(idx, item){
            posData.members.push(item);
          });
          myData.push(posData);
      }
      var html = this.tpl({data:myData});
      this.$el.html(html);
      this.$parentContainer.append(this.el);
      var self = this;
      setTimeout(function(){
         self.bindAni();
      }, 200);
  },
  bindAni: function(){
     $progress = this.$el.find(".progress .inner");
     $progress.each(function(){
          var width = $(this).data("percent");
          if(width){
             $(this).css("width", width);
          }
     });
  }
});

module.exports = new ViewRank();