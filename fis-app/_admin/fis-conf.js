fis.config.merge({
    namespace : 'admin',
    pack : {
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
        domain: '//w3.hoopchina.com.cn/hybrid,//w2.hoopchina.com.cn/hybrid, //w1.hoopchina.com.cn/hybrid'
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
        qiuzzytest: [{
            receiver: 'http://games-zzy.mobileapi.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/games/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://games-zzy.mobileapi.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/front-end'
        }, {
            receiver: 'http://games-zzy.mobileapi.hupu.com/receiver.php',
            from: "/config",
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
        }],
        //本地
        local: [{
            from: "/template",
            to: '../output',
            exclude: [/\/sass\//i]
        }, {
            from: "/config",
            to: '../output',
            exclude: [/\/sass\//i]
        }, {
            from: "/static",
            to: '../output',
            exclude: [/\/sass\//i]
        }],
        //上线
        online: [{
            from: "/template",
            to: '../output',
            exclude: [/\/sass\//i]
        }, {
            from: "/config",
            to: '../output',
            exclude: [/\/sass\//i]
        }, {
            from: "/static",
            to: '../../w1/hybrid/',
            exclude: [/\/sass\//i]
        }]
    }
});
