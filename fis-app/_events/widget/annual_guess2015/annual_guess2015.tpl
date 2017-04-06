<section class="guess-wrap" id="J-guess-wrap">
    <div class="bd" id="J-list">
    <script id="J-list-tpl" type="text/template">
    <div class="list-container">
    <@ $(datas).each(function(index,item) { @>
        <@ if(index % 2 === 0){@>
        <div class="list-wrap">
        <ul class="list">
        <@ } @>
            <li class="clearfix">
                <div class="fl">
                    <i class="icon"></i>
                    <span>预测</span>
                </div>
                <div class="fr">
                    <div class="question"><@=item.content@></div>
                    <div class="answers">
                        <@$(item.data).each(function(idx, item){@>
                            <div class="<@=(idx % 2 === 0 ?'yes':'no')@>">
                                <div class="detail clearfix">
                                    <div class="fl"><@=item.op@></div>
                                    <div class="fr"><@=item.opCount@>人</div>
                                </div>
                                <div class="progress">
                                    <div class="inner" style="width: <@=item.opPercent@>%"></div>
                                </div>
                            </div>
                        <@})@>
                    </div>
                </div>
            </li>
        <@ if(index % 2 === 1 || (index + 1 === datas.length)){@>
        </ul>
        </div>
        <@ } @>
        <@ }) @>
    </div>
    </script>
    </div>
</section>

{%script%}
    var guess = require("./annual_guess2015.js");
    guess.init();
{%/script%}
