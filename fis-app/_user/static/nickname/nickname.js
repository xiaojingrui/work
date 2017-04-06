!function(){
    var version = require("common:widget/ui-versions/ui-versions.js");

    function initBridge(callback) {
        if(window.HupuBridge){
            callback();
        }else{
            document.addEventListener("hupuBridgeReady", function(){
                callback();
            });
        }
    }

    initBridge(function() {
        HupuBridge.send("hupu.ui.share", {
                open: false
            }, function() {}
        );
        if(version.gte(GM.version,"7.0.7")){
            HupuBridge.send("hupu.common.markh5back",{}, function(){
                //标记H5来处理回退.
                //点击Native回退的时候，调用固定回调方法名 "hupu.common.onback"
            });

            HupuBridge.register("hupu.common.onback",function(){
                // 可以对页面数据或者其他UI处理完毕后回退界面.

                // 回退到最后的界面
                HupuBridge.send("hupu.ui.back", {}, function() {
                    // console.log("回退到最后一个native界面, 功能和webview里的回退剪头功能一致");
                });
            });
        }

    });

    var Toast = require("common:widget/ui-toast/ui-toast.js");
    var apiUrl = {
        // 昵称
        setNick: '/'+ GM.projectId +'/'+ GM.version +'/status/setNickname?client=' + GM.client,
        checkIpt: '/'+ GM.projectId +'/'+ GM.version +'/status/preCheckModifyNickname?client=' + GM.client
    };

    
    var confirmPhone = {
        show : function(type) {
            var s = $(window).height();
            var str = '<div class="body-confirm-wrap" style="position:absolute; top:0; width:100%; height:100%; background: rgba(0,0,0,.6); z-index:50;"></div>';
            switch(type){
                case 0:
                    var txt = ' <style type="text/css">  .confirm-con{position:absolute;width: 75%;left: 50%;top: 50%;-webkit-transform: translate3d(-50%, -50%, 0);transform: translate3d(-50%, -50%, 0);background-color:#fdfdfd;padding-top: 20px;border-radius:10px;z-index:100;}.confirm-con h3{font-size:16px;text-align:center;margin-bottom: 5px;}.confirm-con p{width: 80%;margin: 0 auto 10px;font-size:14px;line-height:1.5;text-align:center;}.btn-box{border-top:1px solid #939292;margin-top: 15px;}.btn-box a{display: block;text-align:center;padding:10px 0;color: #0C80FF;text-decoration:none;}.btn-box a.cancel{border-right:1px solid #939292;}</style><div class="confirm-con"><p>昵称代表了你在社区的形象，</p><p>不能再次修改。</p>'
                        + '<div class="btn-box"><a href="#" class="confirm">确认</a></div></div>';
                    break;
                case 1: 
                    var txt = ' <style type="text/css">  .confirm-con{position:absolute;width: 75%;left: 50%;top: 50%;-webkit-transform: translate3d(-50%, -50%, 0);transform: translate3d(-50%, -50%, 0);background-color:#fdfdfd;padding-top: 20px;border-radius:10px;z-index:100;}.confirm-con h3{font-size:16px;text-align:center;margin-bottom: 5px;}.confirm-con p{width: 80%;margin: 0 auto 10px;font-size:14px;line-height:1.5;text-align:center;}.btn-box{border-top:1px solid #939292;margin-top: 15px;}.btn-box a{display: block;text-align:center;padding:10px 0;color: #0C80FF;text-decoration:none;}.btn-box a.cancel{border-right:1px solid #939292;}</style><div class="confirm-con"><p>昵称代表了你在社区的形象，</p><p>且只能修改一次，请谨慎修改。</p>'
                        + '<div class="btn-box"><a href="#" class="confirm">确认</a></div></div>';
                    break;
                case 2:
                    var txt = ' <style type="text/css">  .confirm-con{position:absolute;width: 75%;left: 50%;top: 50%;-webkit-transform: translate3d(-50%, -50%, 0);transform: translate3d(-50%, -50%, 0);background-color:#fdfdfd;padding-top: 20px;border-radius:10px;z-index:100;}.confirm-con h3{font-size:16px;text-align:center;margin-bottom: 5px;}.confirm-con p{width: 80%;margin: 0 auto 10px;font-size:14px;line-height:1.5;text-align:center;}.btn-box{border-top:1px solid #939292;margin-top: 15px;}.btn-box a{float:left;text-align:center;width: 49.5%;padding:10px 0;color: #0C80FF;text-decoration:none;}.btn-box a.cancel{border-right:1px solid #939292;}</style><div class="confirm-con"><p>需要绑定手机或QQ后才能修改哦。</p>'
                        + '<div class="btn-box clearfix"><a href="#" class="cancel">取消</a><a href="#" class="confirm">立即绑定</a></div></div>';
                    break;
            }
            if(type == 2){
                // 如果版本小于7.0.7,则显示toast
                if(version.gte(GM.version,"7.0.7")){
                    $("body").append(str).append(txt);
                }else{
                    Toast.toast('需要绑定手机或QQ后才能修改哦。');
                }
            }else{
                $("body").append(str).append(txt);
            }
            this.bind(type);
        },
        bind : function(type) {
            var self = this;
            $(".confirm").click(function(event) {
                if(type == 1){
                    self.hide();
                }else if(type == 2){
                    self.hide();
                    location.href = "kanqiu://settings/security";
                }else{
                    HupuBridge.send("hupu.ui.back", {}, function() {
                        // console.log("回退到最后一个native界面, 功能和webview里的回退剪头功能一致");
                    });
                }
            })
            $(".cancel").on('click', function() {
                 self.hide();
            })
        },
        hide : function() {
            $(".body-confirm-wrap,.confirm-con").remove();
        }
    };

    

    var nickname = {
        init: function() {
            this.nickipt = $('.nick-ipt');
            this.btn = $('.save-btn');
            this.flag = false;
            this.firstCheck();
            this.check();

            //页面高度不够，用css补上. by FHY.
            var winHeight = window.innerHeight;
            var docHeight = document.body.offsetHeight;
            if(docHeight < winHeight){
                var style = document.createElement("style");
                style.innerHTML = "html,body{height:100%;}";
                document.body.appendChild(style);
            }
        },
        firstCheck: function() {
            var self = this;
            this.nickipt.on('focus', function() {
                // 只允许第一次触发
                if(self.flag) return;
                self.nickipt.attr('disabled','true').blur();
                $.ajax({
                    url: apiUrl.checkIpt,
                    type: "GET",
                    dataType: "json",
                    success: function(data) {
                        if(data.error.id == 321) {
                            confirmPhone.show(1);
                        }else if(data.error.id == 510){
                            confirmPhone.show(2);
                        }else{
                            confirmPhone.show(0);
                        }
                        self.nickipt.removeAttr('disabled');
                        self.flag = true;
                    }
                });
            })
            
        },
        check: function() {
            var self = this;

            var validateRegExp = {
                //全空格
                empty: /^\s+$/i,
                // 3到10位的汉字/字母/数字
                nickname: /^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]{3,10}$/
            }

            var validateRules = {
                isEmpty: function(str) {
                    if (str == "" || typeof str != "string" || validateRegExp.empty.test(str)) {
                        return true;
                    } else {
                        return false;
                    }
                },
                isNickname: function(str) {
                    return validateRegExp.nickname.test(str);
                }
            }

            var lockBtnStatus = false;
            this.btn.on('click', function(e) {
                if(lockBtnStatus) return;
                lockBtnStatus = true;
                e.preventDefault();
                var nickVal = self.nickipt.val();
                if(validateRules.isEmpty(nickVal)){
                    Toast.toast('不能为空');
                    lockBtnStatus = false;
                }else if(!validateRules.isNickname(nickVal)){
                    Toast.toast('昵称格式不正确');
                    lockBtnStatus = false;
                }else{
                    $.ajax({
                        url: apiUrl.setNick,
                        type: "POST",
                        dataType: "json",
                        data: {
                            nickname: nickVal
                        },
                        success: function(data){
                            lockBtnStatus = false;
                            if(data.result && data.result == 1){
                                Toast.toast('设置成功');

                                HupuBridge.send("hupu.user.update", {
                                      nickname: nickVal
                                }, function(){});
                                
                            }else if(data.error){
                                Toast.toast(data.error.text);
                            }
                            
                        },
                        error: function(err){
                            lockBtnStatus = false;
                            Toast.toast(err);
                        }
                    });
                    
                }
            })
        }

    } 

    nickname.init();
}()

