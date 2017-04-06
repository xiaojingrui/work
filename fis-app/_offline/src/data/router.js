import default404 from 'common/default404'
import nba from './views/nba'
import cba from './views/cba'
import soccer from './views/soccer'
import soccer_zxb from './views/soccer_zxb'
import soccer_fifa from './views/soccer_fifa'
import soccer_worldpre from './views/soccer_worldpre'
import olympic from './views/olympic'
// import allNBARank from './views/all_nba_rank'
// import allSoccerRank from './views/all_soccer_rank'
// import allNBAHurtInfo from './views/all_nba_hurt_info'
// import allNBATradeInfo from './views/all_nba_trade_info'
// import allSoccerTransferPlayer from './views/all_soccer_transfer_player'

export default function(router) {
  let map = {
  }

  let routerMap = {
    '*': default404,
    '/nba': nba,
    '/cba': cba,
    '/csl': soccer,
    '/csl_zj': soccer,
    '/afccl': soccer,
    '/cl': soccer,
    '/epl': soccer,
    '/zxb': soccer_zxb,
    '/worldpre': soccer_worldpre,
    '/national': soccer_fifa,
    '/chlg': soccer,
    '/fifa': soccer,
    '/liga': soccer,
    '/bund': soccer,
    '/seri': soccer,
    '/fran': soccer,
    '/uefael': soccer,
    '/eurocup': soccer,
    '/amerciacup': soccer,
    '/olympic': olympic
  }

  Object.keys(routerMap).forEach(key =>{
      map[key] = {
        component: routerMap[key]
      }
  })

  router.map(map);

  router.beforeEach(function({to, from, next}) {
    let toPath = to.path;
    let fromPath = from.path;
    if (toPath.replace(/[^/]/g, '').length > 1) {
      router.app.isIndex = false
    } else {
      router.app.isIndex = true
    }
    next()
  })

}
