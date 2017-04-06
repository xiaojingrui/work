import default404 from 'common/default404'
import Welcome from './views/welcome'
import Exam from './views/exam'
import Finish from './views/finish'

export default function(router) {
  router.map({
    '*': {
      component: default404
    },
    '/welcome/:id': {
      component: Welcome
    },
    '/exam/:id': {
      component: Exam
    },
    '/finish/:id': {
      component: Finish
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
