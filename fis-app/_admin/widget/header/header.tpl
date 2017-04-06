 <!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>虎扑看球 - 传说中的后台</title>
        <link href="//b3.hoopchina.com.cn/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="//b3.hoopchina.com.cn/bootstrap/css/bootstrap-responsive.css" rel="stylesheet" media="screen">
        <link href="//b3.hoopchina.com.cn/common/timepicker/jquery-ui.css" rel="stylesheet" media="screen">
        <script src="//b3.hoopchina.com.cn/common/jquery.js"></script>
        <script src="//b3.hoopchina.com.cn/bootstrap/js/bootstrap.min.js"></script>
        <script src="//b3.hoopchina.com.cn/common/timepicker/jquery-ui.js"></script>
        <script src="//b3.hoopchina.com.cn/common/timepicker/jquery-ui-slide.min.js"></script>
        <script src="//b3.hoopchina.com.cn/common/timepicker/jquery-ui-timepicker-addon.js"></script>
        {%require name="common:static/mod.js"%}
        {%require name="common:static/global.js"%}
        <style>
            #cios div, #candroid div {margin-top: 5px;}
            pre {font-size: 9px;}
            .tdc {font-size:12px; background-color:#fff;}
            .lists code {font-size:12px; color:#666}
            .ui-timepicker-div .ui-widget-header { margin-bottom: 8px;}
            .ui-timepicker-div dl { text-align: left; }
            .ui-timepicker-div dl dt { height: 25px; margin-bottom: -25px; }
            .ui-timepicker-div dl dd { margin: 0 10px 10px 65px; }
            .ui-timepicker-div td { font-size: 90%; }
            .ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }
            .ui_tpicker_hour_label,.ui_tpicker_minute_label,.ui_tpicker_second_label,.ui_tpicker_millisec_label,.ui_tpicker_time_label{padding-left:20px}
        </style>

    </head>
    <body class="container">
        <table class="table table-bordered" style="margin-top: 10px; margin-bottom: 0">
            <tr class="info">
                <td><center><span class="add-on"><i class="icon-th-list"></i> <a href="./index">NBA赛程</a></span></center></td>
                <td><center><span class="add-on"><i class="icon-tasks"></i> <a href="./cba">CBA赛程</a></span></center></td>
                <td><center><span class="add-on"><i class="icon-tasks"></i> <a href="./gameList">足球赛程</a></span></center></td>
               {%if $permission_level == 9%} <td><center><span class="add-on"><i class="icon-th-list"></i> <a href="./discovery">发现-直播间</a></span></center></td>{%/if%}
                <td><center><span class="add-on"><i class="icon-th-list"></i> <a href="./notific">通知管理</a></span></center></td>
                <td><center><span class="add-on"><i class="icon-book"></i> <a href="./newsListManage">内容管理</a></span></center></td>
                <td><center><span class="add-on"><i class="icon-gift"></i> <a href="./babyUserList">征途相关</a></span></center></td>
               <td><center><span class="add-on"><i class="icon-gift"></i> <a href="./roomList">虎扑TV</a></span></center></td>
                <!--<td><center><span class="add-on"><i class="icon-th-list"></i> <a href="./setDataConfig">数据配置</a></span></center></td>
                <td><center><span class="add-on"><i class="icon-shopping-cart"></i> <a href="./loadPageAd">开机广告</a></span></center></td>
                <td><center><span class="add-on"><i class="icon-shopping-cart"></i> <a href="./langList">语言包设置</a></span></center></td>-->
            </tr>
        </table>
        {%if !empty($leaguesName)%}
        <table class="" style="width:100%;border-bottom:solid #ccc 1px; font-size:12px;">
            <tr class="">
                <td style="padding:6px;">
                    {%foreach $leaguesName as $llid => $llname%}
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid={%$llid%}">{%$llname%}{%if !empty($typeName)%}{%$typeName%}{%else%}赛程{%/if%}</a></span> &nbsp; &nbsp;
                    {%/foreach%}
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid=4&match_type=2">
                        足总杯
                    </a></span>
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid=4&match_type=3">
                        联赛杯
                    </a></span>
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid=6&match_type=2">
                        国王杯
                    </a></span>
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid=3&match_type=2">
                        德国杯
                    </a></span>
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid=5&match_type=2">
                        意大利杯
                    </a></span>
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./gameList?lid=7&match_type=2">
                        法国杯
                    </a></span>
                </td>
            </tr>
        </table>
        {%/if%}
        {%if !empty($babyMenu)%}
        <table class="" style="width:100%;border-bottom:solid #ccc 1px; font-size:12px;">
            <tr class="">
                <td style="padding:6px;">
                    {%foreach $babyMenu as $menuLink => $menuTitle%}
                    <span class="add-on"><i class="icon-chevron-right"></i> <a href="./{%$menuLink%}">{%$menuTitle%}</a></span> &nbsp; &nbsp;
                    {%/foreach%}
                </td>
            </tr>
        </table>
        {%/if%}
        <!-- 兑换奖品 start -->
        {%if !empty($exchangeMenu)%}
        <table class="" style="width:100%;border-bottom:solid #ccc 1px; font-size:12px;">
            <tr class="">
                <td style="padding:6px;">
                {%foreach $exchangeMenu as $menuLink => $menuTitle%}
                <span class="add-on"><i class="icon-chevron-right"></i> <a href="./{%$menuLink%}">{%$menuTitle%}</a></span> &nbsp; &nbsp;
                {%/foreach%}
                </td>
            </tr>
        </table>
        {%/if%}
        <!-- 兑换奖品 end -->
        <!-- 内容管理 start -->
        {%if !empty($contentMenu)%}
        <table class="" style="width:100%;border-bottom:solid #ccc 1px; font-size:12px;">
            <tr class="">
                <td style="padding:6px;">
                {%foreach $contentMenu as $menuLink => $menuTitle%}
                <span class="add-on"><i class="icon-chevron-right"></i> <a href="./{%$menuLink%}">{%$menuTitle%}</a></span> &nbsp; &nbsp;
                {%/foreach%}
                </td>
            </tr>
        </table>
        {%/if%}
        <!-- 内容管理 end -->