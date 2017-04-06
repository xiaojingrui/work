var BaseView = require("./baseview");
var _ = require('underscore');

var ViewStep = BaseView.extend({
  pageName: "step2",
  className: "step-page",
  pageStep: 2,
  events: {
    "click .icon": "chooseHandler",
    "click .next": "gotoNext",
    "click .prev": "gotoPage",
    "click .head": "showMember"
  },

  initialize: function() {
     this.superInit();
     this.tpl = _.template($("#J-step2-tpl").html());
  },
  render: function() {
     var self = this;
     if(this.preload) return;
     this.getStepMemberData(this.pageStep, function(data){
        self.preload = true;
        var memberData = {
          data : data.position[0],
          postion: "MIDFIELD"
        };
        var memberHtml = self.memberTpl(memberData);

        var html = self.tpl({member : memberHtml});
        self.$el.html(html);
        self.$parentContainer.append(self.el);
        self.$chooseCount = self.$el.find(".choose .num");
     });
       
  },
  updateChooseCount: function(count){
    this.$chooseCount.text(count);
  }
});

module.exports = new ViewStep();
