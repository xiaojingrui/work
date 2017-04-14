$(function(){

	var _ = require("underscore");

	var oRegularChart = document.getElementsByClassName('regular-chart')[0];
	var oPlayoffChart = document.getElementsByClassName('playoff-chart')[0];
	if(GM.data_regular.length*50<$(window).width()){
		$(oRegularChart).css("width", "100%");
	}else{
		$(oRegularChart).css("width", GM.data_regular.length*50+50);
	}

	if(GM.data_playoff.length*50<$(window).width()){
		$(oPlayoffChart).css("width", "100%");
	}else{
		$(oPlayoffChart).css("width", GM.data_playoff.length*50+50);
	}

	// 基于准备好的dom，初始化echarts实例
	if(GM.data_regular.length!=0){
    	var regularChart = echarts.init(document.getElementsByClassName('regular-chart')[0]);
    }
    if(GM.data_playoff.length!=0){
	    var playoffChart = echarts.init(document.getElementsByClassName('playoff-chart')[0]);
	}

    // 指定图表的配置项和数据
    var regularIndex = null;
    var playoffIndex = null;

    var oRegularSubNav = $("#J-regular-subNav");
    var oRegularTips =$("#J-regular-tips");

    var oPlayoffSubNav = $("#J-playoff-subNav");
    var oPlayoffTips =$("#J-playoff-tips");

    var regularInput = $("#J-regular-input");
    var regularWrap = $("#J-regular-wrap");
	var tplRegularRender = $("#J-regular-data-tpl").html() ? _.template($("#J-regular-data-tpl").html()) :  _.template("");


    var playoffInput = $("#J-playoff-input");
    var playoffWrap = $("#J-playoff-wrap");
	var tplPlayoffRender = $("#J-playoff-data-tpl").html() ? _.template($("#J-playoff-data-tpl").html()) :  _.template("");

    var regularSeries1 = [
    	{
            name:'上场时间',
            type:'line',
            data:newArr(GM.data_regular, "mins")
        },
        {
            name:'助攻',
            type:'line',
            data:newArr(GM.data_regular, "pts")
        }
    ]

    var regularSeries2 = [
    	{
            name:'篮板',
            type:'line',
            data:newArr(GM.data_regular, "reb")
        },
        {
            name:'助攻',
            type:'line',
            data:newArr(GM.data_regular, "asts")
        },
        {
            name:'抢断',
            type:'line',
            data:newArr(GM.data_regular, "stl")
        },
        {
            name:'盖帽',
            type:'line',
            data:newArr(GM.data_regular, "blk")
        }
    ]

    var regularSeries3 = [
    	{
            name:'投篮命中率',
            type:'line',
            data:newArr(GM.data_regular, "fgp")
        },
        {
            name:'三分命中率',
            type:'line',
            data:newArr(GM.data_regular, "tpp")
        },
        {
            name:'罚球命中率',
            type:'line',
            data:newArr(GM.data_regular, "ftp")
        }
    ]

    var playoffSeries1 = [
    	{
            name:'上场时间',
            type:'line',
            data:newArr(GM.data_playoff, "mins")
        },
        {
            name:'助攻',
            type:'line',
            data:newArr(GM.data_playoff, "pts")
        }
    ]

    var playoffSeries2 = [
    	{
            name:'篮板',
            type:'line',
            data:newArr(GM.data_playoff, "reb")
        },
        {
            name:'助攻',
            type:'line',
            data:newArr(GM.data_playoff, "asts")
        },
        {
            name:'抢断',
            type:'line',
            data:newArr(GM.data_playoff, "stl")
        },
        {
            name:'盖帽',
            type:'line',
            data:newArr(GM.data_playoff, "blk")
        }
    ]

    var playoffSeries3 = [
    	{
            name:'投篮命中率',
            type:'line',
            data:newArr(GM.data_playoff, "fgp")
        },
        {
            name:'三分命中率',
            type:'line',
            data:newArr(GM.data_playoff, "tpp")
        },
        {
            name:'罚球命中率',
            type:'line',
            data:newArr(GM.data_playoff, "ftp")
        }
    ]
    

    var regularOption = {
	    tooltip: {
			formatter: function (params, ticket, callback) {
			    regularIndex = params[0].dataIndex;
			    regularInput.val(regularIndex);
			},
	        trigger: 'axis',
	        triggerOn: 'click',
	        position: ['0%', '1250%']
	    },
	    grid: {
	    	show: true,
	    	top: '5%',
	        left: '1%',
	        right: '5%',
	        bottom: '10%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: newArr(GM.data_regular, "season_s"),
	        nameTextStyle: {
	        	fontStyle: 'italic'
	        }
	    },
	    yAxis: {
	    	axisLabel: {
	    		show: false
	    	},
	    	axisLine: {
	    		show: false
	    	},
	    	axisTick: {
	    		show: false
	    	},
	    },
	    series: [
	        {
	            name:'篮板',
	            type:'line',
	            data:newArr(GM.data_regular, "reb")
	        },
	        {
	            name:'助攻',
	            type:'line',
	            data:newArr(GM.data_regular, "asts")
	        },
	        {
	            name:'抢断',
	            type:'line',
	            data:newArr(GM.data_regular, "stl")
	        },
	        {
	            name:'盖帽',
	            type:'line',
	            data:newArr(GM.data_regular, "blk")
	        }
	    ],
	    color:['#0065ba', '#952425', '#ec6709', '#058b12'],
	    animation: false
	};

	var playoffOption = {
	    tooltip: {
			formatter: function (params, ticket, callback) {
			    playoffIndex = params[0].dataIndex;
			    playoffInput.val(playoffIndex);
			},
	        trigger: 'axis',
	        triggerOn: 'click',
	        position: ['0%', '1250%']
	    },
	    grid: {
	    	show: true,
	    	top: '5%',
	        left: '1%',
	        right: '5%',
	        bottom: '10%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: newArr(GM.data_playoff, "season_s"),
	        nameTextStyle: {
	        	fontStyle: 'italic'
	        }
	    },
	    yAxis: {
	    	axisLabel: {
	    		show: false
	    	},
	    	axisLine: {
	    		show: false
	    	},
	    	axisTick: {
	    		show: false
	    	},
	    },
	    series: [
	        {
	            name:'篮板',
	            type:'line',
	            data:newArr(GM.data_playoff, "reb")
	        },
	        {
	            name:'助攻',
	            type:'line',
	            data:newArr(GM.data_playoff, "asts")
	        },
	        {
	            name:'抢断',
	            type:'line',
	            data:newArr(GM.data_playoff, "stl")
	        },
	        {
	            name:'盖帽',
	            type:'line',
	            data:newArr(GM.data_playoff, "blk")
	        }
	    ],
	    color:['#0065ba', '#952425', '#ec6709', '#058b12'],
	    animation: false
	};

	// 使用刚指定的配置项和数据显示图表。
	if(GM.data_regular.length!=0){
		regularChart.setOption(regularOption, true);
	}
    if(GM.data_playoff.length!=0){
	    playoffChart.setOption(playoffOption, true);
	}


	if(GM.data_regular.length*50>$(window).width()){
		$(".regular-data .main-wrap").scrollLeft(GM.data_regular.length*50+50);
	}

	if(GM.data_playoff.length*50>$(window).width()){
		$(".playoff-data .main-wrap").scrollLeft(GM.data_playoff.length*50+50);
	}

	oRegularSubNav.find("a").on("click", function(){
		$(this).addClass("active").siblings("a").removeClass("active");
		oRegularTips.find("div").eq($(this).index()).show().siblings("div").hide();
		switch($(this).index()){
			case 0:
				regularOption.series = regularSeries1;
				regularReDraw();
				break;
			case 1:
				regularOption.series = regularSeries2;
				regularReDraw();
				break;
			case 2:
				regularOption.series = regularSeries3;
				regularReDraw();
				break;
		}
	});

	$(oRegularChart).on("click", function(){
		regularIndex = regularInput.val();
		regularWrap.html(tplRegularRender({regularIndex: regularIndex}));
	});

	oPlayoffSubNav.find("a").on("click", function(){
		$(this).addClass("active").siblings("a").removeClass("active");
		oPlayoffTips.find("div").eq($(this).index()).show().siblings("div").hide();
		switch($(this).index()){
			case 0:
				playoffOption.series = playoffSeries1;
				playoffReDraw();
				break;
			case 1:
				playoffOption.series = playoffSeries2;
				playoffReDraw();
				break;
			case 2:
				playoffOption.series = playoffSeries3;
				playoffReDraw();
				break;
		}
	});

	$(oPlayoffChart).on("click", function(){
		playoffIndex = playoffInput.val();
		playoffWrap.html(tplPlayoffRender({playoffIndex: playoffIndex}));
	});

	function newArr(data, key){
		var arr = [];
		for(var i=0; i<data.length; i++){
			arr.push(data[i][key]);
		}
		return arr;
	}

	function regularReDraw(){
		if(GM.data_regular.length!=0){
			regularChart.dispose();
			regularChart = echarts.init(document.getElementsByClassName('regular-chart')[0]);
			regularChart.setOption(regularOption, true);
		}
	}

	function playoffReDraw(){
		if(GM.data_playoff.length!=0){
			playoffChart.dispose();
			playoffChart = echarts.init(document.getElementsByClassName('playoff-chart')[0]);
			playoffChart.setOption(playoffOption, true);
		}
	}
});