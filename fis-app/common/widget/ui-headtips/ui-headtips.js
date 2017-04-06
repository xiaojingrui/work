/**
 * 五个TAB下的数据，按照以下格式整理
 * 前面的英文名，后面的关键词全部按照英文","分割，为后续图片的名字，不能包含特殊字符，如果没有英文名，就用拼音缩写，不要有重复就好
 */
 var nba = {
    "nba1":"萌神,佛祖,我库,我杜,我勇,傻库,渣勇,水花,铁杜,汤汤,汤神,勇士加油,勇士必胜,Strength in Numbers,strength in numbers,warriors,Warriors",
    "nba2":"字母哥,米豆,牡蛎,肥帕,德皇,张汉三,雄鹿加油,雄鹿必胜,Fear the Deer,fear the deer,bucks,Bucks",
    "nba3":"库班,小巴,蜗牛,我垃,蝶龙,马腿,银角大王,小牛加油,小牛必胜,mavs,Mavs,mavericks,Mavericks",
    "nba4":"水鸟,浓眉,假日,特伦斯,鹈鹕加油,鹈鹕必胜,pelicans,Pelicans",
    "nba5":"沃伦,涡轮,血布,菲尼克斯,钱总,拳王,巴西闪电,太阳加油,太阳必胜,suns,Suns",
    "nba6":"烂泥,甜瓜,肥瓜,KP,我尼,建宁,铂金,肥罗,怂罗,铁罗,波神,尼克斯加油,尼克斯必胜,knicks,Knicks",
    "nba7":"木狼,哈士奇,路标,卢员外,金童,窝糖,Kat,三水,森林狼加油,森林狼必胜,timberwolves,Timberwolves",
    "nba8":"我热,白边,爪机,萌波,哈队,韦特斯爸爸,渔村三少,热火加油,热火必胜,heat,Heat",
    "nba9":"我骑,老詹,老汉,骚文,划水詹,丑文,香饽饽,破骑,二文,乐邦,骑士加油,骑士必胜,all in,All In,one for all,One For All,all for one,All For One,cavs,Cavs,cavaliers,Cavaliers",
    "nba10":"我巫,水沃,狗塔,索大腿,泥污,囧墙,奇才加油,奇才必胜,wizards,Wizards",
    "nba11":"我湖,唠嗑,水拉,蓝豆,莺歌,蜗壳,Swaggy P,少侠,芦苇,路威,卧虎,杨叔,儿砸,傻豆,黑豆,路爹,我科,湖人加油,湖人必胜,laker,Laker",
    "nba12":"我船,破船,我炮,我芬,傻芬,短芬,小河,斯帝,河文档,皇叔,快船加油,快船必胜,clippers,Clippers",
    "nba13":"骚韦,吉米,MCW,典韦,公牛加油,公牛必胜,bulls,Bulls",
    "nba14":"考神,神庙,理智妹,国王加油,国王必胜,kings,Kings",
    "nba15":"我龙,神龙架詹姆斯,瓦兰,瓦蓝,小钢炮,猛龙加油,猛龙必胜,We the North,We the north,raptors,Raptors",
    "nba16":"童工,28卡,拖把头,爆炸头,魔术加油,魔术必胜,magic,Magic",
    "nba17":"窝刺,圣村,家嫂,大加,奇奇,小卡,小可爱,卡哇伊,铁林,皇阿玛,小绿,绿宝,大锤,人类蠕动精华,床垫,妖刀,秃子,小魔力,我呆,石佛,马刺加油,马刺必胜,spurs,Spurs",
    "nba18":"我费,寸草不生,铁桃,投石机,斯陶,贝勒爷,先有大帝后有天,76人加油,76人必胜,the process,sixers,Sixers,76ers",
    "nba19":"神龟,下水道,我雷,威少,西布,鸭蛋,莫大腿,螺纹鸡,我威,萝卜森,辛男神,二龟,雷霆加油,雷霆必胜,thunder,Thunder,okc,OKC",
    "nba20":"泡椒,娘神,我遛,铁杨,太子基,步行者加油,步行者必胜,pacers,Pacers",
    "nba21":"杯子猫,莫儿,我鹰,米神,老鹰加油,老鹰必胜,hawks,Hawks",
    "nba22":"豪哥,我网,大洛,钻石,破网,佛爷,小林子,林教头,本大帝,篮网加油,篮网必胜,nets,Nets",
    "nba23":"沃克,我蜂,窝蜂,巴图,我鸡,水三,三婶,hornets,Hornets",
    "nba24":"我拓,图图,利指导,撕裂之城,大西北永不干涸,开拓者加油,开拓者必胜,blazeres,Blazeres",
    "nba25":"我爵,九妹,水蛋,焦志喜,小山,海公公,单打乔,当代乔丹,屌哥,爵士加油,爵士必胜,jazz,Jazz",
    "nba26":"我掘,烂矿,渣金,鸟森,穆皇,弩机,掘金加油,掘金必胜,nuggets,Nuggets",
    "nba27":"我火,登哥,咯噔,圣骑士,连长,卡片,小胡子,大胡子,神灯,骑兵连,双登,窝火,肥内,安德神,登登,哈基石,神登,卡皇,血贝,中国弩,莫胖子,我登,火箭加油,火箭必胜,rockets,Rockets",
    "nba28":"我凯,绿军,绿衫军,少帅,伙夫,小刺客,凯尔特人加油,凯尔特人必胜,celtics,Celtics",
    "nba29":"庄神,雷吉,大范,我塞,托哈,马裤,伊妹,马杨,尤老爷子,活塞加油,活塞必胜,motor city,Motor city,pistons,Pistons",
    "nba30":"我熊,烂豆腐,小加,黑白双熊,肥卡,蛋林,灰熊加油,灰熊必胜,Grit,grit,grind,Grind,grazzlies,Grazzlies"
}

