<template>
<div class="zxb" :style="{height: height}">
    <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
    <div class="hd" v-if="!isLoading">第五轮、半决赛及决赛</div>
    <div class="zxb-vs-wrap" v-if="!isLoading">
        <div class="vs-con">
        	<section class="eight-game above-game">
        		<div class="group" v-for="item in arraySlice(datas[4], 0, 2)">
        			<div class="inner">
        					<a class="left-logo" v-if="item.home_tid" :href="href(item.home_tid)">
        						<img :src="logo(item.win == 2, item.home_logo)" alt="" />
        						<span>{{item.home_name}}</span>
        					</a>
        					<div class="left-logo" v-else>
        						<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
        					</div>
        				<div class="middle-info">
    						<span>{{item.round_1}}</span>
    						<span v-if="item.round_1 != '未赛'">{{item.round_2}}</span>
    						<i v-if="item.type == 2">点</i>
        				</div>
    					<a class="left-logo" v-if="item.away_tid" :href="href(item.away_tid)" >
    						<img :src="logo(item.win == 1, item.away_logo)" alt="" />
    						<span>{{item.away_name}}</span>
    					</a>
    					<div class="right-logo" v-else>
    						<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
    					</div>
        				<div class="line"></div>
        			</div>
        		</div>
        	</section>

        	<section class="semi-game above-game">
        		<div class="group">
        			<div class="title">半决赛</div>
        				<a class="left-logo" v-if="semi.home_tid" :href="href(semi.home_tid)">
        					<img :src="logo(semi.win == 2, semi.home_logo)" alt="" />
        					<span>{{semi.home_name}}</span>
        				</a>
        				<div class="left-logo" v-else>
        					<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
        				</div>
        			<div class="middle-info">
                        <span>{{semi.round_1}}</span>
                        <span v-if="semi.round_1 != '未赛'">{{semi.round_2}}</span>
                        <i v-if="semi.type == 2">点</i>
        			</div>
                    <a class="left-logo" v-if="semi.away_tid" :href="href(semi.away_tid)" >
                        <img :src="logo(semi.win == 1, semi.away_logo)" alt="" />
                        <span>{{semi.away_name}}</span>
                    </a>
                    <div class="right-logo" v-else>
                        <img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
                    </div>
                    <div class="line"></div>
        		</div>
        	</section>

        	<section class="final-game">
        		<div class="final-group">
        			<div class="title">决赛</div>
                        <a class="left-logo" v-if="final.home_tid" :href="href(final.home_tid)">
                            <img :src="logo(final.win == 2, final.home_logo)" alt="" />
                            <span>{{final.home_name}}</span>
                        </a>
                        <div class="left-logo" v-else>
                            <img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
                        </div>

                        <div class="middle-info">
                            <span :class="{score: final.round_1 == '未赛'}">{{final.round_1}}</span>
                            <span v-if="final.round_1 != '未赛'">{{final.round_2}}</span>
                            <i v-if="final.type == 2">点</i>
            			</div>

                        <a class="left-logo" v-if="final.away_tid" :href="href(final.away_tid)" >
                            <img :src="logo(final.win == 1, final.away_logo)" alt="" />
                            <span>{{final.away_name}}</span>
                        </a>
                        <div class="right-logo" v-else>
                            <img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
                        </div>
                        <div class="line"></div>
        		</div>
        	</section>

        	<section class="semi-game below-game">
                <div class="group">
        			<div class="title">半决赛</div>
        				<a class="left-logo" v-if="semi2.home_tid" :href="href(semi2.home_tid)">
        					<img :src="logo(semi2.win == 2, semi2.home_logo)" alt="" />
        					<span>{{semi2.home_name}}</span>
        				</a>
        				<div class="left-logo" v-else>
        					<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
        				</div>
        			<div class="middle-info">
                        <span>{{semi2.round_1}}</span>
                        <span v-if="semi2.round_1 != '未赛'">{{semi2.round_2}}</span>
                        <i v-if="semi2.type == 2">点</i>
        			</div>
                    <a class="left-logo" v-if="semi2.away_tid" :href="href(semi2.away_tid)" >
                        <img :src="logo(semi2.win == 1, semi2.away_logo)" alt="" />
                        <span>{{semi2.away_name}}</span>
                    </a>
                    <div class="right-logo" v-else>
                        <img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
                    </div>
                    <div class="line"></div>
        		</div>
        	</section>

        	<section class="eight-game below-game">
        		<div class="group" v-for="item in arraySlice(datas[4], 2, 4)">
                    <div class="inner">
        					<a class="left-logo" v-if="item.home_tid" :href="href(item.home_tid)">
        						<img :src="logo(item.win == 2, item.home_logo)" alt="" />
        						<span>{{item.home_name}}</span>
        					</a>
        					<div class="left-logo" v-else>
        						<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
        					</div>
        				<div class="middle-info">
    						<span>{{item.round_1}}</span>
    						<span v-if="item.round_1 != '未赛'">{{item.round_2}}</span>
    						<i v-if="item.type == 2">点</i>
        				</div>
    					<a class="left-logo" v-if="item.away_tid" :href="href(item.away_tid)" >
    						<img :src="logo(item.win == 1, item.away_logo)" alt="" />
    						<span>{{item.away_name}}</span>
    					</a>
    					<div class="right-logo" v-else>
    						<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
    					</div>
        				<div class="line"></div>
        			</div>
        		</div>
        	</section>
        </div>
    </div>
