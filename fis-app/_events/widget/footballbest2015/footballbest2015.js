var Backbone = require("common:widget/lib/backbone/backbone.js");

var controllers = {
	index: require("./index.js"),
	step1: require("./step1.js"),
	step2: require("./step2.js"),
	step3: require("./step3.js"),
	step4: require("./step4.js"),
	step5: require("./step5.js"),
	result: require("./result.js"),
	rank: require("./rank.js")
};

var routers = {
	routes: {}
};

for (var page in controllers) {
	routers.routes[page] = page;
	routers[page] = (function(current) {
		return function() {
			controllers[current].show();
		}
	})(page);
}
var PageRouter = Backbone.Router.extend(routers);

module.exports = {
	init: function() {
		var router = new PageRouter();
		Backbone.history.start({
			pushState: false,
			root: "index"
		});
		FastClick.attach(document.body);

		if (GM.person_fd) {
			location.hash = "result";
		       
		} else{
			if(location.hash === "#rank" || location.hash === "#step1"){

			} else{
				location.hash = "index";
			}
		}
		
	}
}