var cba = {
    "cba1":"我鱼,大姚,刘晓宇,寂寞大神,max,卢爹,大鲨鱼加油,大鲨鱼必胜",
    "cba2":"我厦,林教授,胡金秋,辫子哥,野兽",
    "cba3":"我粤,我广,阿联,杜锋,华叔,华南虎,八冠王,朱八,二飞",
    "cba4":"我疆,劳道,西热,小诸葛,魔王,可兰",
    "cba5":"削他,大侄子,纪委,老叔,宋小宝,哈爹,鹈鹕名宿",
    "cba6":"我京,老马,政委,首钢是冠军,大树,小川",
    "cba7":"我深,阿豪,大狙",
    "cba8":"我吉,东北虎,邓华德,小崔",
    "cba9":"小丁,睢冉,小鲨",
    "cba10":"我晋,闹他,大波,洪队,许指导,小富",
    "cba11":"小科比,胡大爷,瘦狗,肯帝亚,老胡",
    "cba12":"我川,蓝鲸,刘炜",
    "cba13":"巩晓彬,张骋宇",
    "cba14":"杰特,张楠,桑尼",
    "cba15":"我闽,泰隆",
    "cba16":"金牛,吴前",
    "cba17":"阿指导,肘子,付豪,大郅,八一加油,八一必胜",
    "cba18":"北控,王锡东,贺希宁",
    "cba19":"阿巴斯,丁伟,冯欣,同曦加油,同曦必胜",
    "cba20":"郑准,鞠明欣"
}

var chinaSoccer = {
    "csl1": "苏宁必胜,苏宁加油,苏宁是冠军",
    "csl2": "我恒,我喵,广州未赢够,骚郜,张莫斯,天河不败,郜林斯曼,天河之王,圣曾诚,恒大必胜,恒大加油,恒大是冠军",
    "csl3": "我港,我小破港,上港必胜,上港加油,上港是冠军",
    "csl4": "我花,圣虹口,曹赟定老卵,申花老卵,曹28,申花必胜,申花加油,申花是冠军",
    "csl5": "我安,朴太萌,龙队,嘟嘟,欣姐,罗胖,高大爷,国安必胜,国安加油,国安是冠军,国安永远争第一",
    "csl6": "我咸,富力必胜,富力加油",
    "csl7": "大华夏,华夏必胜,华夏加油",
    "csl8": "我帆,小摩托,小破帆,力帆必胜,力帆加油,力帆雄起",
    "csl9": "大延边,延边必胜,延边加油",
    "csl10": "我达,泰达必胜,泰达加油,我津",
    "csl11": "辽足必胜,辽足加油",
    "csl12": "亚泰必胜,亚泰加油",
    "csl13": "我业,建业必胜,建业加油",
    "csl14": "王小胖,蒙妞,蒙神,水塔,王鲁尼,大雷牛逼,感谢大雷,泰山队,鲁能必胜,鲁能加油",
    "csl15": "小绿城,小破城,大绿城,绿城加油,绿城必胜",
    "csl16": "大永昌,裕彤,永昌加油,永昌必胜",
    "csl17": "卡纳瓦罗加油,权健必胜,权健加油,恭喜权健",
    "csl18": "贵州弹起,贵州加油,贵州必胜"
}

