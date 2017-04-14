{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="bbs:static/authority/authority.scss"%}
    {%require name="bbs:static/authority/authority.js"%}
{%/block%}

{%block name="content"%}
    <form action="{%$formUrl%}" name="checkpassword" method="post">
        <input id="fid" type="hidden" value="{%$fid%}" name="fid">
        <input id="fid" type="hidden" value="{%$backUrl%}" name="backUrl">
        
        <p>该版块设置了访问权限，请输入密码</p>
        <div class="input-item">
            <span class="pwd-ipt"><input id="password" type="password" name="password"></span>
            <span class="pwd-control"></span>
        </div>
        <div class="btn-item">
            <input type="button" value="取消" class="cancel-btn" data-link="{%$backUrl%}">
            <input type="submit" value="提交" class="submit-btn" name="submit">
        </div>
    </form> 
{%/block%}