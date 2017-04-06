import default404 from 'common/default404'
import detail from './views/detail'

export default function(router) {

  router.map({
      '*': {
          component: default404
      },
      '/detail': {
          component: detail
      }
  });

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
