<script type="text/javascript">
var googletag = window.googletag || {};
googletag.cmd = googletag.cmd || [];
(function() {
	var gads = document.createElement('script');
	gads.async = true;
	gads.type = 'text/javascript';
	var useSSL = 'https:' == document.location.protocol;
	gads.src = (useSSL ? 'https:' : 'http:') +
		'//www.googletagservices.com/tag/js/gpt.js';
	var node = document.getElementsByTagName('script')[0];
	node.parentNode.insertBefore(gads, node);
})();

googletag.cmd.push(function() {
	googletag.defineSlot('/1016953/m_bbs_index_bottom_480x60', [480, 60], 'div-gpt-ad-1401783581466-0').addService(googletag.pubads()); //BBS底部通栏（中）
	googletag.defineSlot('/1016953/m_bbs_index_bottom_320x60', [320, 60], 'div-gpt-ad-1401783581466-2').addService(googletag.pubads()); //BBS底部通栏（小）
	//googletag.defineSlot('/1016953/m_voice_index_banner1_480x60', [480, 60], 'div-gpt-ad-1401353566883-0').addService(googletag.pubads());//新声顶部通栏(中)
	//googletag.defineSlot('/1016953/m_voice_index_banner1_320x60', [320, 60], 'div-gpt-ad-1401353566883-2').addService(googletag.pubads());//新声顶部通栏（小）
	googletag.defineSlot('/1016953/m_bbs_content_bottom_480x60', [480, 60], 'div-gpt-ad-1403165584802-0').addService(googletag.pubads()); //帖子底部内页(中)
	googletag.defineSlot('/1016953/m_bbs_content_bottom_320x60', [320, 60], 'div-gpt-ad-1403165584802-2').addService(googletag.pubads()); //帖子底部内页(小)
	googletag.defineSlot('/1016953/m_voice_content_bottom_320x60', [320, 60], 'div-gpt-ad-1405589702452-0').addService(googletag.pubads()); //新声内页底部通栏(小)
	googletag.defineSlot('/1016953/m_voice_content_bottom_480x60', [480, 60], 'div-gpt-ad-1405589702452-1').addService(googletag.pubads()); //新声内页底部通栏(中)
	googletag.pubads().enableSingleRequest();
	googletag.enableServices();
});
</script>
{%$ids = [
	"bbs" => ['div-gpt-ad-1401783581466-0', 'div-gpt-ad-1401783581466-2'],
	"bbsdetail" => ['div-gpt-ad-1403165584802-0', 'div-gpt-ad-1403165584802-2'],
	"newsdetail" => ['div-gpt-ad-1405589702452-1', 'div-gpt-ad-1405589702452-0']
]%}
{%$adids=$ids[$page]%}
<div class="content_bottom_small" style='display:none;' dace-node="{%$id4dace%}_ad_{%$adids[0]%}">
	<script type='text/javascript'>
	googletag.cmd.push(function() { googletag.display('{%$adids[0]%}'); });
	</script>
</div>
<div class='content_bottom_smaller' style='display:none;' dace-node="{%$id4dace%}_ad_{%$adids[1]%}">
	<script type='text/javascript'>
	googletag.cmd.push(function() { googletag.display('{%$adids[1]%}'); });
	</script>
</div>
{%script%}
	var ids = {%json_encode($adids)%}||[0,0];
	var scrsize = $(window).width(); //浏览器当前窗口可视区域宽度
	if (scrsize >= 480) {
		$('.content_bottom_small').attr('id', ids[0]);
	} else {
		$('.content_bottom_smaller').attr('id', ids[1]);
	}
{%/script%}