import _ from 'underscore'
import ModelStore from './modelStore'
import getHeaders from './header'
import { isIOS, getInfo } from './app'

/**
 * @class Model
 * 核心model层，用于数据获取 和 数据缓存
 */
class Model {
    constructor(name, request, url, method = 'get', expire = 0, keys = []) {
       this.request = request;
       this.modName = name.split("_")[0];
       this.url = url;
       this.useURL = url;
       this.method = method.toLowerCase();
       this.params = { offline: 'json'};
       this.expire = expire;
       this._bindStatus = false;
       this.query = {}

       this.store = new ModelStore(`hupu_${name}`, expire, keys);


       //如果链接中有参数
       let hasQuery = this.url.indexOf("?")
       if(~hasQuery){
           this.url = url.substr(0, hasQuery)
           let queryString = this.url.substr(hasQuery)
           queryString.split("&").forEach(item => {
               if(~item.indexOf("=")){
                   let mm = item.split("=")
                   this.query[mm[0]] = this.query[mm[1]]
               }
           })
       }
    }

    /**
     * 重新设置url
     */
    resetUrl( url = ''){
        if(_.isString(url)){
            this.url = url
        }
    }

    /**
     * 更新参数
     */
    updateQuery( query = {}){
        this.query = _.extend(this.query, query)
        let querys = [];
        for(let key in this.query){
            if(this.query.hasOwnProperty(key)){
                querys.push( `${key}=${encodeURIComponent(this.query[key])}` )
            }
        }
        this.useURL = `${this.url}?${querys.join('&')}`
        return this
    }

    /**
     * 拼接固定接口，考试系统除外
     */
    getUrl(){
        let url = this.useURL
        if(this.modName != "exam"){
            const device = isIOS ? 3 : 1
            const version = getInfo().version
            url = `/${device}/${version}${this.useURL}`
        }
        return url
    }

    getMethod(){
        //方法兼容
        let methods = ['get','post','put','delete']
        if(~methods.indexOf(this.method)){
            return this.request[this.method]
        }else{
            return this.request['get']
        }
    }

    bind( params = {} ){
        this.params = _.extend(this.params, params);
        return this
    }

    //绑定从客户端获取的header，做为和服务端通信的信任机制.
    bindHeaders(){
        //重新读一遍client
        this.params.client = getInfo().client;
        this.params.webp = getInfo().webp;

        if(this.method != 'get'){
            let query = _.omit(this.params, 'header');
            this.params = _.extend(this.params, getHeaders());
            this.updateQuery(query)
        }
        return this
    }

    execute(sucessCallback, errCallback){
        if(this.expire !== 0 && this.store.hasValue(this.params)){
            sucessCallback(this.store.getValue());
        } else{
            this.bindHeaders().getMethod()(this.getUrl(), this.params).then(res => {
                if(res.status === 0 || res.status === 200){
                    sucessCallback(res);
                    this.store.setValue(this.params, res);
                } else{
                    errCallback && errCallback(res)
                }
            }).catch(err => {
                errCallback && errCallback(err)
            });
        }
    }
}

module.exports = Model
