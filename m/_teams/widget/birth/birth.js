/**
 * @name 判断生日插件
 * @author huangmian@hupu.com
 * 
 ****/

var snow = require('./snow.js');

var birth = {
	init: function(localKey){
		this.birthDate = $("#J-birth-date").html();
		this.birthStatus = $(".birth-status");
		this.localKey = localKey;
		if(this.isBirth() && localStorage.getItem(this.localKey) < 3){
			this.birthStatus.show();
			this.birthDrop();
		}
		if(!this.isBirth()){
			localStorage.removeItem(this.localKey);
		}
	},

	isBirth: function(){
		// 前端js判断
		
		// var str = this.birthDate,
		// 	date = new Date();

		// // 获取生日中的月份和日期
		// var birthArray = str.replace(/\W/g,'|').split('|').slice(1,3);

		// if(birthArray[0] == date.getMonth()+1 && birthArray[1] == date.getDate()){
		// 	this.birthStatus.show();
		// 	return true;
		// }
		
		// return false;
		
		// 服务端判断
		return GM.isBirth;
		
	},

	birthDrop: function(){
		var img = ["1f381", "1f382", "1f389"],
			randomImg = "http://w1.hoopchina.com.cn/hybrid/resource/emoji/"+img[Math.round(Math.random()*(img.length-1))]+".png",
			imgNum = 80,
			time = 5000,
			dropTimes = localStorage.getItem(this.localKey) || 0; //掉落次数

		snow.create(randomImg, imgNum);

		setTimeout(function(){
			snow.remove();
		},time);

		dropTimes++;

		localStorage.setItem(this.localKey, dropTimes);
	}
	
};

module.exports = birth;