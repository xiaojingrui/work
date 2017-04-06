<section class="hotline-wrap">
    <div class="bd-content" id="J-bd-container">
        <div class="bd" id="J-pager-hotline">
        	<ul class="list" id="J-hotline-container">
                <script type="text/template" id="J-hotline-tpl">
                    <@if(type === 1){@>
                		<li class="clearfix">
                			<div class="fl">
                				<div class="dot"></div>
                                <div class="time"><@=date@></div>
                			</div>
                			<div class="fr">
                				<div class="name">-<@=username@></div>
                				<div class="content"><@=content@></div>
                			</div>
                		</li>
                    <@}@>
                    <@if(type === 2 && col){@>
                        <li class="clearfix gift" style="color:<@=col@>">
                            <div class="fl">
                                <div class="dot"></div>
                                <div class="time"><@=date@></div>
                            </div>
                            <div class="fr">
                                <div class="name">-<@=username@></div>
                                <span><@=content@></span>
                            </div>
                        </li>
                    <@}@>
                </script>
        	</ul>
        </div>
    </div>
</section>
{%script%}
    var hotline = require("./annual_hotline2015.js");
    hotline.init();
{%/script%}
