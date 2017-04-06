<template>
<div class="welcome mod-wrap">
	<div class="hd">
		<img src="http://w10.hoopchina.com.cn/hybrid/exam/static/test_bg_1.jpg" alt="" />
	</div>
	<div class="bd">
		<h2>我们提倡：</h2>
		<p>尊重原创。藏龙卧虎的虎扑不断涌现的优秀原创是虎扑的财富，虎扑欢迎任何优秀内容的分享，原创者非常辛苦，转载、翻译都请尽量注明出处。</p>
		<h2>我们反对：</h2>
		<p>对人不对事。我们可以针对事件发表自己的意见。但是针对个人、针对群体的恶劣语言以及其过往言行的反复揭老底的行为，并不能显示多高尚，是我们最反对的行为。</p>
		<h2>答题规则：</h2>
		<ol>
			<li>1.本次答题无时间限制</li>
			<li>2.共{{question_qt}}题,答对{{pass_question_qt}}题通过答题</li>
			<li>3.通过答题后才能进行{{action_name}}</li>
			<li>4.在虎扑其他场景可能依然需要答题，请保持一个平和的心态</li>
		</ol>
		<div class="bottom clearfix">
			<a @click="gotoExam()" class="mod-btn">开始答题</a>
		</div>
	</div>
</div>
</template>

<script>
import * as utils from "common/utils";
import { getExam } from '../common/models'
import { getInfo, sendHideLoading } from 'common/app'

export default {
  data () {
    return {
		action_name: "互动",
		paper_id: 0,
		question_qt: 0,
		pass_question_qt: 0
    }
  },
  methods: {
	gotoExam () {
		this.$router.go({path: `/exam/${this.paper_id}` });
	},
	getPaper (paper_id){
      if(paper_id !== 0){
		  getExam.bind({paper_id})
                .execute( ({data})=>{
                    sendHideLoading()
					if(!data.is_answered){
						this.question_qt = data.question_qt;
						this.pass_question_qt = data.pass_question_qt;
						this.action_name = data.action_name;
					} else{
						this.$router.go({ path: `/exam/${paper_id}?review=welcome` });
					}
                }, ()=>{
                    utils.exitExam();
                });
      } else{
		// 考卷id缺失，关闭当前页面
		utils.exitExam();
      }
    }
  },
  route: {
    data ({to, next}) {
		this.paper_id = this.$route.params.id || 0;

		this.getPaper( this.paper_id );
    }
  }
}
</script>

<style lang="less">
@import "../styles/welcome.less";
</style>
