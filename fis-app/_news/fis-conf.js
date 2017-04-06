fis.config.merge({
    namespace : 'news',
    pack : {
      'pkg/reply.js': [
        'widget/reply/popup.js',
        'widget/reply/purview.js',
        'widget/reply/reply.js'
      ],
      'pkg/detail.js':[
        'widget/detail/detail.js',
        'widget/remember-pos/remember-pos.js'
      ]
    },
    modules:{
        parser : {
            sass: 'sass',
            scss: 'sass'
        }
    },
    project:{
        exclude :[ '**/_*.scss']
    },
    roadmap : {
        ext : {
            //less后缀的文件将输出为css后缀
            //并且在parser之后的其他处理流程中被当做css文件处理
            scss : 'css',
            //coffee后缀的文件将输出为js文件
            //并且在parser之后的其他处理流程中被当做js文件处理
            coffee : 'js',
            //md后缀的文件将输出为html文件
            //并且在parser之后的其他处理流程中被当做html文件处理
            md : 'html'
        },
        // 开启图片合并功能
        path : {
            reg: '**.css',
            useSprite: true
        },
        domain: '//w10.hoopchina.com.cn/hybrid'
    },
    settings : {
        spriter : {
            csssprites : {
                margin : '20'
            }
        }
    },
    deploy : {
        //使用fisp release --dest qa138来使用这个配置
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
        }],
        //使用fisp release --dest qa13来使用这个配置
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
        }],
        // 测试环境
        bbstest: [{
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/bbs/php/public',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://bbs-test.mobileapi.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/front-end'
        }],
        //本地
        local: [{
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
