/**
 * 模块配置文件
 *
 */
const settings = {
    "test":{
        "protocol": 'http',
        "host": 'test.mobileapi.hupu.com'
    },
    "pre":{
        "protocol": 'http',
        "host": 'games-pre.mobileapi.hupu.com'
    },
    "production":{
        "protocol": 'http',
        "host": 'games.mobileapi.hupu.com'
    }
}

export const name = "data"
/**
 * condition 环境变量
 *
 * test -> 测试环境
 * pre  -> 预发布
 * production  -> 生产环境
 */
let env = "production"

/**
 * 客户端传递env字段为当前环境
 * 1为线上，2为预发布，3为测试
 */
export function setEnv( condEnv ){
    switch(condEnv){
        case 1:
            env = "production";
            break;
        case 2:
            env = "pre";
            break;
        case 3:
            env = "test";
            break;
        default:
            env = "production";
            break;
    }
}

export function protocol(){
    return settings[env]["protocol"]
}

export function host(){
    return settings[env]["host"]
}

export function origin(){
    return `${protocol()}://${host()}`
}
