var _ = require("underscore");
var dace = require("common:widget/ui-dace/ui-dace.js");
var snow = require('./snow.js');
var version = require("common:widget/ui-versions/ui-versions.js");

function initBridge(callback) {
    if(window.HupuBridge){
        callback();
    }else{
        document.addEventListener("hupuBridgeReady", function(){
            callback();
        });
    }
}

var mySwiper;

var nbaPlayer = {

	init: function() {
		this.render();
		this.bind();
		this.localKey = "nbaplayer_" + $(".tab-map").data("playerid") + "_dropTimes";
		if (this.isBirth() && localStorage.getItem(this.localKey) < 3) {
			if(GM.tid != 0) {
				this.birthStatus.show();
				this.birthDrop();
			}

		}
		if (!this.isBirth()) {
			localStorage.removeItem(this.localKey);
		}
		if(version.gte(GM.version,"7.0.6")){
			initBridge(function(){
			   HupuBridge.send("hupu.ui.header", {
				    title: GM.player_name,
				    subtitle : GM.player_enname
			   }, function(){
			   });
			});
		}else{
			$(".football-team-data a").click(function(event) {
				event.preventDefault();
				$("football-team-data span img").hide();
			}) 
		}
	},

	render: function() {
		this.nbaPlayerContainer = $("#J-nba-player-wrap");
		this.mapDataContainer = $("#J-map-data");
		this.tabContainer = $("#J-tab");
		this.tMapContainer = $("#J-t-map");
		this.birthDate = $("#J-birth-date").html();
		this.birthStatus = $(".J-birth-status");


		this.currentTime = new Date().getTime();
		this.winWidth = this.tabContainer.width();

		this.tplMapRender = _.template($("#J-map-tpl").html());
	},

	birthDrop: function() {
		var img = ["1f381", "1f382", "1f389"];
		var randomImg = "http://w1.hoopchina.com.cn/hybrid/resource/emoji/2x/" + img[Math.round(Math.random() * (img.length - 1))] + ".png";
		var imgNum = 80;
		var time = 5000;
		var dropTimes = 0; //掉落次数

		snow.create(randomImg, imgNum);
		setTimeout(function() {
			snow.remove();
		}, time);

		dropTimes = localStorage.getItem(this.localKey);
		dropTimes++;
		localStorage.setItem(this.localKey, dropTimes);
	},

	isBirth: function() {
		// 前端 js判断
		// var self = this;

		// var str = self.birthDate;
		// var yearIndex = str.indexOf("年");
		// var monthIndex = str.indexOf("月");
		// var dayIndex = str.indexOf("日");

		// var date = new Date();

		// if (str.substring(yearIndex + 1, monthIndex) == date.getMonth() + 1 && str.substring(monthIndex + 1, dayIndex) == date.getDate()) {
		// 	$(".J-birth-status").show();
		// 	return true;
		// }
		// return false;

		// 服务端判断
		return GM.isBirth;
	},

	bind: function() {
		var self = this;
		var playerId = getQueryString("player_id");
		var seasonType = $("#J-season-type");
		//目前热图只支持当前赛季的数据
		//var season = $(".condition .default span").html();
		var season = "2016";
		var tabOn = true;

		self.tabContainer.find("li").on("click", function() {
			var index = $(this).index();

			$(this).addClass("active").siblings("li").removeClass("active");
			// self.nbaPlayerContainer.find(".t-content").eq(index).show().siblings(".t-content").hide();
			if(index == 0){
				dace.send("profile");

			}
			else if(index == 1){
				if(self.hasMapData){
					dace.send("hotzones");
					setTimeout(function(){
						self.autoSize.call(self);
					}, 300);
				}
			}else{
				dace.send("careerdata");
			}

        	mySwiper.slideTo(index, 400, false);

		});

		self.tabMap(playerId, seasonType.val(), season, function() {
			self.hasMapData = true;
			self.autoSize();
		});

		var str = $(".contract-details").html();
		$(".contract-details").html(str.replace(/\#/g, "<br>"));

		$(".data-list li>div").each(function() {
			if ($(this).hasClass("rank")) {
				$(".data-list li").css({
					"max-height:": "auto",
					"min-height": "58px"
				})
			}
		});

		mySwiper = new Swiper ('.swiper-container', {
			autoHeight: true,
			lazyLoading: true,
			preloadImages: false,
		    onSlideChangeStart: function(swiper){
		        self.tabContainer.find('li').eq(mySwiper.activeIndex).addClass("active").siblings().removeClass("active");
		    }
		});

		//NBA 季后赛 热图优化
		self.tMapContainer.find(".radio span").on("click", function(){
			$(this).addClass("active").siblings("span").removeClass("active");
			seasonType.val($(this).data("type"));
			if(tabOn){
				tabOn = false;
				self.tabMap(playerId, seasonType.val(), season, function() {
					self.hasMapData = true;
					self.autoSize();
					tabOn = true;
				});
			}
		});

		self.tMapContainer.find(".default").on("click", function(){
			$(this).next().show();
			$(this).css({
				"border-bottom-right-radius": "0",
				"border-bottom-left-radius": "0"
			});
		});

		self.tMapContainer.find(".option li").on("click", function(){
			$(this).parent().hide();
			$(this).parent().prev().find("span").html($(this).data("season"));
			self.tabMap(playerId, seasonType.val(), $(this).data("season"), function() {
				self.hasMapData = true;
				self.autoSize();
			});
		});

		$(document).on("click", function(event){
			$target = $(event.target);
			var obj = $target.parents().eq(0);
			if(obj.hasClass("inner") || obj.hasClass("default")){
				return false;
			}else{
				self.tMapContainer.find(".option").hide();
			}
		});

		$(window).on("resize load orientationchange", function() {
			self.autoSize();
		});

		function getQueryString(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
			var r = window.location.search.substr(1).match(reg);
			if (r != null) return unescape(r[2]);
			return null;
		}
	},

	tabMap: function(playerid, type, season, callback) {
		var self = this;
		$.ajax({
			url: "/nba/gethotspot",
			type: "GET",
			dataType: "json",
			data: {
				"client": GM.client,
				"player_id": playerid,
				"type": type,
				"season": season,
				"night": GM.night
			},
			success: function(data) {
				self.mapDataContainer.html(self.tplMapRender({
					datas: data.result.data
				}));
				self.tMapContainer.find(".update-time span").html(data.result.last_update);
				callback && callback();
			}
		});
	},

	autoSize: function() {
		var self = this;
		self.winWidth = $(window).width();//this.tabContainer.width();
		$("#myCanvas").attr("width", self.winWidth * 2);
		$("#myCanvas").attr("height", self.winWidth * 70 / 75 * 2);
		self.drawMap();
		$("#myCanvas").css("width", self.winWidth);
		$("#myCanvas").css("height", self.winWidth * 70 / 75);
	},

	drawMap: function() {
		var self = this;
		var c = document.getElementById("myCanvas");
		var cxt = c.getContext("2d");
		var GM_Rect_Ratio = 70 / 75;
		var GM_Width_Ratio = self.winWidth / 750 * 2;
		var GM_Height_Ratio = self.winWidth * GM_Rect_Ratio / 700 * 2;

		var oArea_1 = $(".area_1");
		var oArea_2 = $(".area_2");
		var oArea_3 = $(".area_3");
		var oArea_4 = $(".area_4");
		var oArea_5 = $(".area_5");
		var oArea_6 = $(".area_6");
		var oArea_7 = $(".area_7");
		var oArea_8 = $(".area_8");
		var oArea_9 = $(".area_9");
		var oArea_10 = $(".area_10");

		cxt.clearRect(0, 0, 750 * GM_Width_Ratio, 700 * GM_Height_Ratio);

		//区域一
		cxt.beginPath();
		cxt.moveTo(750 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(701 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(701 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(750 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_1.data("color");
		cxt.fill();


		//区域二
		cxt.beginPath();
		cxt.moveTo(734 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.lineTo(551 * GM_Width_Ratio, 322 * GM_Height_Ratio);
		cxt.quadraticCurveTo(670 * GM_Width_Ratio, 400 * GM_Height_Ratio, 701 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.lineTo(704 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(750 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(750 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_2.data("color");
		cxt.fill();


		//区域三
		cxt.beginPath();
		cxt.moveTo(16 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.lineTo(199 * GM_Width_Ratio, 322 * GM_Height_Ratio);
		cxt.quadraticCurveTo(365 * GM_Width_Ratio, 238 * GM_Height_Ratio, 551 * GM_Width_Ratio, 322 * GM_Height_Ratio);
		cxt.lineTo(734 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_3.data("color");
		cxt.fill();


		//区域四
		cxt.beginPath();
		cxt.moveTo(16 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.lineTo(199 * GM_Width_Ratio, 322 * GM_Height_Ratio);
		cxt.quadraticCurveTo(80 * GM_Width_Ratio, 400 * GM_Height_Ratio, 49 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.lineTo(46 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(0 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(0 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_4.data("color");
		cxt.fill();


		//区域五
		cxt.beginPath();
		cxt.moveTo(0 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(49 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(49 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(0 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_5.data("color");
		cxt.fill();


		//区域六
		cxt.beginPath();
		cxt.moveTo(701 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(493 * GM_Width_Ratio, 698 * GM_Height_Ratio);
		cxt.lineTo(493 * GM_Width_Ratio, 610 * GM_Height_Ratio);
		cxt.quadraticCurveTo(480 * GM_Width_Ratio, 560 * GM_Height_Ratio, 452 * GM_Width_Ratio, 540 * GM_Height_Ratio);
		cxt.lineTo(618 * GM_Width_Ratio, 378 * GM_Height_Ratio);
		cxt.quadraticCurveTo(650 * GM_Width_Ratio, 400 * GM_Height_Ratio, 701 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_6.data("color");
		cxt.fill();


		//区域七
		cxt.beginPath();
		cxt.moveTo(377 * GM_Width_Ratio, 282 * GM_Height_Ratio);
		cxt.quadraticCurveTo(497 * GM_Width_Ratio, 280 * GM_Height_Ratio, 618 * GM_Width_Ratio, 378 * GM_Height_Ratio);
		cxt.lineTo(452 * GM_Width_Ratio, 540 * GM_Height_Ratio);
		cxt.quadraticCurveTo(420 * GM_Width_Ratio, 510 * GM_Height_Ratio, 377 * GM_Width_Ratio, 510 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_7.data("color");
		cxt.fill();


		//区域八
		cxt.beginPath();
		cxt.moveTo(131 * GM_Width_Ratio, 379 * GM_Height_Ratio);
		cxt.quadraticCurveTo(216 * GM_Width_Ratio, 280 * GM_Height_Ratio, 377 * GM_Width_Ratio, 282 * GM_Height_Ratio);
		cxt.lineTo(377 * GM_Width_Ratio, 510 * GM_Height_Ratio);
		cxt.quadraticCurveTo(326 * GM_Width_Ratio, 510 * GM_Height_Ratio, 296 * GM_Width_Ratio, 542 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_8.data("color");
		cxt.fill();


		//区域九
		cxt.beginPath();
		cxt.moveTo(49 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(257 * GM_Width_Ratio, 698 * GM_Height_Ratio);
		cxt.lineTo(257 * GM_Width_Ratio, 610 * GM_Height_Ratio);
		cxt.quadraticCurveTo(270 * GM_Width_Ratio, 560 * GM_Height_Ratio, 296 * GM_Width_Ratio, 542 * GM_Height_Ratio);
		cxt.lineTo(136 * GM_Width_Ratio, 379 * GM_Height_Ratio);
		cxt.quadraticCurveTo(90 * GM_Width_Ratio, 400 * GM_Height_Ratio, 49 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_9.data("color");
		cxt.fill();


		//区域十
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 630 * GM_Height_Ratio, 118 * GM_Width_Ratio, 0, Math.PI, true);
		cxt.fillStyle = oArea_10.data("color");
		cxt.fill();
		cxt.beginPath();
		cxt.moveTo(257 * GM_Width_Ratio, 698 * GM_Height_Ratio);
		cxt.lineTo(257 * GM_Width_Ratio, 610 * GM_Height_Ratio);
		cxt.quadraticCurveTo(377 * GM_Width_Ratio, 450 * GM_Height_Ratio, 493 * GM_Width_Ratio, 610 * GM_Height_Ratio);
		cxt.lineTo(493 * GM_Width_Ratio, 698 * GM_Height_Ratio);
		cxt.closePath();
		cxt.fillStyle = oArea_10.data("color");
		cxt.fill();


		//外圈直线（右，白）
		cxt.beginPath();
		cxt.moveTo(49 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(49 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 9;
		cxt.stroke();

		//外圈直线（右，灰）
		cxt.beginPath();
		cxt.moveTo(49 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(49 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.strokeStyle = "#959595";
		cxt.lineWidth = 2;
		cxt.stroke();

		// 外圈直线（左，白）
		cxt.beginPath();
		cxt.moveTo(701 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(701 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 9;
		cxt.stroke();

		// 外圈直线（左，灰）
		cxt.beginPath();
		cxt.moveTo(701 * GM_Width_Ratio, 700 * GM_Height_Ratio);
		cxt.lineTo(701 * GM_Width_Ratio, 493 * GM_Height_Ratio);
		cxt.strokeStyle = "#959595";
		cxt.lineWidth = 2;
		cxt.stroke();

		//内围区域弧线
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 631 * GM_Height_Ratio, (350 + 3) * GM_Width_Ratio, Math.PI * 9 / 8, Math.PI * 15 / 8, false);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 9;
		cxt.stroke();

		//内围区域弧线
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 631 * GM_Height_Ratio, (350 + 3) * GM_Width_Ratio, Math.PI * 9 / 8, Math.PI * 15 / 8, false);
		cxt.strokeStyle = "#959595";
		cxt.lineWidth = 2;
		cxt.stroke();


		//内围折线
		cxt.beginPath();
		cxt.moveTo(51 * GM_Width_Ratio, 699 * GM_Height_Ratio);
		cxt.lineTo(257 * GM_Width_Ratio, 699 * GM_Height_Ratio);
		cxt.lineTo(257 * GM_Width_Ratio, 419 * GM_Height_Ratio);
		cxt.lineTo(493 * GM_Width_Ratio, 419 * GM_Height_Ratio);
		cxt.lineTo(493 * GM_Width_Ratio, 699 * GM_Height_Ratio);
		cxt.lineTo(699 * GM_Width_Ratio, 699 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();

		//内围弧线（实）
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 419 * GM_Height_Ratio, 88 * GM_Width_Ratio, 0, Math.PI, true);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();

		//内围弧线（虚线）
		for (var i = 0; i < 10; i++) {
			cxt.beginPath();
			cxt.arc(375 * GM_Width_Ratio, 419 * GM_Height_Ratio, 88 * GM_Width_Ratio, Math.PI * (4 * i) / 40, Math.PI * (4 * (i + 1) - 1) / 40, false);
			cxt.strokeStyle = "#fff";
			cxt.lineWidth = 3;
			cxt.stroke();
		}

		//两分点
		cxt.beginPath();
		//左
		cxt.moveTo(209 * GM_Width_Ratio, 698 * GM_Height_Ratio);
		cxt.lineTo(209 * GM_Width_Ratio, 688 * GM_Height_Ratio);
		cxt.moveTo(257 * GM_Width_Ratio, 594 * GM_Height_Ratio);
		cxt.lineTo(245 * GM_Width_Ratio, 594 * GM_Height_Ratio);
		cxt.moveTo(257 * GM_Width_Ratio, 582 * GM_Height_Ratio);
		cxt.lineTo(245 * GM_Width_Ratio, 582 * GM_Height_Ratio);
		cxt.moveTo(257 * GM_Width_Ratio, 536 * GM_Height_Ratio);
		cxt.lineTo(245 * GM_Width_Ratio, 536 * GM_Height_Ratio);
		cxt.moveTo(257 * GM_Width_Ratio, 490 * GM_Height_Ratio);
		cxt.lineTo(245 * GM_Width_Ratio, 490 * GM_Height_Ratio);
		//右
		cxt.moveTo(540 * GM_Width_Ratio, 698 * GM_Height_Ratio);
		cxt.lineTo(540 * GM_Width_Ratio, 688 * GM_Height_Ratio);
		cxt.moveTo(492 * GM_Width_Ratio, 594 * GM_Height_Ratio);
		cxt.lineTo(504 * GM_Width_Ratio, 594 * GM_Height_Ratio);
		cxt.moveTo(492 * GM_Width_Ratio, 582 * GM_Height_Ratio);
		cxt.lineTo(504 * GM_Width_Ratio, 582 * GM_Height_Ratio);
		cxt.moveTo(492 * GM_Width_Ratio, 536 * GM_Height_Ratio);
		cxt.lineTo(504 * GM_Width_Ratio, 536 * GM_Height_Ratio);
		cxt.moveTo(492 * GM_Width_Ratio, 490 * GM_Height_Ratio);
		cxt.lineTo(504 * GM_Width_Ratio, 490 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 2;
		cxt.stroke();


		//外围短线
		cxt.beginPath();
		cxt.moveTo(0 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(46 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.moveTo(750 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.lineTo(704 * GM_Width_Ratio, 520 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();
		//较长
		cxt.beginPath();
		cxt.moveTo(0 * GM_Width_Ratio, 283 * GM_Height_Ratio);
		cxt.lineTo(46 * GM_Width_Ratio, 283 * GM_Height_Ratio);
		cxt.moveTo(750 * GM_Width_Ratio, 283 * GM_Height_Ratio);
		cxt.lineTo(704 * GM_Width_Ratio, 283 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 2;
		cxt.stroke();


		//外围长线
		cxt.beginPath();
		cxt.moveTo(16 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.lineTo(199 * GM_Width_Ratio, 322 * GM_Height_Ratio);
		cxt.moveTo(734 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.lineTo(551 * GM_Width_Ratio, 322 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();


		//外围半圆弧
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 0, 37 * GM_Width_Ratio, 0, Math.PI, false);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 0, 90 * GM_Width_Ratio, 0, Math.PI, false);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();


		//内围圆弧
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 630 * GM_Height_Ratio, 118 * GM_Width_Ratio, 0, Math.PI, true);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 1;
		cxt.stroke();


		//内围半圆
		cxt.beginPath();
		cxt.arc(375 * GM_Width_Ratio, 630 * GM_Height_Ratio, 64 * GM_Width_Ratio, 0, Math.PI, true);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();

		cxt.beginPath();
		cxt.moveTo(311 * GM_Width_Ratio, 640 * GM_Height_Ratio);
		cxt.lineTo(311 * GM_Width_Ratio, 626 * GM_Height_Ratio);
		cxt.moveTo(439 * GM_Width_Ratio, 640 * GM_Height_Ratio);
		cxt.lineTo(439 * GM_Width_Ratio, 626 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 3;
		cxt.stroke();


		//内围直线
		cxt.beginPath();
		cxt.moveTo(135 * GM_Width_Ratio, 379 * GM_Height_Ratio);
		cxt.lineTo(296 * GM_Width_Ratio, 542 * GM_Height_Ratio);
		cxt.moveTo(377 * GM_Width_Ratio, 282 * GM_Height_Ratio);
		cxt.lineTo(377 * GM_Width_Ratio, 510 * GM_Height_Ratio);
		cxt.moveTo(617 * GM_Width_Ratio, 379 * GM_Height_Ratio);
		cxt.lineTo(452 * GM_Width_Ratio, 540 * GM_Height_Ratio);
		cxt.strokeStyle = "#fff";
		cxt.lineWidth = 1;
		cxt.stroke();



		//篮球
		cxt.beginPath();
		cxt.arc(377 * GM_Width_Ratio, 33 * GM_Height_Ratio, 18 * GM_Width_Ratio, 0, 2 * Math.PI, true);
		cxt.shadowBlur = 10;
		cxt.shadowColor = 'rgba(0, 0, 0, 0.5)';
		cxt.shadowOffsetX = 5;
		cxt.shadowOffsetY = -5;
		cxt.fillStyle = 'rgba(201, 144, 60, .8)';
		cxt.fill();

		cxt.beginPath();
		cxt.moveTo(377 * GM_Width_Ratio, 15 * GM_Height_Ratio);
		cxt.lineTo(377 * GM_Width_Ratio, 51 * GM_Height_Ratio);
		cxt.strokeStyle = "#97755b";
		cxt.lineWidth = .5;
		cxt.stroke();

		cxt.beginPath();
		cxt.moveTo(359 * GM_Width_Ratio, 33 * GM_Height_Ratio);
		cxt.lineTo(395 * GM_Width_Ratio, 33 * GM_Height_Ratio);
		cxt.strokeStyle = "#97755b";
		cxt.lineWidth = .5;
		cxt.stroke();

		cxt.beginPath();
		cxt.arc(410 * GM_Width_Ratio, 33 * GM_Height_Ratio, 26 * GM_Width_Ratio, 5 * Math.PI / 6, 7 * Math.PI / 6, false);
		cxt.strokeStyle = "#97755b";
		cxt.lineWidth = .5;
		cxt.stroke();

		cxt.beginPath();
		cxt.arc(344 * GM_Width_Ratio, 33 * GM_Height_Ratio, 26 * GM_Width_Ratio, Math.PI / 6, 11 * Math.PI / 6, true);
		cxt.strokeStyle = "#97755b";
		cxt.lineWidth = .5;
		cxt.stroke();


		//文字设置
		drawText(oArea_1.data("fgp") + "%", oArea_1.data("fgm") + "/" + oArea_1.data("fgs"), 720, 620, Math.PI); //1
		drawText(oArea_2.data("fgp") + "%", oArea_2.data("fgm") + "/" + oArea_2.data("fgs"), 700, 400, Math.PI); //2
		drawText(oArea_3.data("fgp") + "%", oArea_3.data("fgm") + "/" + oArea_3.data("fgs"), 375, 212, Math.PI); //3
		drawText(oArea_4.data("fgp") + "%", oArea_4.data("fgm") + "/" + oArea_4.data("fgs"), 50, 400, Math.PI); //4
		drawText(oArea_5.data("fgp") + "%", oArea_5.data("fgm") + "/" + oArea_5.data("fgs"), 30, 620, Math.PI); //5
		drawText(oArea_6.data("fgp") + "%", oArea_6.data("fgm") + "/" + oArea_6.data("fgs"), 600, 580, Math.PI); //6
		drawText(oArea_7.data("fgp") + "%", oArea_7.data("fgm") + "/" + oArea_7.data("fgs"), 475, 375, Math.PI); //7
		drawText(oArea_8.data("fgp") + "%", oArea_8.data("fgm") + "/" + oArea_8.data("fgs"), 275, 375, Math.PI); //8
		drawText(oArea_9.data("fgp") + "%", oArea_9.data("fgm") + "/" + oArea_9.data("fgs"), 150, 580, Math.PI); //9
		drawText(oArea_10.data("fgp") + "%", oArea_10.data("fgm") + "/" + oArea_10.data("fgs"), 375, 570, Math.PI); //10

		function drawText(rate, num, x, y, rotate, color) {
			cxt.beginPath();
			cxt.shadowBlur = 0;
			cxt.shadowColor = "#fff";
			cxt.shadowOffsetX = 0;
			cxt.shadowOffsetY = 0;
			cxt.font = "bold 18px 'Helvetica Neue' Helvetica STHeiTi sans-serif";
			cxt.fillStyle = "#303a4a";
			cxt.textAlign = "center"

			cxt.save();
			cxt.translate(x * GM_Width_Ratio, y * GM_Height_Ratio);
			cxt.rotate(rotate);
			cxt.fillText(rate, 0 * GM_Width_Ratio, 0 * GM_Height_Ratio);
			cxt.fillText(num, 0 * GM_Width_Ratio, (0 + 24) * GM_Height_Ratio);
			cxt.restore();
		}

		cxt.beginPath();
		cxt.moveTo(0 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.lineTo(750 * GM_Width_Ratio, 0 * GM_Height_Ratio);
		cxt.strokeStyle = "#959595";
		cxt.lineWidth = 2;
		cxt.stroke();


		$(".hoop").css({
			"left": (self.winWidth - self.winWidth * 94 / 750) / 2,
			"top": 2 * self.winWidth / 750,
			"width": self.winWidth * 94 / 750,
			"height": self.winWidth * 92 / 750
		});
	}
}

module.exports = nbaPlayer;
