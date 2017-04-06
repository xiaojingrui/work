<template>
<div class="vs-wrap-soccer" :class="{'no-background': leaguename == 'afccl'}">
	<div class="vs-con">
		<section class="elimination-game above-game">
			<div class="group" v-for="item in arraySlice(datas[8], 0 ,4)">
				<a class="left-logo" :href="href(item.home_tid)" v-if="item.home_tid">
					<img :src="getSrc(item.home_tid, item.win == 2, item.home_logo)" />
				</a>
				<div class="left-logo" v-else>
					<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
				</div>
				<div class="middle-info">
					<span>{{item.round_1}}</span>
					<span v-if="item.round_1 != '未赛'">{{item.round_2}}</span>
					<i v-if="item.type == 2 && item.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':item.away_tid,'right-logo': !item.away_tid}" :href="href(item.away_tid)">
					<img :src="getSrc(item.away_tid, item.win == 1, item.away_logo)" />
				</a>
			</div>
		</section>

		<section class="eight-game above-game">
			<div class="group" v-for="item in arraySlice(datas[4], 0, 2)">
				<a class="left-logo" :href="href(item.home_tid)" v-if="item.home_tid">
					<img :src="getSrc(item.home_tid, item.win == 2, item.home_logo)" />
				</a>
				<div class="left-logo" v-else>
					<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
				</div>
				<div class="middle-info">
					<span>{{item.round_1}}</span>
					<span v-if="item.round_1 != '未赛'">{{item.round_2}}</span>
					<i v-if="item.type == 2 && item.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':item.away_tid,'right-logo': !item.away_tid}" :href="href(item.away_tid)">
					<img :src="getSrc(item.away_tid, item.win == 1, item.away_logo)" />
				</a>
				<div class="line"></div>
			</div>
		</section>

		<section class="semi-game above-game">
			<div class="group">
				<div class="title">半决赛</div>
				<a class="left-logo" :href="href(semi.home_tid)">
					<img :src="getSrc(semi.home_tid, semi.win == 2, semi.home_logo)" />
				</a>
				<div class="middle-info">
					<span>{{semi.round_1}}</span>
					<span v-if="semi.round_1 != '未赛'">{{semi.round_2}}</span>
					<i v-if="semi.type == 2 && semi.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':semi.away_tid,'right-logo': !semi.away_tid}" :href="href(semi.away_tid)">
					<img :src="getSrc(semi.away_tid, semi.win == 1, semi.away_logo)" />
				</a>
				<div class="line"></div>
			</div>
		</section>

		<section class="final-game">
			<div class="final-group">
				<div class="title">决赛</div>
				<a class="left-logo" :href="href(final.home_tid)" v-if="final.home_tid">
					<img :src="getSrc(final.home_tid, final.win == 2, final.home_logo)" />
					<span>{{final.home_name}}</span>
				</a>
				<div class="left-logo" v-else>
					<img src="http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png" alt="">
				</div>
				<div class="middle-info">
					<span>{{final.round_1}}</span>
					<span v-if="final.round_1 != '未赛'">{{final.round_2}}</span>
					<i v-if="final.type == 2 && final.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':final.away_tid,'right-logo': !final.away_tid}" :href="href(final.away_tid)">
					<img :src="getSrc(final.away_tid, final.win == 1, final.away_logo)" />
					<span>{{final.away_name}}</span>
				</a>
				<div class="bottom-info" v-if="leaguename == 'chlg'">
					威尔士国家体育场 2017.6.4
				</div>
			</div>
		</section>

		<section class="semi-game below-game">
			<div class="group">
				<div class="title">半决赛</div>
				<a class="left-logo" :href="href(semi2.home_tid)">
					<img :src="getSrc(semi2.home_tid, semi2.win == 2, semi2.home_logo)" />
				</a>
				<div class="middle-info">
					<span>{{semi2.round_1}}</span>
					<span v-if="semi2.round_1 != '未赛'">{{semi2.round_2}}</span>
					<i v-if="semi2.type == 2 && semi2.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':semi2.away_tid,'right-logo': !semi2.away_tid}" :href="href(semi2.away_tid)">
					<img :src="getSrc(semi2.away_tid, semi2.win == 1, semi2.away_logo)" />
				</a>
				<div class="line"></div>
			</div>
		</section>

		<section class="eight-game below-game">
			<div class="group" v-for="item in arraySlice(datas[4], 2 ,4)">
				<a class="left-logo" :href="href(item.home_tid)">
					<img :src="getSrc(item.home_tid, item.win == 2, item.home_logo)" />
				</a>
				<div class="middle-info">
					<span>{{item.round_1}}</span>
					<span v-if="item.round_1 != '未赛'">{{item.round_2}}</span>
					<i v-if="item.type == 2 && item.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':item.away_tid,'right-logo': !item.away_tid}" :href="href(item.away_tid)">
					<img :src="getSrc(item.away_tid, item.win == 1, item.away_logo)" />
				</a>
				<div class="line"></div>
			</div>
		</section>

		<section class="elimination-game below-game">
			<div class="group" v-for="item in arraySlice(datas[8], 4 ,8)">
				<a class="left-logo" :href="href(item.home_tid)">
					<img :src="getSrc(item.home_tid, item.win == 2, item.home_logo)" />
				</a>
				<div class="middle-info">
					<span>{{item.round_1}}</span>
					<span v-if="item.round_1 != '未赛'">{{item.round_2}}</span>
					<i v-if="item.type == 2 && item.round_1 != '未赛'">点</i>
				</div>
				<a :class="{'left-logo':item.away_tid,'right-logo': !item.away_tid}" :href="href(item.away_tid)">
					<img :src="getSrc(item.away_tid, item.win == 1, item.away_logo)" />
				</a>
			</div>
		</section>
	</div>
