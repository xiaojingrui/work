import * as util from './utils'
import parseDate from './parseDate'
import Store from './store'
import _ from 'underscore'

let storeData = {};

function looseEqual (a, b, keys) {
  if(!_.isArray(keys) || _.isEmpty(keys)){
      return _.isEqual(a, b)
  } else{
      if(_.isObject(a) && _.isObject(b)){
          let ret = true
          _.each(keys, function(key){
              if(a[key] !== b[key]){
                  ret = false
              }
          })
          return ret
      }
  }
  return false
}

/**
 * @class Store
 * 核心存储层，将单页数据保存于localStorage中
 */
class ModelStore extends Store{

    hasValue( params = {} ){
        if(this.expire === 0) return false

        let data = this.store[this.name];
        //解析data
        if(data && data.length){
            try{
                data = JSON.parse(data);
            }catch(e){
                data = {}
            }
        }
        if(data && data.value && data.expire){
            if(util.getTime() < data.expire && looseEqual(params, data.params, this.keys)){
                return true
            } else{
                return false
            }
        }
        return false
    }
    /**
     * setValue 设置存储
     */
    setValue( params = {}, value ){
        if(this.expire === 0) return false

        let data = {
            expire : util.getTime() + this.expire,
            params : params,
            value  : value
        }
        this.store[this.name] = JSON.stringify(data);
    }
}

module.exports = ModelStore
