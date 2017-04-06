var BaseView = require("./baseview");

var ViewIndex = BaseView.extend({
  pageName: "index",
  events: {
    "click .btn": "gotoPage"
  },

  initialize: function() {
    this.superInit();
    this.tpl = $("#J-index-tpl").html();
  },
  render: function() {
    if(this.preload) return;
    this.$el.html(this.tpl);
    this.$parentContainer.append(this.el);
    this.preload = true;

    var iWidth = $(window).width();
    if(iWidth > 750){
      iWidth = 750;
    }

    $(".index").css({
      "width": iWidth,
      "height": $(window).height()
    });
      
  }
});

module.exports = new ViewIndex();