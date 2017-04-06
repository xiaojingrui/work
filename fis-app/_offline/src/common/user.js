import _ from 'underscore'
import { getInfo } from './app'

const isEmpty = _.isEmpty
/**
 * 获得认证信息
 *  1: 优秀认证
 *  2: 专业认证
 *  3: 优秀认证+专业认证
 * {
 * 	  "1": {
 * 	  	"cert_type": 1,
 * 	  	"cert_info":""
 * 	  },
 * 	  "2":{
 * 	  	"cert_type":2,
 * 	  	"cert_info":""
 * 	  }
 * }
 *
 * @return {
 *    "type": 1,
 *    "image":"",
 *    "info": ""
 * }
 **/


export function getUserCert( cert ){
    let retCert = {}
    if(!isEmpty(cert["1"]) && !isEmpty(cert["2"])){
        retCert.type = 3
        retCert.info = [cert["1"].cert_info, cert["2"].cert_info].join("、")
    } else{
        if(!isEmpty(cert["1"])){
            retCert.type = 1
            retCert.info = cert["1"].cert_info
        }
        if(!isEmpty(cert["2"])){
            retCert.type = 2
            retCert.info = cert["2"].cert_info
        }
    }
    retCert.image = getCertImage(retCert.type)
    return retCert
}

export function getCertImage( type = 1 ){
    let mode = getInfo().night
    let merge = mode == 1 ? 'night' : 'day'
    let src = ""
    switch (type) {
        case 1:
            src = `https://w10.hoopchina.com.cn/hybrid/resource/cert/author_${merge}.png`
            break;
        case 2:
            src = `https://w10.hoopchina.com.cn/hybrid/resource/cert/official_${merge}.png`
            break;
        case 3:
            src = `https://w10.hoopchina.com.cn/hybrid/resource/cert/merge_${merge}.png`
            break;
    }

    return src
}
