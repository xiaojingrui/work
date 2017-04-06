var _performance = window.performance || {
		timing:false
};
var timing = _performance.timing;
var supportTiming = !!timing;
var startTime = supportTiming ? timing.navigationStart : (new Date().getTime());
var times = [];
var pageWatch = {
	markTime: function(name, timeEnd){
		if(supportTiming){
			var timeLoop = timeEnd - startTime;
			this.push(name, timeLoop);
		}
	},
	push: function(name, time){
		times.push( ([name, time].join(":") + "ms") );
	},
	record: function(){
		if(supportTiming){
			var timing = window.performance.timing;
			var domReadyTime = timing.domContentLoadedEventStart - timing.navigationStart;
			var pageLoadTime = timing.loadEventStart - timing.navigationStart;
			var dns = timing.domainLookupEnd - timing.domainLookupStart;
			var tcp = timing.connectEnd - timing.connectStart;
			var ttfb = timing.responseStart - timing.navigationStart;

			this.push("domready", domReadyTime);
			this.push("pageload", pageLoadTime);
			this.push("dns", dns);
			this.push("tcp", tcp);
			this.push("ttfb", ttfb);

			var msg = times.join("|");
			//上报日志类型为0.
			//格式为 pageload:100ms|dns:30ms|tcp:20ms|ttfb:20ms
			Jswatch.record(msg, 0);
		}
		
	}
}
module.exports = pageWatch;