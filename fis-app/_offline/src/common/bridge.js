import _ from 'underscore'
import { toast } from './utils'
import { supportWebp } from './image'

const REG_SUC = 0,
  REG_ERR = 1,
  AJAX_PARSING_ERR = 1,
  AJAX_SENDING_ERR = 2,
  PROMPT_PARSING_ERR = 3,
  CB_BY_METHOD_SUC = 0,
  isInApp = ~navigator.userAgent.indexOf('kanqiu'),
  debug = !isInApp,
  emptyFuc = function(){};

const ua = window.navigator.userAgent,
  isIOS = /iPhone|iPad|iPod/i.test(ua),
  isAndroid = /Android/i.test(ua);

let scheme = 'hupu',
  history = [],
  cbList = {}, //注册接口列表
  usePrompt = false, //同步使用prompt
  cbUniqueId = 0, //回调ID计数
  defaultNainfo = {
    osVer: "4.4.2",
    night: !!~location.hash.indexOf("night=1")?1:0,
    nopic: !!~location.hash.indexOf("nopic=1")?1:0,
    network: 0, //network, 暂时忽略
    client: 'x',
    islogin: 1,
    fontSize: 14,
    version: "7.0.19",
    cookies: '',
    webp: isAndroid ? 1 : 0,
    env: debug ? 1 : 1
  };

const dispatchReadyEvent = () => {
  window.HupuBridge.ready = true;
  const readyEvent = document.createEvent('Events');
  readyEvent.initEvent('hupuBridgeReady');
  document.dispatchEvent(readyEvent);
};

//IOS因为SCHEME识别星号问题，使用escape
const getSchemeURI = (param) => {
  const encd = isIOS ? escape : encodeURIComponent;
  return scheme + '://' + encd(JSON.stringify(param));
};

/**
 * @description 注册方法名和对应的方法体<br />
 * 方法名作为send的回调参数(successcb/errorcb)<br />
 * Native回调时将method作为第一个参数使用<br />
 * HupuBridge会找到对应的方法体，并执行
 * @method register
 * @param {String} method 方法名
 * @param {Function} cb 方法体
 * @return {Number} 注册成功返回 0，注册失败返回 1
 * @since 2015-03-29
 * @author meiandai
 * @example
 * HupuBridge.register('syncError', function(data) {
 *     console.log("ajax同步接口失败返回", JSON.stringify(data));
 * });
 * @static
 */
const register = (method, cb) => {
  if (typeof method === "string") {
    if (typeof cb === "function") {
      cbList[method] ? cbList[method].push(cb) : cbList[method] = [cb];
    } else if (cb instanceof Array) {
      cbList[method] ? cbList[method].concat(cb) : cbList[method] = cb;
    }
    return REG_SUC;
  }
  return REG_ERR;
};


/**
 * @description 注销方法名和对应的方法体<br />
 * 注销后方法名对应的所有映射将失效
 * @method unregister
 * @param {String} method 方法名
 * @since 2015-03-29
 * @author meiandai
 * @example
 * HupuBridge.unregister('syncError');
 */
const unregister = (method) => {
  if (typeof method === 'string') {
    delete cbList[method];
  }
};

//APP回调接口
const _handle_ = (method, data, successcb, errorcb) => {
  let _data = data;
  if (typeof data === "string") {
    try {
      _data = JSON.parse(data);
    } catch (e) {
      _data = data;
    }
  }
  cbByMethod(method, _data, successcb, errorcb);
};

//根据ethod名调用相应的callback
const cbByMethod = (method, data, successcb, errorcb) => {
  if (cbList[method]) {
    if (cbList[method] === 'function') {
      cbList[method](data, function(_d, _c, _e) {
        sendSync(successcb, _d, _c, _e);
      }, function(_d, _c, _e) {
        sendSync(errorcb, _d, _c, _e);
      });
    } else if (cbList[method] instanceof Array) {
      let lists = cbList[method];
      for (var i = 0, len = lists.length; i < len; i++) {
        let cb = lists[i];
        if (typeof cb === 'function') {
          cb(data, function(_d, _c, _e) {
            sendAsync(successcb, _d, _c, _e);
          }, function(_d, _c, _e) {
            sendAsync(errorcb, _d, _c, _e);
          });
        }
      }
    }
    return CB_BY_METHOD_SUC;
  }
};

//同步调用Native
const sendSync = (method, data, successcb, errorcb) => {
  let param = {
    "method": method,
    "data": data
  };
  let url = getSchemeURI(param);
  if (usePrompt) {
    try {
      let res = JSON.parse(prompt(url));
      return cbByMethod(res.errno > 0 ? errorcb : successcb, res);
    } catch (e) {
      return cbByMethod(errorcb, {
        "errno": PROMPT_PARSING_ERR,
        "errmsg": "prompt response parsing failed"
      });
    }
  } else {
    let xmlrequest = new XMLHttpRequest();
    xmlrequest.open("GET", url, false);
    xmlrequest.send(null);
    if (xmlrequest.readyState == 4) {
      try {
        let res = JSON.parse(xmlrequest.responseText);
        return cbByMethod(res.errno > 0 ? errorcb : successcb, res);
      } catch (e) {
        return cbByMethod(errorcb, {
          "errno": AJAX_PARSING_ERR,
          "errmsg": "ajax response parsing failed"
        });
      }
    }
  }
  return cbByMethod(errorcb, {
    "errno": AJAX_SENDING_ERR,
    "errmsg": "ajax request failed"
  });
};