</div>
</template>

<script>
import { getSoccerZxb } from '../common/models'
import { arraySlice } from 'common/utils'
import { Loading } from 'components'
import { getInfo, sendHideLoading } from 'common/app'

export default {
    components: {
        Loading
    },
    ready(){
        getSoccerZxb.execute(({data}) => {
            this.datas = data.against_figure
            this.isLoading = false
            sendHideLoading()
        });
    },
    data () {
      return {
        leaguename: "csl",
        datas: {},
        isLoading: true
      }
    },
    methods: {
        arraySlice,
        logo (status, url){
            return status ? url.substr(0, url.length - 4) + "_d.png" : url
        },
        href(tid){
            return tid != '10000001' ? `kanqiu://soccerleagues/${this.leaguename}/team/${tid}`: 'javascript:;'
        }
    },
    computed: {
        semi(){
            return this.datas[2][0]
        },
        final(){
            return this.datas[1][0]
        },
        semi2(){
            return this.datas[2][1]
        },
        height(){
            return `${document.documentElement.clientHeight}px`
        }
    },
    route: {
      data ({to, next}) {

      }
    }
}
</script>

<style lang="less">
.zxb{
    background-color: #eeebeb;
    .hd {
        line-height: 24px;
        text-indent: 10px;
        font-size: 12px;
        color: #434341;
    }
    .zxb-vs-wrap{
    	width: 100%;
    	background-color: #eeebeb;

    	.eight-game,.semi-game{
            display:-webkit-box;
        	display:-ms-flexbox;
        	display:-webkit-flex;
        	display:-moz-flex;
        	display:flex;
        	-ms-flex-pack:distribute;
        	-webkit-justify-content:space-around;
        	-moz-justify-content:space-around;
        	justify-content:space-around;
            height: 10%;
            margin-bottom: 20px;
    	}

    	.eight-game {
    		.group {
                -webkit-box-flex:1;
            	-ms-flex:1;
            	-webkit-flex:1;
            	-moz-flex:1;
            	flex:1;
    			margin: 0 5%;
    			background: #fff;
    			border-radius: 4px;
    		}

    		.inner {
                display:-webkit-box;
            	display:-ms-flexbox;
            	display:-webkit-flex;
            	display:-moz-flex;
            	display:flex;
    			position: relative;
    			height: 50px;
                -webkit-box-sizing:border-box;
            	-moz-box-sizing:border-box;
            	box-sizing:border-box
    		}
    	}

        .group{
        	width: 40%;
            display:-webkit-box;
            display:-ms-flexbox;
            display:-webkit-flex;
            display:-moz-flex;
            display:flex;
    		position: relative;
    		height: 50px;
    		background: #fff;
    		border-radius: 4px;
            -webkit-box-sizing:border-box;
            -moz-box-sizing:border-box;
            box-sizing:border-box;

    		.title{
    			position: absolute;
    			width: 30%;
    			height: 14px;
    			background-color: #ffae00;
    			color: #fff;
    			font-size: 12px;
    			line-height: 14px;
    			top: -1px;
    			left: 50%;
    			-webkit-transform: translateX(-50%) scale(0.8);
    			transform: translateX(-50%) scale(0.8);
    			text-align: center;
    		}

    		.left-logo,.right-logo{
    			text-align: center;
    			width: 42%;
                display:-webkit-box;
            	display:-ms-flexbox;
            	display:-webkit-flex;
            	display:-moz-flex;
            	display:flex;
            	-webkit-box-align:center;
            	-ms-flex-align:center;
            	-webkit-align-items:center;
            	-moz-align-items:center;
            	align-items:center;
            	-webkit-box-pack:center;
            	-ms-flex-pack:center;
            	-webkit-justify-content:center;
            	-moz-justify-content:center;
            	justify-content:center;
            	-webkit-box-orient:vertical;
            	-ms-flex-direction:column;
            	-webkit-flex-direction:column;
            	-moz-flex-direction:column;
            	flex-direction:column;
                -webkit-tap-highlight-color:rgba(0,0,0,0.2);
    			span{
    				display: block;
    				font-size: 10px;
    				line-height: 14px;
    				text-align: center;
    				height: 14px;
    				overflow: hidden;
    			}
                img{
                    width: 50%;
                }
    		}

    		.middle-info{
                -webkit-box-flex:1;
            	-ms-flex:1;
            	-webkit-flex:1;
            	-moz-flex:1;
            	flex:1;
            	display:-webkit-box;
            	display:-ms-flexbox;
            	display:-webkit-flex;
            	display:-moz-flex;
            	display:flex;
            	-webkit-box-orient:vertical;
            	-ms-flex-direction:column;
            	-webkit-flex-direction:column;
            	-moz-flex-direction:column;
            	flex-direction:column;
            	-webkit-box-pack:center;
            	-ms-flex-pack:center;
            	-webkit-justify-content:center;
            	-moz-justify-content:center;
            	justify-content:center;
            	-ms-flex-line-pack:stretch;
            	-webkit-align-content:stretch;
            	-moz-align-content:stretch;
            	align-content:stretch;
    			color: #434141;
                font-size: 12px;
    			@include scale(0.8);

    			span{
    				display: block;
    				line-height: 14px;
    				text-align: center;
    				white-space:nowrap;
    			}
    			i{
    				display: block;
    				font-style: normal;
    				width: 16px;
    				height: 16px;
    				font-size: 10px;
    				background: #c81212;
    				border-radius: 50%;
    				margin: 2px auto 0;
    				color: #fff;
    				text-align: center;
    				line-height: 16px;
    				-webkit-text-size-adjust:none;
    			}
    		}
        }

    	.semi-game{
            -webkit-box-pack:center;
        	-ms-flex-pack:center;
        	-webkit-justify-content:center;
        	-moz-justify-content:center;
        	justify-content:center;
            padding: 0;
           	.title{
           		width: 42px;
           		background: #ff7623;
           		border-radius: 2px;
           	}
           	.middle-info{
    			padding-top: 8px;
    		}
    	}

    	.final-game{
            display:-webkit-box;
        	display:-ms-flexbox;
        	display:-webkit-flex;
        	display:-moz-flex;
        	display:flex;
        	-webkit-box-pack:center;
        	-ms-flex-pack:center;
        	-webkit-justify-content:center;
        	-moz-justify-content:center;
        	justify-content:center;
            height: 90px;
            margin-bottom: 20px;
            position: relative;

            .title{
            	position: absolute;
    			width: 30px;
    			height: 14px;
    			background-color: #ff4252;
    			border-radius: 2px;
    			color: #fff;
    			font-size: 12px;
    			line-height: 14px;
    			top: 0px;
    			left: 50%;
    			-webkit-transform: translateX(-50%);
    			transform: translateX(-50%);
    			text-align: center;
           	}
           	.middle-info{
    			padding: 16px 0;
    		}
    		.bottom-info{
    			position: absolute;
    			width: 100%;
    			color: #a9a9b2;
    			font-size: 12px;
    			line-height: 12px;
    			bottom: 0px;
    			left: 50%;
    			-webkit-transform: translateX(-50%);
    			transform: translateX(-50%);
    			text-align: center;

    		}
            .final-group{
            	width: 62%;
            	height: 100%;
            	background: #fff;
            	border-radius: 4px;
                display:-webkit-box;
            	display:-ms-flexbox;
            	display:-webkit-flex;
            	display:-moz-flex;
            	display:flex;
            	position:relative;
            	-webkit-box-sizing:border-box;
            	-moz-box-sizing:border-box;
            	box-sizing:border-box;

        		.left-logo,.right-logo{
                    display: block;
        			padding-top: 9%;
    				width: 36%;
    				color: #434141;
                    -webkit-tap-highlight-color:rgba(0,0,0,0.2);

    				img{
    					display: block;
    					width: 45%;
    					margin-left: 26%;
    					margin-bottom: 4px;
    				}
    				span{
    					display: block;
    					font-size: 10px;
    					line-height: 14px;
    					text-align: center;
    				}
        		}
        		.middle-info{
                    -webkit-box-flex:1;
                	-ms-flex:1;
                	-webkit-flex:1;
                	-moz-flex:1;
                	flex:1;
                	display:-webkit-box;
                	display:-ms-flexbox;
                	display:-webkit-flex;
                	display:-moz-flex;
                	display:flex;
                	-webkit-box-orient:vertical;
                	-ms-flex-direction:column;
                	-webkit-flex-direction:column;
                	-moz-flex-direction:column;
                	flex-direction:column;
                	-webkit-box-pack:center;
                	-ms-flex-pack:center;
                	-webkit-justify-content:center;
                	-moz-justify-content:center;
                	justify-content:center;

        			color: #434141;
        			span{
        				display: block;
        				line-height: 14px;
        				text-align: center;
        				white-space:nowrap;
        				&.score{
        					font-size: 14px;
        					font-weight: 700;
        					line-height: 26px;
        				}
        			}
        			i{
        				display: block;
        				font-style: normal;
        				width: 16px;
        				height: 16px;
        				font-size: 12px;
        				background: #c81212;
        				border-radius: 9px;
        				margin: 0 auto;
        				color: #fff;
        				text-align: center;
        				line-height: 16px;
    					-webkit-text-size-adjust:none;
    					@include scale(0.8);

        			}
        			em{
        				font-style: normal;
        			}
        		}
            }
    	}
    }
}

