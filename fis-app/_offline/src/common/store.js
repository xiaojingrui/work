import * as util from './utils'
import parseDate from './parseDate'

let storeData = {};

/**
 * @class Store
 * 存储层，将单页数据保存于localStorage中
 */
class Store {
    constructor(name, expire = '1Y', keys = []) {
       this.name = name;
       this.expire = parseDate(expire);
       this.keys = keys;
       this.store = util.isSupportLocalStorage ? window.localStorage : storeData;
    }

    hasValue(){
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

        return false
    }

    /**
     * getValue 获取数据
     * {
     *    expire: 14000002000, //过期毫秒数
     *    value:  [data]       //本地存储的数据
     * }
     *
     * @return {Object}  返回数据
     */
    getValue(){
        let data = this.store[this.name] || '{}';
        data = JSON.parse(data);
        return data.value
    }
    /**
     * setValue 设置存储
     */
    setValue( value ){
        if(this.expire === 0) return false
        let data = {
            expire : util.getTime() + this.expire,
            value  : value
        }
        this.store[this.name] = JSON.stringify(data);
    }
}

module.exports = Store
