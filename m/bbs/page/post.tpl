{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="bbs:static/post/post.scss"%}
    {%require name="bbs:static/post/post.js"%}
    <script>
        var isAuthCode = {%$showCode%};
    </script>

    <!--script src='//b1.hoopchina.com.cn/web/ir/ir.js'></script-->

{%/block%}
{%block name="content"%}
    <form id="J_postForm" action="" method="post">
        <div class="topbar-operations">
            <a class="button-cancel J_buttonClosePopup" href="{%$baseurl%}/bbs/{%$fid%}" dace-node="{%$id4dace%}_cancelComment">取消</a>
            <h2 class="title">发新帖</h2>
            <a href="javascript:" class="button-submit J_buttonSubmit">发送</a>
        </div>
        <section class="post-wrap">
            <section class="post-inner">
                <input type="hidden" id="J_fid" name="fid" value="{%$fid%}">
                <ul class="post-list">
                    <li>
                        <input type="text" name="title" maxlength="76" placeholder="请输入标题" value="" class="input-br J_inputTitle"/>
                    </li>
                    <li>
                        <div class="edit-area">
                            <div class="edit-content" contenteditable="true">

                            </div>
                            <!--<div class="init-content">请输入正文内容</div>-->
                        </div>
                    </li>
                </ul>

                {%widget
                    name = "common:widget/ui/emoji/emoji.tpl"
                    textCount ='5000'
                %}
            </section>
            {%widget
                name = "common:widget/ui/upload-image/upload-image.tpl"
                textCount = '5000'
            %}
        </section>
    </form>
{%/block%}

{%block name="footer"%}

{%/block%}