</div>
</template>

<script>
import { arraySlice } from 'common/utils'
import _ from 'underscore'

export default {
    props: {
		leaguename: String,
		datas: Object
    },
	methods: {
		arraySlice,
		href( tid ){
			return this.leaguename == 'chlg' ? `kanqiu://soccerleagues/${this.leaguename}/team/${tid}`:`javascript:void(0)`
		},
		getSrc( tid , status, url ){
			if(!tid) return 'http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png'

			if(this.leaguename == 'chlg'){
				return `http://b1.hoopchina.com.cn/games/teams/${this.leaguename}/8_${tid}${status ? '_d':''}.png`
			} else if(this.leaguename == 'afccl'){
				return status ? url.substr(0, url.length - 4) + "_d.png" : url
			}
		}
	},
	computed:{
		semi(){
		  return !_.isEmpty(this.datas) ? this.datas[2][0] : {}
	    },
		final(){
		  return !_.isEmpty(this.datas) ? this.datas[1][0] : {}
	    },
	  	semi2(){
		  return !_.isEmpty(this.datas) ? this.datas[2][1] : {}
		}
	}
}
</script>

<style lang="less">
.vs-wrap-soccer{
	position: relative;
	width: 100%;
	padding: 5px 0 128%;
	background: #eeebeb url(http://b1.hoopchina.com.cn/games/images/bg.7.0.0.png) 50% 20% no-repeat;
	background-size: 94%;
	border-bottom: 1px solid #d5d5d5;
	.vs-con{
		position: absolute;
		width: 100%;
		height: 100%;
	}
	.elimination-game,.semi-game{
		display: -webkit-box;
	    display: -ms-flexbox;
	    display: -webkit-flex;
	    display: -moz-flex;
	    display: flex;
	    -webkit-box-pack: justify;
	    -ms-flex-pack: justify;
	    -webkit-justify-content: space-between;
	    -moz-justify-content: space-between;
	    justify-content: space-between;
        padding:0 1.5%;
        height: 10%;
        margin-bottom: 4%;

	}
	.eight-game{
		.group{
            &:nth-child(1){
                left: 13%;
            }
            &:nth-child(2){
                left: 39%;
            }
        }
	}

    .group{
    	width: 24%;
    	height: 100%;
    	background: #fff;
    	border-radius: 4px;
		display: -webkit-box;
	    display: -ms-flexbox;
	    display: -webkit-flex;
	    display: -moz-flex;
	    display: flex;
	    position: relative;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
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
			width: 31%;
			display: -webkit-box;
		    display: -ms-flexbox;
		    display: -webkit-flex;
		    display: -moz-flex;
		    display: flex;
		    -webkit-box-align: center;
		    -ms-flex-align: center;
		    -webkit-align-items: center;
		    -moz-align-items: center;
		    align-items: center;
            -webkit-tap-highlight-color:rgba(0,0,0,0.2);
            img{
                width: 100%;
            }
		}

		.middle-info{
			-webkit-box-flex: 1;
		    -ms-flex: 1;
		    -webkit-flex: 1;
		    -moz-flex: 1;
		    flex: 1;
		    display: -webkit-box;
		    display: -ms-flexbox;
		    display: -webkit-flex;
		    display: -moz-flex;
		    display: flex;
		    -webkit-box-orient: vertical;
		    -ms-flex-direction: column;
		    -webkit-flex-direction: column;
		    -moz-flex-direction: column;
		    flex-direction: column;
		    -webkit-box-pack: center;
		    -ms-flex-pack: center;
		    -webkit-justify-content: center;
		    -moz-justify-content: center;
		    justify-content: center;
		    -ms-flex-line-pack: stretch;
		    -webkit-align-content: stretch;
		    -moz-align-content: stretch;
		    align-content: stretch;
			color: #434141;
            font-size: 12px;
			-webkit-transform: scale(0.8);
		    transform: scale(0.8);

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

	.eight-game{
		display: -webkit-box;
	    display: -ms-flexbox;
	    display: -webkit-flex;
	    display: -moz-flex;
	    display: flex;
        padding:0 1.5%;
        height: 10%;
        margin-bottom: 4%;
	}
	.semi-game{
		-webkit-box-pack: center;
	   -ms-flex-pack: center;
	   -webkit-justify-content: center;
	   -moz-justify-content: center;
	   justify-content: center;
        padding: 0;
       	.title{
       		width: 42px;
       		background: #ff7623;
       		border-radius: 2px;
       	}
       	.middle-info{
			padding-top: 10px;
		}
	}
	.final-game{
		display: -webkit-box;
	    display: -ms-flexbox;
	    display: -webkit-flex;
	    display: -moz-flex;
	    display: flex;
	    -webkit-box-pack: center;
	    -ms-flex-pack: center;
	    -webkit-justify-content: center;
	    -moz-justify-content: center;
	    justify-content: center;
        height: 19%;
        margin-bottom: 4%;
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
			display: -webkit-box;
		    display: -ms-flexbox;
		    display: -webkit-flex;
		    display: -moz-flex;
		    display: flex;
		    position: relative;
		    -webkit-box-sizing: border-box;
		    -moz-box-sizing: border-box;
		    box-sizing: border-box;
    		.left-logo,.right-logo{
                display: block;
    			padding-top: 3%;
				width: 36%;
				color: #434141;
                -webkit-tap-highlight-color:rgba(0,0,0,0.2);

				img{
					display: block;
					width: 70%;
					margin-left: 15%;
					margin-bottom: 4px;
				}
				span{
					display: block;
					font-size: 12px;
					line-height: 14px;
					text-align: center;
				}
    		}
    		.middle-info{
				-webkit-box-flex: 1;
			    -ms-flex: 1;
			    -webkit-flex: 1;
			    -moz-flex: 1;
			    flex: 1;
			    display: -webkit-box;
			    display: -ms-flexbox;
			    display: -webkit-flex;
			    display: -moz-flex;
			    display: flex;
			    -webkit-box-orient: vertical;
			    -ms-flex-direction: column;
			    -webkit-flex-direction: column;
			    -moz-flex-direction: column;
			    flex-direction: column;
			    -webkit-box-pack: center;
			    -ms-flex-pack: center;
			    -webkit-justify-content: center;
			    -moz-justify-content: center;
			    justify-content: center;

    			color: #434141;
    			span{
    				display: block;
    				line-height: 14px;
    				text-align: center;
    				white-space:nowrap;
    				&.score{
    					font-size: 18px;
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
					-webkit-transform: scale(0.8);
				    transform: scale(0.8);

    			}
    			em{
    				font-style: normal;

    			}
    		}
        }
	}
}

.no-background { background-color: #eeebeb; background-image: none;}


.night  {
	.vs-wrap-soccer{
		background-color: #1f1f1f;
		background-image: url("http://b1.hoopchina.com.cn/games/images/bg-night.png");
		border-bottom: 1px solid #2c2c2c;
		.group{
			background-color: #2c2c2c;
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
	.no-background { background-color: #1f1f1f; background-image: none;}
}

@media (min-width: 375px){
	.mod-rank-wrap .vs-wrap .elimination-game .group .left-logo, .mod-rank-wrap .vs-wrap .elimination-game .group .right-logo{ width: 34%;}
	.mod-rank-wrap .vs-wrap .group .title{-webkit-transform: translateX(-50%) scale(1);transform: translateX(-50%) scale(1);}
}
</style>
