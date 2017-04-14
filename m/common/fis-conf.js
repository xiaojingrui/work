fis.config.merge({
	namespace : 'common',
    pack : {
        'pkg/common.css' : [
            'static/common.scss',
            'widget/top-nav/**.css',
            'widget/inner-tab/**.css',
            'widget/ui/page-tools/**.css',
            'widget/ui/login/**.css',
            'widget/ui/tips/**.css',
            'widget/ui/dialog/**.scss',
            'widget/ui/page/**.css',
            'widget/card-ad/**.css',
            'widget/footer/footer.scss'
        ],
        'pkg/news.css':[
            'widget/relative-news/**.css',
            'widget/ui/share/**.css',
            'widget/inner-top-nav/**.css'
        ],
        'pkg/lib.js':[
            'static/mod.js',
            'static/js/zepto/zepto.min.js',
            'static/js/underscore/underscore.js',
            'static/init.js'
        ],
        'pkg/common.js' : [
            'widget/ui/page-dace/page-dace.js',
            'widget/ui/page-tools/page-tools.js',
            'widget/ui/section-exposure/section-exposure.js',
            'widget/ui/login/login.js',
            'widget/ui/tips/tips.js',
            'widget/ui/page/page.js',
            'widget/ui/util/util.js',
            'widget/ui/target-jump/*.js',
            'widget/ui/dialog/dialog.js',
            'widget/ui/share/share.js',
            'widget/ui/weixin-tool/weixin-tool.js',
            'widget/top-nav/top-nav.js',
            'widget/inner-tab/tab.js',
            'static/js/global/global.js'
        ],
        'pkg/uploadIMG.js' : [
            'widget/ui/upload-image/*.js'
        ]
    },
    modules : {
        parser: {
            sass : 'sass',
            scss: 'sass'
        },
        scss: 'sass'
    },
    roadmap : {
        ext: {
            sass: 'css',
            scss: 'css'
        },
        domain: '//b3.hoopchina.com.cn/touch, //b2.hoopchina.com.cn/touch, //b1.hoopchina.com.cn/touch'
    },
    project : {
        exclude: ['**/_*.scss', '**/vendor', "**/static/mini.sh","**/static/watch*.js"]
    },
    deploy : {
        //使用fisp release --dest qa131来使用这个配置
        //开发环境
        qa131: [{
            receiver: 'http://192.168.9.131/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/front-end',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.9.131/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.9.131/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.9.131/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/front-end'
        }],
        // 开发环境
        qa36: [{
            receiver: 'http://192.168.8.36/receiver.php',
            from: '/static',
            to: '/opt/www/touch/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.36/receiver.php',
            from: "/template",
            to: '/opt/www/touch/front-end'
        }, {
            receiver: 'http://192.168.8.36/receiver.php',
            from: "/config",
            to: '/opt/www/touch/front-end'
        }, {
            receiver: 'http://192.168.8.36/receiver.php',
            from: "/plugin",
            to: '/opt/www/touch/front-end'
        }],
        // 开发环境
        qa184: [{
            receiver: 'http://192.168.8.184/receiver.php',
            from: '/static',
            to: '/opt/www/touch/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.184/receiver.php',
            from: "/template",
            to: '/opt/www/touch/front-end'
        }, {
            receiver: 'http://192.168.8.184/receiver.php',
            from: "/config",
            to: '/opt/www/touch/front-end'
        }, {
            receiver: 'http://192.168.8.184/receiver.php',
            from: "/plugin",
            to: '/opt/www/touch/front-end'
        }],
        //测试环境
        qa52: [{
            receiver: 'http://192.168.8.52/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/m/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/m/front-end'
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/m/front-end'
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/m/front-end'
        }],
        // 前后端分离环境
        qa52detach: [{
            receiver: 'http://192.168.8.52/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/front-end',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/front-end'
        }],
        // 17前后端分离环境
        qa17: [{
            receiver: 'http://192.168.8.17/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/m-test/m/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.17/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.8.17/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }],
        //测试环境
        qa52cn: [{
            receiver: 'http://192.168.8.52/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/m_cn/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/m_cn/front-end'
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/m_cn/front-end'
        }, {
            receiver: 'http://192.168.8.52/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/m_cn/front-end'
        }],
        //静态cdn，编译时加上--domains
        b1: {
            from: '/static',
            to: '../../b1/touch'
        },
        //本地
        local: [{
            from: '/static',
            to: '../../b1/touch'
        }, {
            from: "/plugin",
            to: '../output'
        },{
            from: "/template",
            to: '../output'
        }, {
            from: "/config",
            to: '../output'
        }]
    }
});
