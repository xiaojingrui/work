var NewTopNav = {

    init: function(){
        this.render();
        this.bind();
    },

    render: function(){
        this.navWrap = $("#J-nav-wrap");
        this.fixNav = this.navWrap.find(".main-nav-wrap");
    },

    bind: function(){
        var self = this;

        if(!self.fixNav.hasClass("no-fixed")){
            $(window).on("scroll", function(){
                if($(this).scrollTop() > 37){
                    self.fixNav.css("position", "fixed");
                    self.fixNav.find(".triangle").hide();
                } else {
                    self.fixNav.css("position", "relative");
                    self.fixNav.find(".triangle").show();
                }
            });
        }
    }

};

module.exports = NewTopNav;
