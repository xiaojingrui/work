
<div class="reply-box" id="J-reply-box" {%if !$_islogin%} style="padding-bottom:10px" {%/if%}>
		<div class="J_popupQuoteContent">
		</div>
    {%if $_islogin == 0 %}
        <div class="tip-content J_tipContent">
            <span>
                你需要登录后才可以回复，请
                <a href="https://passport.hupu.com/m/2?jumpurl=https%3A%2F%2Fm.hupu.com%2F&from=m&project=hupu">登录</a>
                或者
                <a href="https://passport.hupu.com/m/2/nregister">立即注册</a>
            </span>
        </div>
    {%else%}
        {%if !empty($exam_paper_url)%}
            <div class="tip-content J_tipContent">
                <span>
                    为虎扑建设成一个专业、友善的体育社区，减少低质量的水贴、无价值的争论，你需要通过考试才能发言，请
                    <a href="{%$exam_paper_url%}">参与答题</a>。
                </span>
            </div>
        {%else%}
            <div class="tip-textarea">
            	<textarea placeholder="说说你的看法..." class="reply-textarea J_replyTexttarea" maxlength="4000"></textarea>
            	<span class="words-number">6-4000字</span>
            </div>
        {%/if%}
    {%/if%}
    {%widget
            name = "common:widget/ui/upload-image/upload-image.tpl"
            bbstype="bbsDetail"
        %}
</div>

