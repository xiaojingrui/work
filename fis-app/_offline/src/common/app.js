import * as bridge from './bridge'
import { getFontSize } from './utils'
import { golbal } from './events'
import $ from './zepto'
import dace from './dace'

const ua = navigator.userAgent

export const isInWeixin = ~ua.indexOf('MicroMessenger');
export const isIOS = /iPhone|iPad|iPod/i.test(ua);
export const isAndroid = /Android/i.test(ua);
export const isWinPhone = /Windows\sPhone/i.test(ua);
export function getInfo(){
    return window.HupuBridge.nainfo
}
export function setInfo(name, val){
    window.HupuBridge.nainfo[name] = val
}

/**
 * 标记H5已经就绪, 离线H5可用
 * 如果离线H5未发送该时间，客户端自动切换线上H5并上报客户端信息. 前端收集该信息来处理.
 * @return {void}
 */
export function sendHybridReady(){
    bridge.send("hupu.common.hybridready")
}

/**
 * 隐藏Native的loading
 */
export function sendHideLoading(){
    bridge.send("hupu.common.hideloading")
}

/**
 * webapp 页面最开始初始化方法
 * @param  {Object} config 客户端基本信息
 * @return {void}
 */
export function initPage(config){
    //dace init
    dace.init()
    //告知Native，离线H5无异常.
    sendHybridReady()
    //更新页面模式
    updateNightMode(config.night)

    bridge.register("hupu.comomn.updateHash", function(res){
        location.hash = res.hash
    })

    //更新字体
    bridge.register("hupu.ui.updatefontsize", function(res){
        let fontSize = getFontSize(res.fontsize)
        window.HupuBridge.nainfo.fontSize = fontSize
        golbal.emit("updateFontsize", fontSize)
    });

    //更新夜间模式
    bridge.register("hupu.ui.updateNightMode", function(res){
        let night = res.night
        updateNightMode(night)
        window.HupuBridge.nainfo.night = !!parseInt(night) ? 1 : 0
        golbal.emit("updateNightMode", night)
    });

    //返回顶部
    bridge.register("hupu.ui.pageBacktop", function(){
        document.body.scrollTop = 0
        golbal.emit("pageBacktop")
    });

    // 兼容:active实现点击效果
    document.body.addEventListener("touchstart", function(){});
}

//更新页面夜间模式
export function updateNightMode( night = 0 ){
    if(!!night){
        $("body").addClass("night")
    } else{
        $("body").removeClass("night")
    }
}

/**
 * webApp 初始化方法
 * @param  {function} initCallBack bridgeready回调
 * @return {void}
 */
export function App(initCallBack){
  if(bridge.isInApp){
    if(window.HupuBridge.ready){
        initCallBack(bridge.debug, getInfo().env);
    }else{
        document.addEventListener("hupuBridgeReady", function(){
            initCallBack(bridge.debug, getInfo().env);
        });
    }
  }else{
      initCallBack(bridge.debug, getInfo().env);
  }
}

/**
 * 校验登陆
 * @param  {function} loginCallback 登陆回调
 * @return {void}
 */
export function checkLogin( loginCallback ){
     const na = getInfo()
     if(na.islogin){
         loginCallback && loginCallback()
     } else{
         bridge.send("hupu.user.login", {}, () =>{
            loginCallback && loginCallback()
         })
     }
}

/**
 * 设置标题
 * @param {string} title 标题
 * @param {string} subTitle 二次标题
 */
export function setTitle( title = "", subTitle = "" ){
    document.title = `${title}-${subTitle}`
    bridge.send("hupu.ui.header", {
        title : title,
        subtitle : subTitle
    })
}

/**
 * 创建图集
 * @param {string} title 图集标题
 * @param {number} index 展示第几张图片
 * @param {array}  images 全部图片信息
 *
 * @example image
 *
 *      {
 *          url: 图片url,
 *          originSrc: 原图的url,
 *          originSize: 原图大小，单位M,
 *          index: 图片在图集中的索引位置
 *      }
 */
export function createAlbum( title = "", index = 0, images = []){
    bridge.send("hupu.album.view", {
      title: title,
      index: index,
      images: images
    });
}

/**
 * 关闭webview
 */
export function closePage(){
   bridge.send("hupu.ui.pageclose")
}

/**
 * send 等同于 bridge
 */
export const send = bridge.send