var fifaSoccer = {
    "fifa1" : "我车,破车,我租,蓬蓬,孔二愣,我扎,阿紫,委员长,扎球王,切尔西加油",
    "fifa2" : "我厂,破厂,教授,桑大腿,萌雷,大吉鲁,厄祖,阿森纳加油",
    "fifa3" : "我魔,我抬,红魔,鸟叔,大奉先,大伊布,马塔叔叔,饼队,曼联加油",
    "fifa4" : "我团,我皇,罗总裁,水爷,魔笛,阿宽,纳爹,笨马,齐祖,皇马加油,我罗威武,Hala Madrid,hala madrid,美凌格",
    "fifa5" : "我村,我萨,我梅,白总,皮主席,恩叔,梅老板,巴萨加油,梅西威武,Forca Barca,forca barca",
    "fifa6" : "我军,杰队,YNWA,KOP,利物浦加油,永不独行,詹俊滑跪",
    "fifa7" : "我其,我饼,我仁,小新,队短,大狸子,刘星,二娃,拜仁加油,臀新",
    "fifa8" : "我妇,我黼,我囧,囧叔,总攻,马绩效,师太,尤文加油",
    "fifa9" : "我纯,国米加油,国米威武,国米是冠军,国际米兰加油,小纯,小破纯",
    "fifa10" : "我毛,我米,我米威武,我米是冠军,AC米兰加油,forza milan,Forza Milan",
    "fifa11" : "我城,瓜叔,曼城加油",
    "fifa12" : "我床,我竞,萌妮,马竞加油",
    "fifa13" : "我横,美羊,多特加油,大黄蜂加油,大黄蜂威武,小多特,尾灯,Heja BVB,heja bvb,heja BVB",
    "fifa14" : "我骡,罗马加油,村长",
    "fifa15" : "蓝鹰,拉齐奥加油",
    "fifa16" : "热刺加油,孙球王",
    "fifa17" : "我狐,莱斯特加油,蓝狐加油,莱斯特城老球迷",
    "fifa18" : "沙尔克加油,沙尔克04加油",
    "fifa19" : "药厂,勒沃库森加油",
    "fifa20" : "梅村,不莱梅加油",
    "fifa21" : "我蝠,蝙蝠军团,瓦伦西亚加油",
    "fifa22" : "我潜,黄色潜水艇,黄潜",
    "fifa23" : "我大巴黎,大巴黎加油"
}

var hupuCulture = {
    "hupu1":"圣诞,JR,虎扑良心,感谢虎扑,最爱虎扑",
    "hupu2":"羊,他强任他强",
    "hupu3": "稳",
    "hupu4": "国足必胜,国足加油,男篮加油,男篮必胜,爱我中华"
}

var _ = require("underscore");
var dataOrigin = _.extend(nba, cba, chinaSoccer, fifaSoccer, hupuCulture);
for(var key in dataOrigin){
    if(dataOrigin.hasOwnProperty(key)){
        dataOrigin[key] = dataOrigin[key].split(",")
    }
}

var headTips = {
    matchContent: function (con){
        if(!con.trim()) return ""

        var map = {}, hash = [];
        for(var k in dataOrigin){
            for(var i = 0; i < dataOrigin[k].length; i++){
                var index = con.indexOf(dataOrigin[k][i]);
                if(~index){
                    //提高效率, 第一个词匹配直接命中.
                    if(index === 0){
                      return k
                    } else{
                      map[index] = k;
                      hash.push(index);
                    }
                }
            }
        }
        //最先出现的词为目标词
        var min = Math.min.apply(null, hash);
        return hash.length ? map[min] : ""
    },
    injectStyles: function(){
        var rules = []
        var baseRule = "background-size:100%; content:''; position:absolute; height:34px; width:34px; top:1px; right:-6px;"
        for(var k in dataOrigin){
            rules.push("." + k + ":after{background:url('//w10.hoopchina.com.cn/hybrid/resource/events/christmas2016/"+ k +".png') no-repeat;" + baseRule + "}")
        }
        var style = $('<style />', {
    	    html : rules.join("")
        }).appendTo('head')
    },
    addHeadTip: function (dom, con){
        var cls = this.matchContent(con);
        $(dom).addClass("added-tips");
        if(!!cls){
            $(dom).find(".user-avatar").addClass(cls)
        }
    },
    listen: function(replyContainer){
        var now = new Date().getTime()
        //活动期间为：2016/12/24 18:00:00 - 2016/12/26 18:00:00
        if(now < 1482573600000 || now > 1482746400000) return;

        this.injectStyles()

        var self = this
        var modifiedTodo = function(){
            $(replyContainer).find(".reply-list").not(".added-tips").each(function(idx, item){
                self.addHeadTip(item, $(item).find(".short-content").text())
            })
        }
        replyContainer.addEventListener("DOMSubtreeModified", modifiedTodo)
        //默认执行一遍
        modifiedTodo()
    }
}

module.exports = headTips
