fis.config.set('modules.postpackager','simple');
fis.config.merge({
    namespace : 'teams',
    modules:{
        parser : {
            sass: 'sass',
            scss: 'sass'
        },
        postprocessor : {
            css: 'autoprefixer'
        }
    },
    project:{
        exclude :[ '**/_*.scss']
    },
    roadmap : {
        ext : {
            scss : 'css',
            coffee : 'js',
            md : 'html'
        },
        path : {
            reg: '**.css',
            useSprite: true
        },
        domain: '//b3.hoopchina.com.cn/touch, //b2.hoopchina.com.cn/touch, //b1.hoopchina.com.cn/touch'
    },
    settings : {
        spriter : {
            csssprites : {
                margin : '20'
            }
        }
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
        }],
        //开发环境
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
        }],
        //daxin
        daxin: [{
            receiver: 'http://192.168.9.131/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/touch/web',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://192.168.9.131/receiver.php',
            from: "/template",
            to: '/data/www-data/front-end'
        }, {
            receiver: 'http://192.168.9.131/receiver.php',
            from: "/config",
            to: '/data/www-data/front-end'
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
            from: "/template",
            to: '../output'
        }, {
            from: "/config",
            to: '../output'
        }]
    }
});
