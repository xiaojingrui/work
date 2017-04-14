<script id="J_predictNotice" type="text/template">
    <div class="prediction-tips" id="J_preTips" section-exposure="{%$id4dace%}_showmsg">
        <a href="<@=url@>{%$urlParam%}">您有新的预测结果，点击查看</a>
    </div>
</script>
{%script%}
    var predictionTips = require("common:widget/prediction-tips/prediction-tips.js");
    
    predictionTips.init();
{%/script%}