$(function() {
    var version = require("common:widget/ui-versions/ui-versions.js");
    var dace = require("common:widget/ui-dace/ui-dace.js");
    var title = null;

    function initBridge(callback) {
        if(window.HupuBridge){
            callback();
        }else{
            document.addEventListener("hupuBridgeReady", function(){
                callback();
            });
        }
    }

    if(GM.player_name){
        title = GM.player_name;
    }else{
        title = "饮水机守护神";
    }

    if(version.gte(GM.version,"7.0.6")){
        initBridge(function(){
           HupuBridge.send("hupu.ui.header", {
                title: title,
                subtitle : GM.player_enname
           }, function(){
           });
        });
    }


    var $tabs = $('#J-tab'),
        $tabLi = $tabs.find('li');

    var mySwiper = new Swiper ('.swiper-container', {
        speed: 400,
        autoHeight: true,
        noSwiping: true,
        lazyLoading: true,
        preloadImages: false,
        onSlideChangeStart: function(swiper){
            $tabLi.eq(mySwiper.activeIndex).addClass("active").siblings().removeClass("active");
            // fixHeight();
        }
    }) 

    $tabLi.on('click', function() {
        var index = $(this).index();
        if( index == 0 ){
            dace.send("profile");
        }else{
            dace.send("data");
        }
        mySwiper.slideTo(index, 400, false);
        $(this).addClass('active').siblings().removeClass('active');
    });

    // function fixHeight() {
    //     var winHeight = window.innerHeight;
    //     var docHeight = document.body.offsetHeight;
    //     if(docHeight < winHeight){
    //         var h = winHeight - docHeight;
    //         console.log(h);
    //         $('.swiper-slide-active').height(winHeight);
    //         console.log( $('.swiper-slide-active').find('.source').css('height') );
    //         $('.swiper-slide-active').find('source').css({
    //             'height': h
    //         });
    //     }
    // }
    

})