//异步调用Native
const sendAsync = (method, data, successcb, errorcb) => {
  const param = {
    "method": method,
    "data": data,
    "successcb": successcb,
    "errorcb": errorcb
  };
  if(debug){
      var output = data ? (method + ":\n\r" + JSON.stringify(data, null, 2)) : method;
      console.log("bridge正在调用 method -> " + output);
  }
  const schemeURI = getSchemeURI(param);
  history.push(schemeURI);
  //构造scheme请求
  let iframe = document.createElement("iframe");
  iframe.src = schemeURI;
  document.head.appendChild(iframe);
};


/**
 * @description 向Native发送数据<br />
 * 回调的参数支持String或者Function<br />
 * 如果为String型，则视为此方法名已注册，否则将无效<br />
 * 如果为Function型，则会自动生成一个唯一的方法名，推荐使用Function型<br />
 * Native回调时会根据方法名找到对应的方法体执行<br />
 * @method send
 * @param {String} method Native对应的方法名
 * @param {Object} data 发送的数据体
 * @param {Function|String} successcb 成功时回调的方法名或者方法体
 * @param {Function|String} errorcb 失败时回调的方法名或者方法体
 * @param {Boolean} sync 是否为同步，缺省为false异步，推荐使用异步
 * @since 2015-03-29
 * @author meiandai
 * @example
 * //使用匿名方法作为参数
 * var method = 'testCallbackError';
 * HupuBridge.send(method, {
 *     'foo': method
 * }, function(response) {
 *     console.log('Native成功返回内容 ' + response);
 * }, function(response) {
 *     console.log('Native返回失败内容 ' + response);
 * }, false);
 *
 *
 * //手动注册方法
 * HupuBridge.register('syncError', function(data) {
 *     console.log('ajax同步接口失败返回: ' + JSON.stringify(data));
 * });
 * var method = 'testCallbackSync';
 * HupuBridge.send(method, {
 *     'foo': method
 * }, function(response) {
 *     console.log('Native返回成功内容: ' + response)
 * }, 'syncError', true);
 *
 */
const send = (method, data, successcb, errorcb, sync) => {
  let callbackId;
  data = data || {};
  successcb = successcb || emptyFuc;
  errorcb = errorcb || emptyFuc;
  sync = sync || false;

  if (typeof successcb === "function") {
    callbackId = 'cb_' + (cbUniqueId++) + '_' + new Date().getTime();
    cbList[callbackId] = [successcb];
    successcb = callbackId;
  }
  if (typeof errorcb === "function") {
    callbackId = 'cb_' + (cbUniqueId++) + '_' + new Date().getTime();
    cbList[callbackId] = [errorcb];
    errorcb = callbackId;
  }
  sync ? sendSync(method, data, successcb, errorcb) : sendAsync(method,
    data, successcb, errorcb);
};

let bridge = {
  ver: "1.0.1",
  cbList: cbList,
  register: register,
  unregister: unregister,
  send: send,
  _handle_: _handle_,
  history: history,
  nainfo: defaultNainfo,
  ready: false,
  isInApp: isInApp,
  debug: debug
};
// 兼容bridge回传的数据异常
function checkBridgeData( bridge = {}, def ){
    let newData = _.extend(def, bridge)
    newData.night = !! parseInt(newData.night) ? 1 : 0
    newData.nopic = !! parseInt(newData.nopic) ? 1 : 0
    newData.islogin = !! parseInt(newData.islogin) ? 1 : 0
    newData.version = newData.version || defaultNainfo.version
    newData.client  = newData.client || defaultNainfo.client
    newData.fontSize = newData.fontSize || defaultNainfo.fontSize
    newData.env = ~[1,2,3].indexOf(newData.env) ? newData.env : defaultNainfo.env
    newData.hybridOfflineVersion = newData.hybridOfflineVersion || '0000'
    newData.cookies = newData.cookies || ''
    return newData
}

//检测是否支持webp
supportWebp( isSupport => {
    defaultNainfo.webp = isSupport ? 1 : 0
})

//注册全局bridge，和客户端回调
window.HupuBridge = bridge

/**
 * 客户端发送的bridgeReady事件
 * @example {
      night: 1, //夜间模式为1，正常模式为0
      nopic: 1, //无图模式为1，正常模式为0
      client: 'x', //客户端client
      islogin: 0,  //1为登陆，0为未登陆
      fontSize: 14, //字体大小，[14,16,18,20,22]
      version: "7.0.15", //客户端版本
      env : 1, //1为线上，2为预发布，3为测试
      cookies:'',
      hybridOfflineVersion: 7146 //离线包小版本
      }
 */
if(isInApp){
    send("bridgeReady", {}, function(data) {
      if (!!data) {
        usePrompt = !data.supportAjax;
        scheme = data.scheme || scheme;
        //每个版本提示一次
        if(data.env == 3 && localStorage.getItem("pkgver") != data.hybridOfflineVersion){
            toast("当前离线包版本为:"+ data.hybridOfflineVersion +"\n\n bridgeReady事件返回:\n" + JSON.stringify(data, null, 2));
            localStorage.setItem("pkgver", data.hybridOfflineVersion);
        }
        //校验bridge返回
        window.HupuBridge.nainfo = checkBridgeData(data, defaultNainfo);
      }
      dispatchReadyEvent();
    }, dispatchReadyEvent);
} else{
    window.HupuBridge.nainfo = defaultNainfo
}

//声明全局变量
module.exports = bridge
