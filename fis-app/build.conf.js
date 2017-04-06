module.exports = {
  output : "./dist/",
  outputConf: "resource.json",
  resourceMaps : ["common","news","bbs", "user", "match"].reduce(function(memo, item){
      memo.push("./output/config/"+ item +"-map.json");
      return memo;
  },[]),
  suports:["js","css"]
}
