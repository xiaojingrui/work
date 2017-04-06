fis.config.merge({
	namespace : 'common',
    pack : {
       'pkg/lib.js':[
            'static/mod.js',
            'static/js/zepto/zepto.js',
            'static/js/underscore/underscore.js',
            'widget/ui-dace/ui-dace.js',
            'widget/ui-watch/ui-watch.js',
            'static/global.js'
        ],
        'pkg/common-ui.js':[
			'widget/ui-events/ui-events.js',
            'widget/ui-tools/ui-tools.js',
            'widget/ui-toast/ui-toast.js',
            'widget/ui-warn/ui-warn.js',
            'widget/ui-versions/ui-versions.js',
            'widget/ui-app/ui-app.js',
			'widget/ui-refresh/ui-refresh.js',
            'widget/ui-store/*',
            'widget/click-image-show/click-image-show.js',
			'widget/ui-vote/ui-vote.js'
        ],
        'pkg/common.css':[
            'static/common.scss',
            'widget/ui-toast/ui-toast.scss',
			'widget/ui-refresh/ui-refresh.css',
            'widget/ui-warn/ui-warn.css',
			'widget/ui-vote/ui-vote.scss'
        ],
        'pkg/backbone.js':[
            'widget/lib/**.js'
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
        domain: '//w10.hoopchina.com.cn/hybrid'
    },
    project : {
        exclude: ['**/_*.scss', '**/vendor', "**/static/mini.sh","**/static/watch*.js"]
    },
    deploy : {
        //使用fisp release --dest qa38来使用这个配置
        //开发环境
        qa13: [{
            receiver: 'http://games-dev.mobileapi.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/games_mobile/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://games-dev.mobileapi.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://games-dev.mobileapi.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://games-dev.mobileapi.hupu.com/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/front-end'
        }],
        //开发环境
        qa38: [{
            receiver: 'http://192.168.8.38/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/games/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.8.38/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.8.38/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://192.168.8.38/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/front-end'
        }],
        // bbs测试环境
        bbstest: [{
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/kqbbs/php/public',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/kqbbs/front-end'
        }, {
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/kqbbs/front-end'
        }, {
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/kqbbs/front-end'
        }],
        // 测试环境
        qiutest: [{
            receiver: 'http://test.mobileapi.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/games/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://test.mobileapi.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://test.mobileapi.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://test.mobileapi.hupu.com/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/front-end'
        }],
        // 违禁图片测试环境
        admintest: [{
            receiver: 'http://my.hupu.com/receive.php',
            from: '/static',
            to: '/home/www/hoopchina/user/static',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://my.hupu.com/receive.php',
            from: "/template",
            to: '/home/www/hoopchina/user/templates_against'
        }, {
            receiver: 'http://my.hupu.com/receive.php',
            from: "/config",
            to: '/home/www/hoopchina/user/templates_against'
        },{
            receiver: 'http://my.hupu.com/receive.php',
            from: "/plugin",
            to: '/home/www/hoopchina/user/templates_against'
        }],
        qiutest1: [{
            receiver: 'http://test1.mobileapi.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/games/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://test1.mobileapi.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://test1.mobileapi.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://test1.mobileapi.hupu.com/receiver.php',
            from: "/plugin",
            to: '/data/www-data/hupu.com/front-end'
        }],
        //本地
        local: [{
            from: "/plugin",
            to: '../output'
        },{
            from: "/template",
            to: '../output'
        }, {
            from: "/config",
            to: '../output'
        }, {
            from: "/static",
            to: '../output'
        }],
        //上线
        online: [{
            from: "/plugin",
            to: '../output'
        },{
            from: "/template",
            to: '../output'
        }, {
            from: "/config",
            to: '../output'
        }, {
            from: "/static",
            to: '../../w1/hybrid/'
        }]
    }
});
