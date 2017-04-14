/**
 * @file 收藏板块展示
 * @author huangmian@hupu.com
 * @date 2015-08-24
 */

"use strict";

var _ = require("underscore");


var defaultConfig = {
    container: '.bbs-recommend-board',
    boardList: '.bbs-recommend-board ul'
}

var StarBoard = function( options ) {
    this.opts = _.extend({}, defaultConfig, options);

    this.container = $(this.opts.container);
    if(this.container.length == 0) return;
    this.list = $(this.opts.boardList);
    
    this.init();
};

StarBoard.prototype = {
    init: function() {
        if(this.container.height() < this.list.height()){
            this.container.append($('<span class="show-btn down-btn"><em></em></span>'));
        }
        this.btn = this.container.find('.show-btn');
        this.bind();
    },
    bind: function() {
        var self = this;
        this.btn.on('click', function() {
            if($(this).hasClass('down-btn')){
                self.container.addClass('on');
                $(this).removeClass('down-btn').addClass('up-btn');
            }else{
                self.container.removeClass('on');
                $(this).removeClass('up-btn').addClass('down-btn');
            }
        })

    }
}


module.exports = function( options ) { 
    return new StarBoard( options );
}