.night  {
	color: #999;
    .zxb{
    background-color: #1f1f1f;

    .hd {
        color: #959595;
    }
	.zxb-vs-wrap{
		background-color: #1f1f1f;
		.group{
			background-color: #2c2c2c;
			.left-logo,.right-logo {
				span {
					color: #959595;
				}
			}
			.middle-info{
				color: #959595;
				i{
					background-color: #780b0b;
					color: #959595;
				}
			}
			.title{
				background-color: #996800;
				color: #959595;
			}
		}
		.semi-game .group .title{
			background-color: #994715;
		}

		.final-game .final-group{
			background-color: #2c2c2c;
			.title{
				background-color: #992831;
				color: #959595;
			}
			.left-logo,.right-logo{
				color: #959595;
			}
			.middle-info{
				color: #959595;
				i{
					background-color: #780b0b;
					color: #959595;
				}
			}
			.bottom-info{
				color: #5a5a5f;
			}
		}
	}
    }
}

@media (min-width: 375px){
	.mod-rank-wrap .vs-wrap .elimination-game .group .left-logo, .mod-rank-wrap .vs-wrap .elimination-game .group .right-logo{ width: 34%;}
	.mod-rank-wrap .vs-wrap .group .title{-webkit-transform: translateX(-50%) scale(1);transform: translateX(-50%) scale(1);}
}
</style>
