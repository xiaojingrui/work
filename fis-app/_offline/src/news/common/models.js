import request from './request'
import Model from 'common/model'
import { name, origin } from './config'
import { getInfo } from 'common/app'

// 默认接口数据5分钟过期, 线下测试接口可以改为0
const defaultExpire = getInfo().env === 3 ? 0 : '5m'

export function getHost(){
    return origin()
}

function createModel(modelName, option = {}){
    const storeName = `${name}_${modelName}`
    return new Model(storeName, request, option.url, option.method, option.expire, option.keys)
}
/**
 * 新闻正文
 */
export const getNewsArticle = createModel("article_detail", {
    url: '/news/createNewsDetailH5',
    method: 'post',
    expire: defaultExpire,
    keys: ['nid']
})

/**
 * 新闻亮评论
 */
export const getNewsLight = createModel("article_light", {
    url: '/news/getLightComment',
    method: 'post',
    expire: 0
})

/**
 * 新闻全部评论
 */
export const getNewsComment = createModel("article_comment", {
    url: '/news/getCommentH5',
    method: 'post',
    expire: 0
})

/**
 * 获取用户信息
 */
export const getUserInfo = createModel("user_info", {
     url: '/user/ajaxInfo',
     method: 'post',
     expire: defaultExpire
})

/**
 * 点亮新闻用户评论
 * 该路由需要在使用的时候 resetUrl,正确的路由格式为`/${leaguesEn}/lightNewsComment`
 */
export const addLightNewsComment = createModel("add_news_light", {
     url: '/news/lightNewsComment',
     method: 'post',
     expire: 0
})

/**
 * 点亮内置浏览器用户评论
 */
export const addLightInlineComment = createModel("add_link_light", {
     url: '/link/lightComment',
     expire: 0
})

/**
 * 拉取投票结果
 */
export const getNewsVote = createModel("get_vote", {
     url: '/news/voteInfo',
     method: 'post',
     expire: 0
})

/**
 * 投票
 */
export const saveNewsVote = createModel("save_vote", {
     url: '/news/vote',
     method: 'post',
     expire: 0
})


/**
 * 删除评论
 */
 export const delNewsComment = createModel("del_news_comment", {
      url: '/news/delNewsComment',
      method: 'post',
      expire: 0
 })

/**
 * 封禁评论
 */
 export const cagUserByNewsComment = createModel("cag_user_comment", {
      url: '/news/cagUserByNewsComment',
      method: 'post',
      expire: 0
 })

/**
 * 举报评论
 */
 export const getReportReason = createModel("get_report_reason", {
      url: '/report/getMsg',
      method: 'post',
      expire: 0
 })
