$(function() {

    var version = require("common:widget/ui-versions/ui-versions.js");
    var show_box = require("match:widget/show_box/show_box.js");
    var birth = require("match:widget/birth/birth.js");
    function initBridge(callback) {
        if(window.HupuBridge){
            callback();
        }else{
            document.addEventListener("hupuBridgeReady", function(){
                callback();
            });
        }
    }

    if(version.gte(GM.version,"7.0.6")){
        initBridge(function(){
           HupuBridge.send("hupu.ui.header", {
                title: GM.player_name,
                subtitle : GM.player_enname
           }, function(){
           });
        });
    }

    $('.tactic').on('click', function() {
        show_box.init('.formation','.cover');
    })

    var localKey = "coach_" + $(".coachid").val() + "_dropTimes";
    birth.init(localKey);

})