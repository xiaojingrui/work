
var dace = require("common:widget/ui-dace/ui-dace.js");
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

var nbaTeam = {

	init: function() {
		if(!version.gte(GM.version,"7.0.16")){
			$(".football-team-data span i").hide();
			$(".football-team-data a").click(function(event) {
				event.preventDefault();
			}) 
		}
		initBridge(function(){
		   HupuBridge.send("hupu.ui.header", {
				    title: GM.player_name,
				    subtitle : GM.player_enname
			  }, function(){
		   });
		});
	}

}

module.exports = nbaTeam;
