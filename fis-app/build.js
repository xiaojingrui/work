var fs = require("fs"),
    pth = require('path'),
    AdmZip = require('adm-zip'),
    wget = require('./lib/wget'),
    Util = require('./lib/util');

var version = "1.0.0";
var config = require("./build.conf");

function getMapFiles(mapSrc){
  var result = [];
  var deps = [];
  var has = [];
  if(Util.isFile(mapSrc)){
     var resMap = JSON.parse(fs.readFileSync(mapSrc, "utf-8"));

     //打包引用pkg资源
     for(var key in resMap.pkg){
        var res = resMap.pkg[key];
        if(~config.suports.indexOf(res.type)){
           result.push({
             uri: "http:"  + res.uri,
             type: res.type
           });
           result.push({
             uri: "https:" + res.uri,
             type: res.type
           });
           deps = deps.concat(res.deps);
           has = has.concat(res.has);
        }
     }
     //打包引用res资源
     for(var key in resMap.res){
        var res = resMap.res[key];
        if(~config.suports.indexOf(res.type) && !~deps.indexOf(key) && !~has.indexOf(key) ){
            result.push({
              uri: "http:"  + res.uri,
              type: res.type
            });
            result.push({
              uri: "https:" + res.uri,
              type: res.type
            });
        }
     }
  } else{
     console.error("[ERROR]: %s is notFound.", mapSrc)
  }
  return result;
}

function build( mods ){
  var modRes = [];
  var limit = 0;
  var resource = {
    version: version,
    resourcemap:{}
  };
  mods.forEach(function(mod){
    console.log("Start parse: %s", mod)
    modRes = modRes.concat(getMapFiles(mod))
  });
//增加考试系统资源
modRes.push({
    uri:'http://w1.hoopchina.com.cn/hybrid/exam/static/index.5f7d513e5cc60d73cf77.js',
    type:'js'
});
//增加考试系统资源
modRes.push({
    uri:'https://w1.hoopchina.com.cn/hybrid/exam/static/index.5f7d513e5cc60d73cf77.js',
    type:'js'
});
modRes.push({
    uri:'http://w1.hoopchina.com.cn/hybrid/exam/static/index.c3764957b3bee8bdd00fc3e38641a8f1.css',
    type:'css'
});
modRes.push({
    uri:'https://w1.hoopchina.com.cn/hybrid/exam/static/index.c3764957b3bee8bdd00fc3e38641a8f1.css',
    type:'css'
});


  Util.mkdir(config.output);
  config.suports.forEach(function(name){
      Util.mkdir( pth.join(config.output, name) )
  });
  fs.readFile("./lib/empty.js", "utf-8", function(err, content){
    fs.writeFileSync(pth.join(config.output, "js", "empty.js"), content);
    resource.resourcemap["empty"] = "js/empty.js";
  });

  var interval = null;
  var activeDownload = null;
  loop();
  function loop(){
      var res = getPop();
      if(res && res.uri){
          downLoadRes(res);
      } else{
         activeDownload = null;
         clearTimeout(interval);
         finished();
      }
  }

  function downLoadRes(res){
      activeDownload = res;
      wget(res.uri, function (filename, data) {
          if (filename === null) {
              console.error('Can\'t get uri: ' + res.uri);
              process.exit(1);
          }
          fs.writeFile(pth.join(config.output, res.type, filename), data, function (err) {
            if (err) {
               console.error(err.message);
               return
            }
             resource.resourcemap[res.uri] = [res.type, filename].join("/");
             setTimeout(loop, 500);
          });
      });
      //如果3s没下载下来，重新执行下载
      interval = setTimeout(function(){
          if(activeDownload && activeDownload.uri == res.uri){
              downLoadRes(res);
          }
      }, 3000);
  }

  function getPop(){
      return modRes.pop();
  }

  function finished(){
    console.log("Start create config file...")
    // 生产配置文件
    var confJson = JSON.stringify(resource, null, 4);
    Util.write(pth.join(config.output, config.outputConf), confJson, "utf8");

    console.log("Start create zip pkg...")
    // 创建zip包
    var zip = new AdmZip();
    zip.addLocalFolder(config.output);
    zip.writeZip( pth.join(config.output, "offline.prd.zip" ) );
    console.log("Offline pkg is ready! please send to client develop..");
    process.exit(1);
  }
}

build(config.resourceMaps);
