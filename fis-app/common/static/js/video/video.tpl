<!--autoplay-->
 <video id="example_video_1" class="video-js vjs-default-skin vjs-big-play-centered" controls width="640" height="264" >

 <source src="http://img.ksbbs.com/asset/Mon_1605/0ec8cc80112a2d6.mp4" type='video/mp4' />

</video> 
<script type="text/javascript">
 window.onload = function() {

//$(document).ready(function(){
		console.log("1",document.getElementById('example_video_1'))
videojs(document.getElementById('example_video_1'), {}, function() {
	console.log("000")
  // This is functionally the same as the previous example.
});
	var video=document.getElementById("example_video_1");
	video.controls=false;
}
</script>
