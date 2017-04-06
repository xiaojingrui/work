{%extends file="common/page/layout.tpl"%}

{%block name="title"%}
    耐克广告
{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/video/video.js"%}
    {%require name="common:static/js/video/video-js.css"%}
    {%require name="common:static/nike-ad/nike-ad.scss"%}


{%/block%}

{%block name="content"%}

<section>
    <a href="http://clickc.admaster.com.cn/c/a80226,b1491518,c1924,i0,m101,8a1,8b2,h" class="nike-head">
        <div class="content">
            <h2>科比全明星谢幕战，威少蝉联MVP</h2>
            <p>最后一次全明星，科比选了尽情享受。最后一次全明星，科比选了尽情享受。最后一次全明星，科比选了尽情享受</p>
        </div>
        <span>广告</span>
    </a>
    <div class="list">
        <ul>
            <li>
                <a href="huputiyu://bbs/topic/18445264">
                <img src="../static/nike-ad/ad2.png?1" width="75" height="75" alt="">
                <div class="list-content">
                    <h3>博古特谈库里博古特谈库里博古特谈库里</h3>
                    <p>博古特谈库里博古特谈库里博古特谈库里博古特谈库里博古特谈库里博古特谈库里</p>
                </div>
                </a>
            </li>
            <!-- <li>
                <a href="huputiyu://bbs/18445264">
                <img src="../static/nike-ad/ad2.png?2" width="75" height="75" alt="">
                <div class="list-content">
                    <h3>博古特谈库里博古特谈库里博古特谈库里</h3>
                    <p>博古特谈库里博古特谈库里博古特谈库里博古特谈库里博古特谈库里博古特谈库里</p>
                </div>
            </a>
           </li> -->
        </ul>
        <div class="nike-video">
            {%widget
                name="common:widget/video/video.tpl"
            %}

            <a href="http://m.hupu.com/soccer"><span>查看详情</span></a>
        </div>
        <div class="list-img">
            <a href="huputiyu://soccerleagues/liga/news/141694?type=3">
                <h2>追忆麦迪十六载，白马长枪今何在</h2>
                <div class="img-ad">
                    <img src="../static/nike-ad/ad2.png?6" width="30%" height="75" alt="">
                    <img src="../static/nike-ad/ad2.png?7" width="30%" height="75" alt="">
                    <img src="../static/nike-ad/ad2.png?8" width="30%" height="75" alt="">
                </div>
            </a>
        </div>
    </div>

</section>
{%/block%}
