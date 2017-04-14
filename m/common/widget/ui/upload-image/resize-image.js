/**
 * @Description: 压缩图片质量获得base64
 * @Author: wangjun
 * @Update: 2015-05-19 19:00
 * @version: 1.0
 * @Github URL: https://github.com/nevergiveup-j/canvas-resize-image
 */
    "use strict";

    var _ = require('underscore');
    var EXIF = require('common:widget/ui/upload-image/exif.min.js');
    var MegaPixImage = require('common:widget/ui/upload-image/megapix-image.js');
    var JPEGEncoder = require('common:widget/ui/upload-image/jpeg_encoder_basic.js');

    // 默认配置
    var defaults = {
        // 图片需要压缩的宽度，高度会跟随调整
        width: 640,
        // 压缩质量，不压缩为1
        quality: 0.8,
        // 图片大小 MB
        fileSize: 3,
        // 图片大小提示文字
        fileMessage: '上传图片不得大于3M',
        // 文件格式
        fileFormat: 'jpg|jpeg|png|gif|JPG|PNG|GIF',
        // 图片格式提示文字
        formatMessage: '图片格式错误，只支持JPG和PNG格式的图片上传',
        // 处理前函数
        beforeCallback: function() {

        },
        // 成功回调
        successCallback: function() {

        }  
    };

    function ResizeIMG($this, options){

        this.$button = $($this);

        this.opts = $.extend(true, {}, defaults, options || {});
        this.orientation = null;

        this.init();
    };

    /**
     * 初始化
     */
    ResizeIMG.prototype.init = function(){
        this.bind();
    };

    /**
     * 事件绑定
     */
    ResizeIMG.prototype.bind = function() {
        var that = this,
            file, URL, blob;        

        this.$button
            .off('change')
            .on('change', function(e){
                file = this.files[0];
                URL = window.URL || window.webkitURL;
                blob = URL.createObjectURL(file);

                // 上传前
                that.opts.beforeCallback && that.opts.beforeCallback(this, blob, file);

                // 图片大小MB
                if((file.size/1024/1024).toFixed(2) > that.opts.fileSize){
                    // 生成结果
                    var result = {
                        status: 401,
                        message: that.opts.fileMessage
                    };

                    that.opts.successCallback && that.opts.successCallback(result, $(this));
                    return;
                }
                // 图片类型
                if(!/\.(jpg|jpeg|png|gif|JPG|PNG|GIF)$/.test(file.name)){
                    // 生成结果
                    var result = {
                        status: 402,
                        message: that.opts.formatMessage
                    };

                    that.opts.successCallback && that.opts.successCallback(result, $(this));
                    return;
                }

                // 图片方向
                EXIF.getData(file, function(){
                    that.orientation = EXIF.getTag(file, 'Orientation');
                });

                that.base64IMG(blob, $(this),file);
                // 清空临时数据
                this.value = '';
        })
    };

    /**
     * 生成base64
     */
    ResizeIMG.prototype.base64IMG = function(blob, $elem,file) {
        var that = this;        
        $('<img />')
            .on('load',function(){
                canvasURL(this, blob,file);
            })
            .error(function() {
                canvasURL(this, blob,file);
            })
            .attr('src', blob);        

        function canvasURL(self, blob,file) {
            // 生成比例
            var w = self.width,
                h = self.height,
                scale = w / h;
            // 上传图片宽度大于需要宽度
            if(w > that.opts.width){
                w = that.opts.width || w;
                h = w / scale;
            }

            //生成canvas
            var canvas = document.createElement('canvas');

            if(canvas.getContext) {
                var ctx = canvas.getContext('2d');
            }else{
                alert("对不起，您的浏览器不支持图片压缩及上传功能，请换个浏览器试试~");
                return;
            }

            $(canvas).attr({
                width: w,
                height: h
            });

            // 修正图片方向
            if(that.orientation){
                that.transformCoordinate(canvas, w, h, that.orientation);
            }

            ctx.drawImage(self, 0, 0, w, h);

            /**
             * 生成base64
             */
            //     var base64 = canvas.toDataURL('image/jpeg', that.opts.quality);
                if(window.FileReader) {  
                    var fr = new FileReader();  
                    fr.onloadend = function(e) {  
                       var base64 = e.target.result;  
                         // 生成结果
                        var result = {
                            status: 200,
                            fileNmae:file,
                            data: {
                                base64: base64
                                //clearBase64: base64.substr(base64.indexOf(',') + 1)
                            },
                            message: '图片上传成功'
                        }

                        that.orientation = null;

                        // 执行后函数
                        that.opts.successCallback && that.opts.successCallback(result, $elem);
                    };  
                    fr.readAsDataURL(file);  
                }  

            // 修复IOS
            if (navigator.userAgent.match(/iphone/i)) {
                // var mpImg = new MegaPixImage(blob);

                // mpImg.render(canvas, {
                //     maxWidth: w,
                //     maxHeight: h,
                //     quality: that.opts.quality
                // });
                // if(!/\.(gif|GIF)$/.test(fileName)){
                //     var base64 = canvas.toDataURL('image/jpeg', that.opts.quality);
                // }else{
                //     // var base64;
                //     // if(window.FileReader) {  
                //     //     var fr = new FileReader();  
                //     //     fr.onloadend = function(e) {  
                //     //         base64 = e.target.result;  
                //     //     };  
                //     //     fr.readAsDataURL(file);  
                //     // } 
                // }
            }

            // 修复android
            if (navigator.userAgent.match(/Android/i)) {
                var encoder = new JPEGEncoder();
                base64 = encoder.encode(ctx.getImageData(0, 0, w, h), that.opts.quality * 100);
            }

           
        }    
        
    };

    /**
     * 修正图片方向
     */
    ResizeIMG.prototype.transformCoordinate = function(canvas, width, height, orientation) {
        switch (orientation) {
            case 5:
            case 6:
            case 7:
            case 8:
                canvas.width = height;
                canvas.height = width;
                break;
            default:
                canvas.width = width;
                canvas.height = height;
        }

        var ctx = canvas.getContext('2d');
        switch (orientation) {
            case 1:
                // nothing
                break;
            case 2:
                // horizontal flip
                ctx.translate(width, 0);
                ctx.scale(-1, 1);
                break;
            case 3:
                // 180 rotate left
                ctx.translate(width, height);
                ctx.rotate(Math.PI);
                break;
            case 4:
                // vertical flip
                ctx.translate(0, height);
                ctx.scale(1, -1);
                break;
            case 5:
                // vertical flip + 90 rotate right
                ctx.rotate(0.5 * Math.PI);
                ctx.scale(1, -1);
                break;
            case 6:
                // 90 rotate right
                ctx.rotate(0.5 * Math.PI);
                ctx.translate(0, -height);
                break;
            case 7:
                // horizontal flip + 90 rotate right
                ctx.rotate(0.5 * Math.PI);
                ctx.translate(width, -height);
                ctx.scale(-1, 1);
                break;
            case 8:
                // 90 rotate left
                ctx.rotate(-0.5 * Math.PI);
                ctx.translate(-width, 0);
                break;
            default:
                break;
        }
        
    };
    
    // ADM
    module.exports = ResizeIMG;


