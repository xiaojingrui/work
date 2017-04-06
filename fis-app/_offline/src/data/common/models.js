import request from './request'
import Model from 'common/model'
import { name, origin } from './config'
import { getInfo } from 'common/app'
import _ from 'underscore'

// 默认接口数据5分钟过期, 线下测试接口可以改为0
const defaultExpire = getInfo().env === 3 ? 0 : '5m'

export function getHost(){
    return origin()
}

function createModel(modelName, option = {}){
    const storeName = `${name}_${modelName}`
    return new Model(storeName, request, option.url, option.method, option.expire)
}
/**
 * NBA球队排行
 */
export const getNBATeam = createModel("nba_rank_sync", {
    url: '/data/nba',
    expire: defaultExpire
})

/**
 * NBA其他TAB排行
 * type:   {playoff，regular，daily，trade，injury}
 * 对应数据: 季前赛球员榜，常规赛球员榜，每日数据，转会球员，受伤球员
 */
export const getNBAPlayerInGeneral = createModel("nba_rank",{
    url: '/nba/getPlayerDataInGeneral',
    expire: defaultExpire
})

/**
 * CNA排行
 */
export const getCBATeam = createModel("cba_rank_sync", {
    url: '/data/cba',
    expire: defaultExpire
})

/**
 * CBA其他TAB排行
 * type:   {pre, today}
 * 对应数据: 球员数据,本轮数据
 */
export const getCBAPlayerRank = createModel("nba_rank",{
    url: '/cba/getPlayerRank',
    expire: defaultExpire
})

/**
 * CSL足球排行
 */
export const getSoccercsl = createModel("soccer_csl_rank", {
    url: '/data/csl',
    expire: defaultExpire
})

/**
 * afccl足球排行
 */
export const getSoccerafccl = createModel("soccer_afccl_rank", {
    url: '/data/afccl',
    expire: defaultExpire
})

/**
 * cl足球排行
 */
export const getSoccercl = createModel("soccer_cl_rank", {
    url: '/data/cl',
    expire: defaultExpire
})

/**
 * national足球排行
 */
export const getSoccernational = createModel("soccer_national_rank", {
    url: '/data/national',
    expire: defaultExpire
})

/**
 * chlg足球排行
 */
export const getSoccerchlg = createModel("soccer_chlg_rank", {
    url: '/data/chlg',
    expire: defaultExpire
})

/**
 * epl足球排行
 */
export const getSoccerepl = createModel("soccer_epl_rank", {
    url: '/data/epl',
    expire: defaultExpire
})

/**
 * liga足球排行
 */
export const getSoccerliga = createModel("soccer_liga_rank", {
    url: '/data/liga',
    expire: defaultExpire
})

/**
 * bund足球排行
 */
export const getSoccerbund = createModel("soccer_bund_rank", {
    url: '/data/bund',
    expire: defaultExpire
})

/**
 * seri足球排行
 */
export const getSoccerseri = createModel("soccer_seri_rank", {
    url: '/data/seri',
    expire: defaultExpire
})

/**
 * fran足球排行
 */
export const getSoccerfran = createModel("soccer_fran_rank", {
    url: '/data/fran',
    expire: defaultExpire
})

/**
 * uefael足球排行
 */
export const getSocceruefael = createModel("soccer_uefael_rank", {
    url: '/data/uefael',
    expire: defaultExpire
})

/**
 * eurocup足球排行
 */
export const getSoccereurocup = createModel("soccer_eurocup_rank", {
    url: '/data/eurocup',
    expire: defaultExpire
})

/**
 * amerciacup足球排行
 */
export const getSocceramerciacup = createModel("soccer_amerciacup_rank", {
    url: '/data/amerciacup',
    expire: defaultExpire
})

/**
 * olympic足球排行
 */
export const getSoccerolympic = createModel("olympic_rank", {
    url: '/data/olympic',
    expire: defaultExpire
})

/**
 * fifa足球排行
 */
export const getSoccerfifa = createModel("soccer_fifa_rank", {
    url: '/data/fifa',
    expire: defaultExpire
})

/**
 * zxb足协杯
 */
export const getSoccerZxb = createModel("soccer_zxb_vs", {
    url: '/data/zxb',
    expire: defaultExpire
})

/**
 * 世预赛
 */
export const getSoccerWorldPre = createModel("soccer_world_pre", {
    url: '/data/worldpre',
    expire: defaultExpire
})


/**
 * 获取NBA排行榜详细数据
 */
export const getAllNBARank = createModel("all_nba_rank", {
    url: '/nba/getDailyPlayer',
    expire: defaultExpire
})

/**
 * 获取足球排行榜详细数据
 */
export const getAllSoccerRank = createModel("all_soccer_rank",{
    url: '/data/footballAllRank',
    expire: defaultExpire
})

/**
 * 足球交易排行数据
 */
export const getAllSoccerTransfer = createModel("all_soccer_transfer", {
   url:'/data/footballAllTransfer',
   expire: defaultExpire
})
