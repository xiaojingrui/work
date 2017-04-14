!function(){

	var canvas = document.getElementById("map-canvas");
	var cxt = canvas.getContext("2d");


	var iWidth = $(window).width();

	var curWidth = iWidth*0.8;

	var rectRatio = 439/512;
	var widthRatio = curWidth/512*2;
	var heightRatio = curWidth*rectRatio/439*2;

	var area1 = $("#map-area1");
	var area2 = $("#map-area2");
	var area3 = $("#map-area3");
	var area4 = $("#map-area4");
	var area5 = $("#map-area5");
	var area6 = $("#map-area6");
	var area7 = $("#map-area7");
	var area8 = $("#map-area8");
	var area9 = $("#map-area9");
	var area10 = $("#map-area10");

	var areaColor = ["#d7534b", "#ffd303", "#839dc0", "#c5c5c5"];




	$("#map-canvas").attr("width", curWidth*2);
	$("#map-canvas").attr("height", curWidth* 439/512*2);
	drawArea(cxt);
	drawMap(cxt);
	drawData(cxt);
	$("#map-canvas").css("width", curWidth);
	$("#map-canvas").css("height", curWidth*439/512);


	//文本
	function drawData(cxt){
		drawText(cxt, area1.data("fgp")+"%", area1.data("fgm")+"/"+area1.data("fgs"), 38, 26, 2*Math.PI, textColor(area1.data("level"))); //1
		drawText(cxt, area2.data("fgp")+"%", area2.data("fgm")+"/"+area2.data("fgs"), 65, 260, 2*Math.PI, textColor(area2.data("level"))); //2
		drawText(cxt, area3.data("fgp")+"%", area3.data("fgm")+"/"+area3.data("fgs"), 256, 320, 2*Math.PI, textColor(area3.data("level"))); //3
		drawText(cxt, area4.data("fgp")+"%", area4.data("fgm")+"/"+area4.data("fgs"), 447, 260, 2*Math.PI, textColor(area4.data("level"))); //4
		drawText(cxt, area5.data("fgp")+"%", area5.data("fgm")+"/"+area5.data("fgs"), 474, 26, 2*Math.PI, textColor(area5.data("level"))); //5
		drawText(cxt, area6.data("fgp")+"%", area6.data("fgm")+"/"+area6.data("fgs"), 120, 70, 2*Math.PI, textColor(area6.data("level"))); //6
		drawText(cxt, area7.data("fgp")+"%", area7.data("fgm")+"/"+area7.data("fgs"), 180, 170, 2*Math.PI, textColor(area7.data("level"))); //7
		drawText(cxt, area8.data("fgp")+"%", area8.data("fgm")+"/"+area8.data("fgs"), 332, 170, 2*Math.PI, textColor(area8.data("level"))); //8
		drawText(cxt, area9.data("fgp")+"%", area9.data("fgm")+"/"+area9.data("fgs"), 392, 70, 2*Math.PI, textColor(area9.data("level"))); //9
		drawText(cxt, area10.data("fgp")+"%", area10.data("fgm")+"/"+area10.data("fgs"), 256, 30, 2*Math.PI, textColor(area10.data("level"))); //10
	}

	function textColor(level){
		if(level == 1){
			return "#fff";
		}else{
			return "#000";
		}
	}

	//绘制区域
	function drawArea(cxt){
		//区域一
		drawIrregular(cxt, [{"x":0, "y":0}, {"x":40, "y":0}, {"x":40, "y":67}, {"cpx":37, "cpy":95, "ex":54, "ey":143}, {"x":0, "y":143}], areaColor[area1.data("level")-1]);

		//区域二
		drawIrregular(cxt, [{"x":0, "y":143}, {"x":54, "y":143}, {"cpx":84, "cpy":217, "ex":148, "ey":254}, {"x":38, "y":439}, {"x":0, "y":439}], areaColor[area2.data("level")-1]);

		//区域三
		drawIrregular(cxt, [{"x":38, "y":439}, {"x":148, "y":254}, {"cpx":248, "cpy":314, "ex":364, "ey":254}, {"x":474, "y":439}], areaColor[area3.data("level")-1]);

		//区域四
		drawIrregular(cxt, [{"x":474, "y":439}, {"x":364, "y":254}, {"cpx":422, "cpy":226, "ex":458, "ey":143}, {"x":512, "y":143}, {"x":512, "y":439}], areaColor[area4.data("level")-1]);

		//区域五
		drawIrregular(cxt, [{"x":512, "y":0}, {"x":472, "y":0}, {"x":472, "y":67}, {"cpx":475, "cpy":95, "ex":458, "ey":143}, {"x":512, "y":143}], areaColor[area5.data("level")-1]);

		//区域六
		drawIrregular(cxt, [{"x":40, "y":0}, {"x":40, "y":67}, {"cpx":39, "cpy":131, "ex":76, "ey":188}, {"x":212, "y":95}, {"cpx":196, "cpy":89, "ex":178, "ey":72}, {"x":178, "y":0}], areaColor[area6.data("level")-1]);

		//区域七
		drawIrregular(cxt, [{"x":76, "y":188}, {"cpx":144, "cpy":283, "ex":256, "ey":283}, {"x":256, "y":104}, {"cpx":230, "cpy":104, "ex":212, "ey":95}], areaColor[area7.data("level")-1]);

		//区域八
		drawIrregular(cxt, [{"x":256, "y":283}, {"cpx":370, "cpy":280, "ex":436, "ey":188}, {"x":300, "y":95}, {"cpx":282, "cpy":104, "ex":256, "ey":104}], areaColor[area8.data("level")-1]);

		//区域九
		drawIrregular(cxt, [{"x":472, "y":0}, {"x":472, "y":67}, {"cpx":473, "cpy":131, "ex":436, "ey":188}, {"x":300, "y":95}, {"cpx":316, "cpy":89, "ex":334, "ey":72}, {"x":334, "y":0}], areaColor[area9.data("level")-1]);

		//区域十
		drawIrregular(cxt, [{"x":178, "y":0}, {"x":178, "y":72}, {"cpx":256, "cpy":136, "ex":334, "ey":72}, {"x":334, "y":0}], areaColor[area10.data("level")-1]);
	}

	//绘制线框
	function drawMap(cxt){

		//线条基本样式
		cxt.lineWidth = 2;

		//三分线
		drawCircle(cxt, 256, 67, 216, 0, Math.PI, false);
		drawline(cxt, [{"x":40, "y":0}, {"x":40, "y":67}]);
		drawline(cxt, [{"x":472, "y":0}, {"x":472, "y":67}]);
		//中圈
		drawCircle(cxt, 256, 439, 70, 0, Math.PI, true);
		//罚球线
		drawline(cxt, [{"x":178, "y":190}, {"x":334, "y":190}], "rgba(255,255,255,.5)");
		//罚球圈
		drawCircle(cxt, 256, 190, 78, 0, Math.PI, false, "rgba(255,255,255,.5)");

		for (var i = 0; i < 10; i++){
			drawCircle(cxt, 256, 190, 78, Math.PI * (4 * i + 40) / 40, Math.PI * ((4 * (i + 1) - 1) + 40) / 40, false, "rgba(255,255,255,.5)");
		}
		//两分线
		drawline(cxt, [{"x":178, "y":72}, {"x":178, "y":190}], "rgba(255,255,255,.5)");
		drawline(cxt, [{"x":334, "y":72}, {"x":334, "y":190}], "rgba(255,255,255,.5)");
		//区域划分——边线
		drawline(cxt, [{"x":0, "y":143}, {"x":54, "y":143}]);
		drawline(cxt, [{"x":512, "y":143}, {"x":458, "y":143}]);
		//区域划分——外场线
		drawline(cxt, [{"x":38, "y":439}, {"x":148, "y":254}]);
		drawline(cxt, [{"x":474, "y":439}, {"x":364, "y":254}]);
		//区域划分——内场线
		drawline(cxt, [{"x":76, "y":188}, {"x":212, "y":95}]);
		drawline(cxt, [{"x":256, "y":104}, {"x":256, "y":283}]);
		drawline(cxt, [{"x":436, "y":188}, {"x":300, "y":95}]);


		//内场
		drawline(cxt, [{"x":178, "y":0}, {"x":178, "y":72}]);
		drawline(cxt, [{"x":334, "y":0}, {"x":334, "y":72}]);
		drawCircle(cxt, 256, -6, 110, Math.PI/4, Math.PI*3/4, false);

		//底线
		drawline(cxt, [{"x":40, "y":0}, {"x":472, "y":0}]);

	}

	//绘制文字
	function drawText(cxt, rate, num, x, y, rotate, color) {
		cxt.save();
		cxt.font = "bold 30px 'Helvetica Neue' Helvetica STHeiTi 'Heiti SC' sans-serif";
		cxt.textAlign = "center";
		cxt.fillStyle = color;
		cxt.translate(x * widthRatio, y * heightRatio);
		cxt.rotate(rotate);
		cxt.fillText(rate, 0 * widthRatio, 0 * heightRatio);
		cxt.fillText(num, 0 * widthRatio, (0 + 24) * heightRatio);
		cxt.restore();
	}

	//绘制不规则图形
	function drawIrregular(cxt, datas, color){
		cxt.beginPath();
		for(var i=0;i<datas.length;i++){
			if(typeof(datas[i].x) != "undefined"){
				cxt.lineTo(datas[i].x*widthRatio, datas[i].y*heightRatio);
			}else{
				cxt.quadraticCurveTo(datas[i].cpx*widthRatio, datas[i].cpy*heightRatio, datas[i].ex*widthRatio, datas[i].ey*heightRatio);
			}
		}
		cxt.fillStyle = color;
		cxt.fill();
		cxt.closePath();
	}

	//绘制圆
	function drawCircle(cxt, x, y, r, sAngle, eAngle, counterclockwise, color){
		cxt.beginPath();
		cxt.arc(x*widthRatio, y*heightRatio, r*widthRatio, sAngle, eAngle, counterclockwise);
		if(color){
			cxt.strokeStyle = color;
		}else{
			cxt.strokeStyle = "#fff";
		}
		cxt.stroke();
		cxt.closePath();
	}

	//绘制直线
	function drawline(cxt, datas, color){
		cxt.beginPath();
		for(var i=0;i<datas.length;i++){
			cxt.lineTo(datas[i].x*widthRatio, datas[i].y*heightRatio);
		}
		if(color){
			cxt.strokeStyle = color;
		}else{
			cxt.strokeStyle = "#fff";
		}
		cxt.stroke();
		cxt.closePath();
	}
}();
