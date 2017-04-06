<template>
	<div class="finish mod-wrap">
		<!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
		<div class="hd">
			<img src="http://w10.hoopchina.com.cn/hybrid/exam/static/test_bg_3.jpg" alt="" v-if="pass_status">
			<img src="http://w10.hoopchina.com.cn/hybrid/exam/static/test_bg_4.jpg" alt="" v-if="!pass_status">
		</div>
		<div :class="{good: pass_status, bad: !pass_status}">
			<div class="result-pic"></div>
			<div class="result clearfix">
				<div class="item fl">
					<div class="title">本次考试</div>
					<div class="num">
						<span>{{question_qt}}<i>题</i></span>
					</div>
				</div>
				<div class="item fr">
					<div class="title">共答对</div>
					<div class="num">
						<span>{{correct_question_qt}}<i>题</i></span>
					</div>
				</div>
			</div>
			<p class="tip" v-if="pass_status">恭喜你通过考试，希望你发表的观点是虎扑鼓励的内容，期待与你共同建立一个友善的优质体育社区。</p>
			<p class="tip" v-if="!pass_status">很遗憾，你没有通过考试，希望你不要急于发表自己的观点，先去浏览内容，感受虎扑的氛围吧。</p>

		</div>
		<div class="bottom clearfix">
			<a @click="gotoReview()" class="mod-btn fl">查看错题</a>
			<a @click="finish()" class="mod-btn fr">完成考试</a>
		</div>
		<toast :show.sync="showToast" :time="2000" type="text">{{toastMsg}}</toast>
	</div>
</template>

<script>
import * as utils from "common/utils"
import { Toast, Loading } from 'components'
import { getExam } from '../common/models'

export default {
  components:{
	  Toast,
	  Loading
  },
  data () {
  	return {
		retry: 0,
	  	paper_id: 0,
		pass_status: 1,
		question_qt: 0,
		pass_question_qt: 0,
		correct_question_qt: 0,
		showToast: false,
		toastMsg : '',
		isLoading: true
    }
  },
  methods: {
	gotoReview(){
		this.$router.go({path: `/exam/${this.paper_id}?review=finish` });
	},
    finish () {
		return utils.exitExam()
    },
    getPaper (paper_id){
	     if(paper_id !== 0){
			  let t = utils.getTime();
			  getExam
			  	.bind({paper_id, t})
				.execute( ({data}) => {
				  this.isLoading = false
				  //如果没有返回已回答，加入重试机制，最多重试一次.
				  if(data.is_answered || this.retry >= 1){
			  		  this.items = data.question_list;
					  this.question_qt = data.question_qt;
					  this.pass_question_qt = data.pass_question_qt;
					  this.correct_question_qt = data.correct_question_qt;
					  this.pass_status = data.correct_question_qt >= data.pass_question_qt;
				  }else{
					  this.retry = this.retry + 1;
					  this.getPaper(paper_id);
				  }
			  })
	      } else{
	      	this.toast("试卷id出错");
	      }
	  },
	  toast(msg){
		  this.$emit('toast', msg)
	  }
  },
  events:{
	  'toast'(msg){
		  this.showToast = true
		  this.toastMsg  = msg
	  }
  },
  route: {
    data ({to, next}) {
		this.paper_id = this.$route.params.id || 0;
	    this.getPaper(this.paper_id);
    }
  }
}
</script>

<style lang="less">
@import "../styles/finish.less";
</style>
