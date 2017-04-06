<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
        <title>虎扑看球彩票 - 传说中的后台</title>
        <link rel="stylesheet" href="//b3.hoopchina.com.cn/games/style/matrix/css/bootstrap.css" />
        <link rel="stylesheet" href="//b3.hoopchina.com.cn/games/style/matrix/css/bootstrap-responsive.css" />
        <link rel="stylesheet" href="//b3.hoopchina.com.cn/games/style/matrix/css/styles.css" />
        <link rel="stylesheet" href="//b3.hoopchina.com.cn/games/style/matrix/css/toastr.css" />
        <link rel="stylesheet" href="//b3.hoopchina.com.cn/games/style/matrix/css/fullcalendar.css" />
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/jquery.min.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/bootstrap.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/jquery.knob.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/d3.v3.min.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/jquery.sparkline.min.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/toastr.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/jquery.tablesorter.min.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/jquery.peity.min.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/fullcalendar.min.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/gcal.js"></script>
        <script src="//b3.hoopchina.com.cn/games/style/matrix/js/setup.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>
            #cios div, #candroid div {margin-top: 5px;}
            pre {font-size:12px;padding:3px;color:#999}
            .tdc {font-size:12px;}
            .col-nav li{font-size: 12px}
            .lists code {font-size:12px; color:#666}
            .menu .sell{background-position:-128px 0px}
            .menu .jc{background-position:-192px -128px}
            .menu .yy{background-position:-256px -64px}
            .menu .buy{background-position:-288px -64px}
            .menu .hobby{background-position:-160px 0px}
            .activeSubMenu{background: #f2f2f2}
            .pages {clear:both;margin:3px;text-align:right;font-size:12px;}
            #in-sub-nav li a:hover, #in-sub-nav li a.active{background-color:#108700}
            .col999 {color:#999;}
        </style>
    </head>
    <body>
        <div id="in-sub-nav" style="background-color:#666; box-shadow:0 0 10px #333333 inset; background: url('//b1.hoopchina.com.cn/games/images/cporzbg.jpg')">
            <div class="container">
                <div class="row">
                    <div style="position: absolute; z-index: 2">
                        <div style="position: absolute; left:-30px; padding-top:20px;">
                            <span><img src="//b3.hoopchina.com.cn/games/images/kanqiu_logo.png" width="250" style="width:250px; max-width:250px;" /></span>
                        </div>
                    </div>
                    <div class="menu">
                        <ul style="text-align:right">
                            {%foreach $menus as $id => $menuInfo}
                            <li style="text-align:center"><a href="./{%$menuInfo['action']%}"{%if $menuId == $menuInfo['id']%} class="active"{%/if%}><i class="batch {%$menuInfo['icon']%}"></i><br />{%$menuInfo['name']%}</a></li>
                            {%/foreach%}
                        </ul>
                        <!--<span class="label label-important pull-right">04</span>-->
                    </div>
                </div>
            </div>
        </div>

        <div class="page">
            <div class="page-container">
                <div class="container">
                    <div class="row">
                        <div class="span2">
                            <span style="display: block; margin: 10px;"><li class="icon-th-large"></li> &nbsp; {%$menus[$menuId]['name']%}</span>
                            <div class="sidebar">
                                <ul class="col-nav span2">
                                    {%foreach $menus[$menuId]['subMenu'] as $mid => $menuInfo%}
                                    <li{%if !empty($subMenuId) && $menuInfo['id'] == $subMenuId%}{% $subMenuId = $mid%} class="activeSubMenu"{%/if%}><a href="./{%$menuInfo['action']%}"> <i class="pull-right icon-{%$menuInfo['icon']%}"></i>{%$menuInfo['name']%}</a></li>
                                    {%/foreach%}
                                </ul>
                            </div>
                        </div>
                        <div class="span10">

