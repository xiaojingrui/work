<video id="video" {%if $smarty.server.HTTP_USER_AGENT|strpos:'Android' != false%} muted {%/if%} controls webkit-playsinline playsinline preload class="video-js vjs-tv-skin vjs-big-play-centered" poster="http://w10.hoopchina.com.cn/hybrid/resource/nike/paste.jpg" width="100%" height="200">
    <source src="http://w10.hoopchina.com.cn/hybrid/resource/nike/nike1.mp4" type='video/mp4' />
</video>
<script type="text/javascript">
	window.onload = function() {
		videojs(document.getElementById('video'), {}, function() {
			  var video = this;
			  var iswifi = getQueryString("iswifi");
        if(iswifi == 1) {
			 		$(window).on("scroll touchstart",function(e) {
		 				if($(".vjs-big-play-button").css("display") != "none"){
		 					video.autoplay();
		 		 			video.play();
							$(".vjs-big-play-button").click();
		 				}
			 		});
        }
		});
	}
	function getQueryString(name) {
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r!=null)return  unescape(r[2]); return null;
	}
</script>
