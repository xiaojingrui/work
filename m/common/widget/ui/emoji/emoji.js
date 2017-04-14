/**
 * @file 上传图片
 * @author wangjun@hupu.com
 * @date 2015-07-21
 */
    "use strict";
    var Util = require('common:widget/ui/util/util.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");
    var pageId = __daceDataNameOfPage;

    var emojiData = [
        {"code":"[s:12]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/5.gif\">"},
        {"code":"[s:13]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/7.gif\">"},
        {"code":"[s:9]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/10.gif\">"},
        {"code":"[s:10]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/16.gif\">"},
        {"code":"[s:11]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/19.gif\">"},
        {"code":"[s:7]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/cool.gif\">"},
        {"code":"[s:8]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/crazy.gif\">"},
        {"code":"[s:5]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/redface.gif\">"},
        {"code":"[s:58]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_dance3.gif\">"},
        {"code":"[s:61]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/smile.gif\">"},
        {"code":"[s:30]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_erte.gif\">"},
        {"code":"[s:32]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_jippi.gif\">"},
        {"code":"[s:37]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_KKiss.gif\">"},
        {"code":"[s:20]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_laugh7.gif\">"},
        {"code":"[s:42]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_ler.gif\">"},
        {"code":"[s:31]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_lur.gif\">"},
        {"code":"[s:17]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_mannen.gif\">"},
        {"code":"[s:39]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_momo.gif\">"},
        {"code":"[s:24]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_scared.gif\">"},
        {"code":"[s:21]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_shrug.gif\">"},
        {"code":"[s:2]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/mrgreen.gif\">"},
        {"code":"[s:38]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_read.gif\">"},
        {"code":"[s:22]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_sad17.gif\">"},
        {"code":"[s:25]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_ahh2.gif\">"},
        {"code":"[s:41]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_ahh.gif\">"},
        {"code":"[s:28]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_app5.gif\">"},
        {"code":"[s:16]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_spor.gif\">"},
        {"code":"[s:35]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_bow.gif\">"},
        {"code":"[s:23]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_crazy.gif\">"},
        {"code":"[s:40]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_dance.gif\">"},
        {"code":"[s:15]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_no.gif\">"},
        {"code":"[s:36]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_nonono.gif\">"},
        {"code":"[s:4]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/wink.gif\">"},
        {"code":"[s:6]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/sad.gif\">"},
        {"code":"[s:3]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/question.gif\">"},
        {"code":"[s:27]","img":"<img class='icons-emoji' src=\"\/\/b1.hoopchina.com.cn\/post\/smile\/icon_bang.gif\">"}
    ];

    var Emoji = {
        init: function(){
            var that = this;

            this.$button = $('#J_buttonEmoji');

            if(!this.$button.length){
                return;
            }

            this.$wrap = $('#J_emojiWrap');

            this.render();
            this.bind();
        },
        bind: function(){
            var that = this;

            this.$button.tap(function(){
                that.$wrap.toggle();
            });

            //var $edit = $('.edit-content'),
            //    ucStart = 0;
            //
            //// 解决uc bug
            //$edit.on('blur', function(){
            //    ucStart = Util.getStart($edit[0]);
            //    console.log('blur======' + ucStart);
            //});

            this.$wrap.find('.emoji-list').on('tap',function(){
                //console.re.log('tap====' + ucStart);
                Util.insertText($('.edit-content')[0], $(this).html());
                dace.send(pageId + "_img");
            });
        },
        /**
         * 渲染表情
         */
        render: function(){
            var tpl = '';

            emojiData.forEach(function(item){
                tpl += '<span class="emoji-list" data-code="'+ item.code +'">'+ item.img +'</span>';
            });

            this.$wrap.html(tpl);
        },
        /**
         * 插入表情
         * @param elem
         * @param str
         */
        insertStr: function(elem, str){

        }
    };

module.exports = Emoji;