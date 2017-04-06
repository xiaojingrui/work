import request from './request'
import Model from 'common/model'
import { name, origin } from './config'
import { getInfo } from 'common/app'

export function getHost(){
    return origin()
}

function createModel(modelName, {url, method, expire}){
    const storeName = `${name}_${modelName}`
    return new Model(storeName, request, url, method, expire)
}
/**
 * 获取考题
 */
export const getExam = createModel("exam_detail", {
    url: '/exam/getPaper',
    method: 'post',
    expire: 0
})

/**
 * 提交考题
 */
export const submitAnswer = createModel("exam_answer", {
    url: '/exam/answerQuestion',
    method: 'post',
    expire: 0
})
