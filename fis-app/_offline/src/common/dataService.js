//import 'whatwg-fetch';
import createFetch from './request'
import Versions from './versions'
import { isAndroid, getInfo } from './app'
import $ from 'common/zepto'

let escape = encodeURIComponent
function serialize(params, obj, scope){
  var type, array = $.isArray(obj), hash = $.isPlainObject(obj)
  $.each(obj, function(key, value) {
    type = $.type(value)
    if (scope) key = scope + '[' + (hash || type == 'object' || type == 'array' ? key : '') + ']'
    // handle data in serializeArray() format
    if (!scope && array) params.add(value.name, value.value)
    // recurse into nested objects
    else if (type == "array" || type == "object")
      serialize(params, value, key)
    else params.add(key, value)
  })
}
//post传参解析，参考zepto ajax
function parseParam(obj){
  let params = []
  params.add = function(key, value) {
    if ($.isFunction(value)) value = value()
    if (value == null) value = ""
    this.push(escape(key) + '=' + escape(value))
  }
  serialize(params, obj)
  return params.join('&').replace(/%20/g, '+')
}

export default (API_BASE) => {

  //android 系统版本 < 5.0.0 重写系统fetch接口
  if( (isAndroid && Versions.gt("5.0.0", getInfo().osVer)) || !window.fetch ){
      window.fetch = createFetch()
  }

  return {
    /**
     *   @example
     *   dataService.get("/info",{a:1}).then((res) =>{
     *       console.log(res);
     *   })
     */
    get(url, params = {}) {
      let query = [];
      let request = `${API_BASE()}${url}`;
      Object.keys(params).forEach(key =>{
          query.push(`${key}=${encodeURIComponent(params[key])}`)
      });
      query = query.join("&");
      request = query ? [request, query].join("?") : request;
      return fetch(request, {
                  mode: 'cors',
                  redirect: 'follow'
              }).then(res => res.json())
    },
    /**
     *   @example
     *   dataService.post("/submit",{ a:1 }).then((res) =>{
     *       console.log(res);
     *   })
     */
    post(url, params = {}){
      let request = `${API_BASE()}${url}`;
      let postParams = parseParam(params)
      return fetch(request, {
                method: "post",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                },
                mode: 'cors',
                redirect: 'follow',
                body: postParams
             }).then(res => res.json())
    },
    /**
     *   @example
     *   dataService.put("/submit",{ a:1 }).then((res) =>{
     *       console.log(res);
     *   })
     */
    put(url, params = {}){
      let request = `${API_BASE()}${url}`;
      return fetch(request, {
                method: "put",
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
                mode: 'cors',
                redirect: 'follow',
                body: JSON.stringify(params)
             }).then(res => res.json())
    },

    /**
     *    @example
     *    dataService.delete("/submit", { a:1 }).then((res) => {
     *        console.log(res);
     *    })
     */
    delete(url, params = {}){
      let request =  `${API_BASE()}${url}`;
      return fetch(request, {
          method: 'delete',
          headers: {
              'Content-Type': 'application/json'
          },
          mode: 'cors',
          redirect: 'follow',
          body: JSON.stringify(params)
      }).then(res => res.json())
    }
  }
}
