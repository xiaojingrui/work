import Vue from 'vue'
import VueRouter from 'vue-router'
import routerConfig from './router'
import Page from './views/root'
import { App, initPage } from 'common/app'
import { setEnv } from './common/config'

App( (debug, env) => {
    //设置开发环境
    setEnv(env);
    //页面初始化
    initPage(window.HupuBridge.nainfo);

    //开始路由
    Vue.use(VueRouter);
    const router = new VueRouter({
      hashbang: true,
      history: false,
      saveScrollPosition: false,
      suppressTransitionError: true
    });
    routerConfig(router);
    router.start(Page, '#app');
    window.router = router
})
