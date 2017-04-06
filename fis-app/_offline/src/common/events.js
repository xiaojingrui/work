/**
 * 注册全局实例，处理全局事件
 */
import EventEmitter from './EventEmitter'

const events = {
    golbal: new EventEmitter()
}

module.exports = events
