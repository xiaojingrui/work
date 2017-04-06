import _ from 'underscore'

const keys = {
    'Y' : 31536000000,
    'M' : 2592000000,
    'd' : 86400000,
    'h' : 3600000,
    'm' : 60000,
    's' : 1000
}
const reDate = /^(\d+[YMdhms])+$/
const reSingleDate = /\d+[YMdhms]/g

const caleTime = (ds) => {
    let dsEnd = ds.slice(1);
    let dsStart = parseInt(ds.split(dsEnd)[0], 10);

    return dsStart > 0 ?  dsStart * keys[dsEnd] : 0
}
/**
 * 解析时间字符串
 * @param  {string} dateString 时间字符串
 * @example
 * 		1d : 表示一天, 返回 86400000 ms
 * 		1M2d: 表示1个月零2天，返回 2764800000 ms => 2592000000 + 86400000 * 2
 *      10h : 表示10小时，返回 3600000 ms => 3600000 * 10
 *
 * @return {int} 时间字符串表示的毫秒数
 */
export default (dateString) => {
    if(_.isNumber(dateString)){
        return +dateString
    }
    if(reDate.test(dateString)){
        let dateCount = 0;
        const items = dateString.match(reSingleDate);
        _.each(items, (single) => {
            dateCount += caleTime(single)
        });
        return dateCount
    } else{
        return 0
    }
}
