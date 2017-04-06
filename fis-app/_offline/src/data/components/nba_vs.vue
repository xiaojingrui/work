<template>
    <section class="vs-box-wrap">
    	<div class="vs-box">
    		<!-- 东部 -->
    		<div class="top">
    	    	<!-- 8强 -->
    			<div class="vs-8">
    				<ul>
    					<li :class="{vs_gray: getGray(east.r1[1], east.r1[8]) }" @click="goto(east.r1[1].tid)">
    						<p>1</p>
    						<p><img :src="getSRc(east.r1[1], east.r1[8])"/></p>
    						<p class="team">{{east.r1[1].name}}</p>
    					</li>
    					<li class="score">{{east.r1[1].score}}-{{east.r1[8].score}}</li>

    					<li :class="{vs_gray: getGray(east.r1[8], east.r1[1]) }" @click="goto(east.r1[8].tid)">
    						<p>8</p>
    						<p><img :src="getSRc(east.r1[8], east.r1[1])"/></p>
    						<p class="team">{{east.r1[8].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(east.r1[4], east.r1[5]) }" @click="goto(east.r1[4].tid)">
    						<p>4</p>
    						<p><img :src="getSRc(east.r1[4], east.r1[5])"/></p>
    						<p class="team">{{east.r1[4].name}}</p>
    					</li>
    					<li class="score">{{east.r1[4].score}}-{{east.r1[5].score}}</li>

    					<li :class="{vs_gray: getGray(east.r1[5], east.r1[4]) }" @click="goto(east.r1[5].tid)">
    						<p>5</p>
    						<p><img :src="getSRc(east.r1[5], east.r1[4])"/></p>
    						<p class="team">{{east.r1[5].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(east.r1[3], east.r1[6]) }" @click="goto(east.r1[3].tid)">
    						<p>3</p>
    						<p><img :src="getSRc(east.r1[3], east.r1[6])"/></p>
    						<p class="team">{{east.r1[3].name}}</p>
    					</li>
    					<li class="score">{{east.r1[3].score}}-{{east.r1[6].score}}</li>

    					<li :class="{vs_gray: getGray(east.r1[6], east.r1[3]) }" @click="goto(east.r1[6].tid)">
    						<p>6</p>
    						<p><img :src="getSRc(east.r1[6], east.r1[3])"/></p>
    						<p class="team">{{east.r1[6].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(east.r1[2], east.r1[7]) }" @click="goto(east.r1[2].tid)">
    						<p>2</p>
    						<p><img :src="getSRc(east.r1[2], east.r1[7])"/></p>
    						<p class="team">{{east.r1[2].name}}</p>
    					</li>
    					<li class="score">{{east.r1[2].score}}-{{east.r1[7].score}}</li>

    					<li :class="{vs_gray: getGray(east.r1[7], east.r1[2]) }" @click="goto(east.r1[7].tid)">
    						<p>7</p>
    						<p><img :src="getSRc(east.r1[7], east.r1[2])"/></p>
    						<p class="team">{{east.r1[7].name}}</p>
    					</li>
    				</ul>
                </div>
    			<!-- 4强 -->
    			<div class="vs-4">
                    <ul>
    					<li :class="{vs_gray: getGray(east.r2[1], east.r2[2]) }" @click="goto(east.r2[1].tid)">
    						<p><img :src="getSRc(east.r2[1], east.r2[2])"/></p>
    						<p class="team">{{east.r2[1].name}}</p>
    					</li>
    					<li class="score">{{east.r2[1].score}}-{{east.r2[1].score}}</li>
    					<li :class="{vs_gray: getGray(east.r2[2], east.r2[1]) }" @click="goto(east.r2[2].tid)">
    						<p><img :src="getSRc(east.r2[2], east.r2[1])"/></p>
    						<p class="team">{{east.r2[2].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(east.r2[3], east.r2[4]) }" @click="goto(east.r2[3].tid)">
    						<p><img :src="getSRc(east.r2[3], east.r2[4])"/></p>
    						<p class="team">{{east.r2[3].name}}</p>
    					</li>
    					<li class="score">{{east.r2[3].score}}-{{east.r2[4].score}}</li>

    					<li :class="{vs_gray: getGray(east.r2[4], east.r2[3]) }" @click="goto(east.r2[4].tid)">
    						<p><img :src="getSRc(east.r2[4], east.r2[3])"/></p>
    						<p class="team">{{east.r2[4].name}}</p>
    					</li>
    				</ul>
    			</div>
    			<!-- 2强 -->
    			<div class="vs-2">
                    <ul>
    					<li :class="{vs_gray: getGray(east.r3[1], east.r3[2]) }" @click="goto(east.r3[1].tid)">
    						<p><img :src="getSRc(east.r3[1], east.r3[2])"/></p>
    						<p class="team">{{east.r3[1].name}}</p>
    					</li>
    					<li class="score">{{east.r3[1].score}}-{{east.r3[2].score}}</li>

    					<li :class="{vs_gray: getGray(east.r3[2], east.r3[1]) }" @click="goto(east.r3[2].tid)">
    						<p><img :src="getSRc(east.r3[2], east.r3[1])"/></p>
    						<p class="team">{{east.r3[2].name}}</p>
    					</li>
    				</ul>
    			</div>
    		</div>
    		<!-- 决赛 -->
    		<div class="vs">
    			<span class="tips">总决赛</span>
                <ul>
                    <li :class="{vs_gray: getGray(east.r4[1], west.r4[1]) }" @click="goto(east.r4[1].tid)">
                        <p><img :src="getSRc(east.r4[1], west.r4[1])"/></p>
                        <p class="team">{{east.r4[1].name}}</p>
                    </li>
                    <li class="score"></li>
                    <li :class="{vs_gray: getGray(west.r4[1], east.r4[1]) }" @click="goto(west.r4[1].tid)">
                        <p><img :src="getSRc(west.r4[1], east.r4[1])"/></p>
                        <p class="team">{{west.r4[1].name}}</p>
                    </li>
                </ul>
    		</div>
    		<!-- 西部 -->
    		<div class="bottom">
    			<!-- 2强 -->
    			<div class="vs-2">
                    <ul>
    					<li :class="{vs_gray: getGray(west.r3[1], east.r3[2]) }" @click="goto(west.r3[1].tid)">
    						<p><img :src="getSRc(west.r3[1], west.r3[2])"/></p>
    						<p class="team">{{west.r3[1].name}}</p>
    					</li>
    					<li class="score">{{west.r3[1].score}}-{{west.r3[2].score}}</li>

    					<li :class="{vs_gray: getGray(west.r3[2], west.r3[1]) }" @click="goto(west.r3[2].tid)">
    						<p><img :src="getSRc(west.r3[2], west.r3[1])"/></p>
    						<p class="team">{{west.r3[2].name}}</p>
    					</li>
    				</ul>
    			</div>
    			<!-- 4强 -->
    			<div class="vs-4">
                    <ul>
    					<li :class="{vs_gray: getGray(west.r2[1], west.r2[2]) }" @click="goto(west.r2[1].tid)">
    						<p><img :src="getSRc(west.r2[1], west.r2[2])"/></p>
    						<p class="team">{{west.r2[1].name}}</p>
    					</li>
    					<li class="score">{{west.r2[1].score}}-{{west.r2[1].score}}</li>
    					<li :class="{vs_gray: getGray(west.r2[2], west.r2[1]) }" @click="goto(west.r2[2].tid)">
    						<p><img :src="getSRc(west.r2[2], west.r2[1])"/></p>
    						<p class="team">{{west.r2[2].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(west.r2[3], west.r2[4]) }" @click="goto(west.r2[3].tid)">
    						<p><img :src="getSRc(west.r2[3], west.r2[4])"/></p>
    						<p class="team">{{west.r2[3].name}}</p>
    					</li>
    					<li class="score">{{west.r2[3].score}}-{{west.r2[4].score}}</li>

    					<li :class="{vs_gray: getGray(west.r2[4], west.r2[3]) }" @click="goto(west.r2[4].tid)">
    						<p><img :src="getSRc(west.r2[4], west.r2[3])"/></p>
    						<p class="team">{{west.r2[4].name}}</p>
    					</li>
    				</ul>
    			</div>
    			<!-- 8强 -->
    			<div class="vs-8">
                    <ul>
    					<li :class="{vs_gray: getGray(west.r1[1], west.r1[8]) }" @click="goto(west.r1[1].tid)">
    						<p>1</p>
    						<p><img :src="getSRc(west.r1[1], west.r1[8])"/></p>
    						<p class="team">{{west.r1[1].name}}</p>
    					</li>
    					<li class="score">{{west.r1[1].score}}-{{west.r1[8].score}}</li>

    					<li :class="{vs_gray: getGray(west.r1[8], west.r1[1]) }" @click="goto(west.r1[8].tid)">
    						<p>8</p>
    						<p><img :src="getSRc(west.r1[8], west.r1[1])"/></p>
    						<p class="team">{{west.r1[8].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(west.r1[4], west.r1[5]) }" @click="goto(west.r1[4].tid)">
    						<p>4</p>
    						<p><img :src="getSRc(west.r1[4], west.r1[5])"/></p>
    						<p class="team">{{west.r1[4].name}}</p>
    					</li>
    					<li class="score">{{west.r1[4].score}}-{{west.r1[5].score}}</li>

    					<li :class="{vs_gray: getGray(west.r1[5], west.r1[4]) }" @click="goto(west.r1[5].tid)">
    						<p>5</p>
    						<p><img :src="getSRc(west.r1[5], west.r1[4])"/></p>
    						<p class="team">{{west.r1[5].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(west.r1[3], west.r1[6]) }" @click="goto(west.r1[3].tid)">
    						<p>3</p>
    						<p><img :src="getSRc(west.r1[3], west.r1[6])"/></p>
    						<p class="team">{{west.r1[3].name}}</p>
    					</li>
    					<li class="score">{{west.r1[3].score}}-{{west.r1[6].score}}</li>

    					<li :class="{vs_gray: getGray(west.r1[6], west.r1[3]) }" @click="goto(west.r1[6].tid)">
    						<p>6</p>
    						<p><img :src="getSRc(west.r1[6], west.r1[3])"/></p>
    						<p class="team">{{west.r1[6].name}}</p>
    					</li>
    				</ul>

                    <ul>
    					<li :class="{vs_gray: getGray(west.r1[2], west.r1[7]) }" @click="goto(west.r1[2].tid)">
    						<p>2</p>
    						<p><img :src="getSRc(west.r1[2], west.r1[7])"/></p>
    						<p class="team">{{west.r1[2].name}}</p>
    					</li>
    					<li class="score">{{west.r1[2].score}}-{{west.r1[7].score}}</li>

    					<li :class="{vs_gray: getGray(west.r1[7], west.r1[2]) }" @click="goto(west.r1[7].tid)">
    						<p>7</p>
    						<p><img :src="getSRc(west.r1[7], west.r1[2])"/></p>
    						<p class="team">{{west.r1[7].name}}</p>
    					</li>
    				</ul>
    			</div>
    		</div>
    	</div>
    </section>
</template>

<script>
import { arraySlice } from 'common/utils'
import { go } from 'common/router'

export default {
    props: {
        east: Object,
        west: Object
    },
    methods: {
        goto( tid ){
            go(`kanqiu://nba/nba/team/${tid}`)
        },
        getSrc(current, other){
            if(current.tid){
                let gray = this.getGray(current, other) ? 'gray' : ''
                return `http://b1.hoopchina.com.cn/games/teams/nba/1_${current.tid}_2x_alpha${gray}.png`
            } else{
                return "http://b1.hoopchina.com.cn/games/teams/nba/nba-none.png"
            }
        },
        getGray(current, other){
            return current.score > other.score && other.score == 4
        }
    }
}
</script>

<style lang="less">
.vs-box-wrap {
	position: relative;
	padding-top: 5px;
	padding-bottom: 5px;
	color: #434141;
	background-color: #eeebeb;

	.vs_gray {
        color: #a9a9b2;
    }
}

.night .vs-box-wrap {
	color: #959595;
	background-color: #1f1f1f;
}

.night .gray {
	color: #5a595f;
}

.night .vs-box li.score {
	color: #434141;
	border-color: #252525;
}

.night .vs ul li.score {
	background-color: #252525;
}

.night .vs-box li, .night .vs-8 ul, .night .vs-box li .team, .night .vs-box .vs{
	background-color: #2c2c2c;
}

.night .vs-box .tips{
	background-color: #992831;
	color: #959595;
}

.vs-box{
	width: 320px;
	margin: 0 auto;
	overflow: hidden;

	img {
		max-width: 100%;
	}
}

// div[class^='vs']:before,div[class^='vs']:after{
// 	 content: "\0020"; display: block; height: 0; overflow: hidden;
// }
// div[class^='vs']:after{
// 	 clear: both;
// }
// div[class^='vs']{
// 	margin-bottom:25px;
// }
// .vs-box-wrap .vs-box {
// 	margin-bottom:0px;
// }
// div[class^='vs'] ul{
// 	float: left;
// }
//
// div[class^='vs'] ul:last-child{
// 	margin-right: 0;
// }
// div[class^='vs'] ul li:last-child{
// 	margin-right: 0;
// }

.vs-box  li{
	width: 37px;
	float: left;
	background: #fff;
	text-align: center;
	font-size: 0.75em;
	position: relative;
	z-index: 2;
	height: 40px;
	padding-top: 5px;
	line-height: 1.2;
}
.vs-box li img{
}

.vs-box li .team{
	position: absolute;
	width:100%;
	background: #fff;
	white-space: nowrap;
	font-size: 10px;
}

.vs-box li.score{
	position: absolute;
	padding-top: 0;
	border: 2px solid #d7d7d7;
	margin-left: 18.5px;
	z-index: 1;
	background: none;
	height: 70px;
}



.top li.score{
	border-top:0;
}

.bottom li.score{
	border-bottom:0;
}


.top .vs-8 li.score{
	margin-top: 5px;
	line-height: 117px;
}
.top li.score{
	margin-top: -10px;
	line-height: 125px;
}

.bottom .vs-8 li.score{
	margin-top: -17px;
	line-height: 1.2;
}
.bottom li.score{
	margin-top: -17px;
}

.bottom .vs-8{margin-bottom: 0;}

.vs-8 ul{
	margin-right: 5px;
	background-color: #fff;
	border-radius: 4px;
	overflow: hidden;
}
.vs-8 li{
	padding-top: 0;
	margin-right: 2px;
	height: 55px;
}
.vs-8 li.score{
	height: 65px;
}

.vs-4 ul{
	margin:0 24px 0 20px;
}
.vs-4 li{
	padding-bottom: 2px;
	margin-right: 44px;
	border-radius: 4px;
	overflow: hidden;
}
.vs-4 li.score{
	width: 78px;
	padding-bottom: 0px;
	border-radius: 0px;
}


.vs-2 ul{
	margin:0 0 0 60px;
}
.vs-2 ul li{
	padding-bottom: 2px;
	margin-right:126px;
	border-radius: 4px;
	overflow: hidden;
}
.vs-2 li.score{
	width: 161px;
	padding-bottom: 0px;
	border-radius: 0px;
}


.vs-box .vs{
	margin-bottom: 41px ;
	width: 110px;
	background: #fff;
	height: 70px;
	position: relative;
	margin-left: 105px;
}
.vs {
	border-radius: 4px;
}
.vs ul{
	margin-top: 18px;
	border-radius: 4px;
	overflow: hidden;
}
.vs ul li{
	width: 55px;
	height: 62px;
}
.vs ul li.score{
	width: 2px;
	border: 0;background: #d7d7d7;
	margin-left: 55px;
	height: 106px;
	margin-top: -29px;
}

.vs-box .tips{
	font-size:12px;background: #ff4252;color: #fff;position: absolute;
	width: 42px;
	padding-left: 2px;
	padding-right: 2px;
	text-align: center;
	height: 24px;
	left: 34px;z-index: 2;
}
</style>
