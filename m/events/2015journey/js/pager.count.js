/**
 * pager.count
 */
!function() {
    var common = pager.common;
    pager.count = {
        name : "count",
        start: function() {
            var self = this;

            if(!this.init){
                this.init = true;
                this.container = $('.count-page');
                this.pageTpl = $("#count-tpl").html();
            }
            this.container.html(this.pageTpl);
            this.calcStep(pager.showData.hupuholedata);
            this.texts = this.container.find(".num");
            this.num1 = this.texts.eq(0);
            this.num2 = this.texts.eq(1);
            this.num3 = this.texts.eq(2);
            this.num4 = this.texts.eq(3);

            this.running = true;
        },
        run: function(){
            if (!this.running) return;

            if(pager.renderCount % 5 === 0){
                var stepData = this.stepData;
                var steps = this.steps;
                var originData = pager.showData.hupuholedata;
                var allPass = true;

                if(stepData.send < originData.send){
                    stepData.send += steps.send;
                    this.num1.text(common.formatNum(stepData.send));
                    allPass = false;
                }else{
                    this.num1.text(common.formatNum(originData.send));
                }

                if(stepData.reply < originData.reply){
                    stepData.reply += steps.reply;
                    this.num2.text(common.formatNum(stepData.reply));
                    allPass = false;
                }else{
                    this.num2.text(common.formatNum(originData.reply));
                }

                if(stepData.comment < originData.comment){
                    stepData.comment += steps.comment;
                    this.num3.text(common.formatNum(stepData.comment));
                    allPass = false;
                }else{
                    this.num3.text(common.formatNum(originData.comment));
                }

                if(stepData.light < originData.light){
                    stepData.light += steps.light;
                    this.num4.text(common.formatNum(stepData.light));
                    allPass = false;
                }else{
                    this.num4.text(common.formatNum(originData.light));
                }
                
                if(allPass){
                    this.running = false;
                }
            }
        },
        calcStep: function(data){
            this.steps = {
                send: data.send / common.getRandom(10, 7),
                reply: data.reply / common.getRandom(12, 9),
                comment: data.comment / common.getRandom(15, 12),
                light: data.light / common.getRandom(18, 15)
            };

            this.stepData = {
                send: 0,
                reply: 0,
                comment: 0,
                light: 0
            };
        },
        stop: function() {
            this.running = false;
            this.container.empty();
        }
    };
}();