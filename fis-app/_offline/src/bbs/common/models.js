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
 * 论坛正文
 */
export const getBBSArticle = createModel("article_detail", {
    url: '/threads/getsThreadInfo',
    method: 'post',
    expire: defaultExpire,
    keys: ['tid','postAuthorPuid']
})

/**
 * 论坛亮评论
 */
export const getBBSLight = createModel("article_light", {
    url: '/threads/getsThreadLightReplyList',
    method: 'post',
    expire: 0
})

/**
 * 论坛全部评论
 */
export const getBBSPost = createModel("article_post", {
    url: '/threads/getsThreadPostList',
    method: 'post',
    expire: 0
})

/**
 * 推荐帖子
 */
export const recommandArticle = createModel("article_recommand", {
    url: '/threads/threadRecommand',
    method: 'post',
    expire: 0
})

/**
 * 点亮评论
 */
export const addPostLight = createModel("post_light", {
   url: '/threads/replyLight',
   method: 'post',
   expire: 0
})

/**
 * 点灭评论
 */
export const addPostRulight = createModel("post_rulight", {
   url: '/threads/replyUnlight',
   method: 'post',
   expire: 0
})

/**
 * 获取最后的评论
 */
export const getLastPost = createModel("article_last_post", {
   url: '/threads/getPostsLastInfo',
   method: 'post',
   expire: 0
})

/**
 * 更新帖子推荐状态
 */
export const changeRecommendStatus = createModel("change_recommend_status", {
   url: '/threads/changeRecommendStatus',
   expire: 0,
   method: 'post'
})

/**
 * 论坛获取投票
 */
export const getBBSVote = createModel("get_vote",{
   url: '/threads/voteInfo',
   expire: 0,
   method: 'post'
})

/**
 * 论坛投票
 */
export const saveBBSVote = createModel("save_vote",{
   url: '/threads/vote',
   expire: 0,
   method: 'post'
})
