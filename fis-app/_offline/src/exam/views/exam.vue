<template>
<div class="exam mod-wrap">
	<loading :show="isLoading" text="" position="absolute"></loading>
	<div class="hd">
		<img src="http://w10.hoopchina.com.cn/hybrid/exam/static/test_bg_2.jpg" alt="">
	</div>
	<div class="bd">
		<ul class="list" v-if="!review">
			<li v-for="(index, question) in questions">
				<div class="question">
					<span class="num">{{$index+1}}</span>
					<span class="name">{{question.content}}</span>
				</div>
				<ol class="answer">
					<li v-for="itemIndex in indexs" @click="selected(index, question.answers[$index].key)" :class="{ active: hasSelected(question.selected, question.answers[$index].key) }">{{itemIndex}}. {{question.answers[$index].name}}</li>
				</ol>
			</li>
		</ul>
		<ul class="list" v-if="review">
			<li v-for="question in questions" :class="{ error: !question.correct }">
				<div class="question">
					<span class="num">{{$index+1}}</span>
					<span class="name">{{question.content}}</span>
				</div>
				<ol class="answer">
					<li v-for="itemIndex in indexs" :class="{ active: hasSelected(question.choose_answer, question.answers[$index].key) }">{{itemIndex}}. {{question.answers[$index].name}}</li>
				</ol>
			</li>
		</ul>
		<div class="bottom clearfix">
			<span @click="submit()" class="mod-btn" v-if="!review">提交答卷</span>

			<span @click="gotofinish()" class="mod-btn fl" v-if="review">回看成绩</span>
			<span @click="finish()" class="mod-btn fr" v-if="review">完成考试</span>
		</div>
	</div>
	<toast :show.sync="showToast" :time="2000" type="text">{{toastMsg}}</toast>
</div>
</template>

<script>
import * as utils from "common/utils"
import { Loading, Toast } from 'components'
import { getExam, submitAnswer } from '../common/models'

export default {
  components:{
	  Loading,
	  Toast
  },
  data () {
  	return {
  	  paper_id: 0,
	  review: false,
      questions: [],
      question_qt: 0,
	  indexs: ['A','B','C','D'],
	  showToast: false,
	  toastMsg : '',
	  isLoading: true
    }
  },
  methods: {
	hasSelected( selected = [], key){
		return !!~selected.indexOf(key)
	},
	finish () {
		return utils.exitExam()
    },
    selected (index, num){
    	this.questions[index]["selected"] = [num]
    },
	gotofinish(){
		this.$router.go({ 'path' : `/finish/${this.paper_id}` })
	},
    submit () {
    	let result = [];
		let isAllChoose = true;
    	this.questions.map(item => {
    		result.push({
    			question_id: item.question_id,
    			choose_answer: item.selected
    		})
    		if(item.selected.length == 0){
    			isAllChoose = false
    		}
    	});

    	if(isAllChoose){
    		this.sendAnswer(result, this.paper_id, ()=>{
				this.gotofinish();
			});
    	}else{
    	  this.toast("请做完全部题目。");
    	}

    },
    getPaper (paper_id){
      if(paper_id !== 0){

	    getExam
		  .bind({paper_id})
	      .execute(({data}) => {
			   this.isLoading = false
		      	data.question_list.map((item, idx) =>{
		      		item.selected = []
					let answers = []
					if(item.available_answer){
						this.indexs.forEach(key => {
							if(item.available_answer[key]){
								answers.push({
								   key: key,
								   name: item.available_answer[key]
								})
							}
						})
						answers = answers.sort(() => {
							return Math.random() > .5 ? -1 : 1
						})
					}
					item.answers = answers
		      	})
	        	this.questions = data.question_list
		}, ({data, msg}) => {
			this.isLoading = false
			this.toast(msg)
		})
      } else{
      	this.toast("试卷id出错");
      }
    },
	toast(msg){
		this.$emit('toast', msg)
	},
    sendAnswer (answer_list, paper_id, callback) {
		submitAnswer
			.bind({answer_list, paper_id})
			.execute(() => {
				callback && callback()
			})
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
		this.review = !!this.$route.query.review;
	    this.getPaper(this.paper_id);
    }
  }
}
</script>

<style lang="less">
@import "../styles/exam.less";
</style>
