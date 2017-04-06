var BaseView = require("./baseview");
var _ = require('underscore');

var ViewStep = BaseView.extend({
  pageName: "step4",
  className: "step-page",
  pageStep: 4,
  events: {
    "click .icon": "chooseHandler",
    "click .next": "gotoNext",
    "click .prev": "gotoPage",
    "click .head": "showMember"
  },

  initialize: function() {
     this.superInit();
     this.tpl = _.template($("#J-step4-tpl").html());
  },
  render: function() {
     var self = this;
     if(this.preload) return;
     this.getStepMemberData(this.pageStep, function(data){
        self.preload = true;
        var member1Data = {
          data : data.position[0],
          postion: "LEFTWINGBACK"
        };
        var member2Data = {
          data : data.position[1],
          postion: "RIGHTWINGBACK"
        };
        var member1Html = self.memberTpl(member1Data);
        var member2Html = self.memberTpl(member2Data);

        var html = self.tpl({member1 : member1Html, member2: member2Html});
        self.$el.html(html);
        self.$parentContainer.append(self.el);
     });
       
  },
  updateChooseCount: function(count, pos){
    this.$el.find("." + pos.toLowerCase()).text(count);
  }
});

module.exports = new ViewStep();
