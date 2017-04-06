<template>
<div class="vs-wrap" :class="{'euro-bg': leaguename == 'eurocup','america-bg': leaguename == 'amerciacup'}">
	<section class="elimination-game above-game" v-if="leaguename == 'eurocup'">
		<div class="elimination-group" v-for="item in arraySlice(datas[8], 0, 4)">
			<div class="left">
				<a :href="href(item.home_tid)" class="logo">
                    <img :src="logo(item.home_tid, item.win == 2, item.home_logo)" />
				</a>
				<div class="name">{{item.home_name}}</div>
			</div>
			<div class="right">
				<a :href="href(item.away_tid)" class="logo">
                    <img :src="logo(item.away_tid, item.win == 1, item.away_logo)" />
				</a>
				<div class="name">{{item.away_name}}</div>
			</div>
			<div class="soccer">
                {{item.round_1}}
				<i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
			</div>
		</div>
	</section>
	<section class="eight-game above-game">
		<div class="group eight-group" v-for="item in against_figure_4_1()">
			<div class="inner">
                <div class="left">
    				<a :href="href(item.home_tid)" class="logo">
                        <img :src="logo(item.home_tid, item.win == 2, item.home_logo)"/>
    				</a>
    				<div class="name">{{item.home_name}}</div>
    			</div>
    			<div class="right">
    				<a :href="href(item.away_tid)" class="logo">
                        <img :src="logo(item.away_tid, item.win == 1, item.away_logo)"/>
    				</a>
    				<div class="name">{{item.away_name}}</div>
    			</div>
    			<div class="soccer">
                    {{item.round_1}}
    				<i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
    			</div>
			</div>
		</div>
	</section>
	<section class="semi-game above-game">
		<div class="group semi-group" v-for="item in against_figure_2_1()">
			<div class="inner">
                <div class="left">
    				<a :href="href(item.home_tid)" class="logo">
                        <img :src="logo(item.home_tid, item.win == 2, item.home_logo)"/>
    				</a>
    				<div class="name">{{item.home_name}}</div>
    			</div>
    			<div class="right">
    				<a :href="href(item.away_tid)" class="logo">
                        <img :src="logo(item.away_tid, item.win == 1, item.away_logo)"/>
    				</a>
    				<div class="name">{{item.away_name}}</div>
    			</div>
    			<div class="soccer">
                    {{item.round_1}}
    				<i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
    			</div>
			</div>
		</div>
	</section>
	<section class="final-game">
		<div class="group" :class="{'final-group': index == 0, 'third-place-group': index != 0}" v-for="(index, item) in against_figure_1()">
			<div class="inner">
                <div class="left">
    				<a :href="href(item.home_tid)" class="logo">
                        <img :src="logo(item.home_tid, item.win == 2, item.home_logo)"/>
    				</a>
    				<div class="name">{{item.home_name}}</div>
    			</div>
    			<div class="right">
    				<a :href="href(item.away_tid)" class="logo">
                        <img :src="logo(item.away_tid, item.win == 1, item.away_logo)"/>
    				</a>
    				<div class="name">{{item.away_name}}</div>
    			</div>
				<div class="title">{{index == 0 ? '决赛':'3-4名决赛'}}</div>
				<div class="soccer" :style="styleTop(item.round_1 == '未赛')">
                <div :class="{'normal-soccer': item.round_1 != '未赛'}">{{item.round_1}}</div>
				<div v-if="item.round_1 != '未赛' && item.type == 2" class="total-soccer">({{item.round_2}})</div>
				<i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
				</div>
			</div>
		</div>
	</section>
	<section class="semi-game below-game">

		<div class="group semi-group" v-for="(index, item) in against_figure_2_2()">
			<div class="inner">
                <div class="left">
    				<a :href="href(item.home_tid)" class="logo">
                        <img :src="logo(item.home_tid, item.win == 2, item.home_logo)"/>
    				</a>
    				<div class="name">{{item.home_name}}</div>
    			</div>
    			<div class="right">
    				<a :href="href(item.away_tid)" class="logo">
                        <img :src="logo(item.away_tid, item.win == 1, item.away_logo)"/>
    				</a>
    				<div class="name">{{item.away_name}}</div>
    			</div>
    			<div class="soccer">
                    {{item.round_1}}
    				<i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
    			</div>
			</div>
		</div>
	</section>
	<section class="eight-game below-game">
		<div class="group eight-group" v-for="(index, item) in against_figure_4_2()">
			<div class="inner">
                <div class="left">
    				<a :href="href(item.home_tid)" class="logo">
                        <img :src="logo(item.home_tid, item.win == 2, item.home_logo)"/>
    				</a>
    				<div class="name">{{item.home_name}}</div>
    			</div>
    			<div class="right">
    				<a :href="href(item.away_tid)" class="logo">
                        <img :src="logo(item.away_tid, item.win == 1, item.away_logo)"/>
    				</a>
    				<div class="name">{{item.away_name}}</div>
    			</div>
    			<div class="soccer">
                    {{item.round_1}}
    				<i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
    			</div>
			</div>
		</div>
	</section>
	<section class="elimination-game below-game" v-if="leaguename == 'eurocup'">
		<div class="elimination-group" v-for="item in arraySlice(datas[8], 4, 8)">
            <div class="left">
                <a :href="href(item.home_tid)" class="logo">
                    <img :src="logo(item.home_tid, item.win == 2, item.home_logo)"/>
                </a>
                <div class="name">{{item.home_name}}</div>
            </div>
            <div class="right">
                <a :href="href(item.away_tid)" class="logo">
                    <img :src="logo(item.away_tid, item.win == 1, item.away_logo)"/>
                </a>
                <div class="name">{{item.away_name}}</div>
            </div>
            <div class="soccer">
                {{item.round_1}}
                <i v-if="item.round_1 != '未赛' && item.type == 2" class="point"></i>
            </div>
		</div>
	</section>
</div>
</template>

<script>
import { arraySlice } from 'common/utils'

export default {
    props: {
        leaguename: String,
        datas: Object,
        index: {
            type: String,
            default: 0
        }
    },
    methods: {
        arraySlice,
        logo (tid, status, url){
            return tid ? (status ? url.substr(0, url.length - 4) + "_d.png" : url) : 'http://b1.hoopchina.com.cn/games/teams/chlg/no_pic.png'
        },
        href(tid){
            return this.leaguename != 'olympic' ? `kanqiu://soccerleagues/${this.leaguename}/team/${tid}`: 'javascript:;'
        },
        against_figure_4_1(){
            return arraySlice(this.datas[4], 0, 2)
        },
        against_figure_2_1(){
            return arraySlice(this.datas[2], 0, 1)
        },
        against_figure_1(){
            return arraySlice(this.datas[1], 0, 2)
        },
        against_figure_2_2(){
            return arraySlice(this.datas[2], 1, 2)
        },
        against_figure_4_2(){
            return arraySlice(this.datas[4], 2, 4)
        },
        styleTop(status){
            return status ? {top:'42%'}: {}
        }
    },
    route: {
      data ({to, next}) {

      }
    }
}
</script>

<style lang="less">
.america-bg,.euro-bg {
    background-size: 100%;
    background-position: center;
    background-repeat: no-repeat
}

.america-bg {
    background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/vs_soccer_data/america_bg_a89d4f6.png)
}

.euro-bg {
    background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/vs_soccer_data/euro_bg_adcccb8.png)
}

.eight-game .group:before { height: 0 !important;}
.vs-wrap {
    position: relative;
    width: 100%;
    height: auto;
    padding-top: 5px;
    padding-bottom: 5px;
    background-color: #f5f4f3;
    font-size: 9px;
    color: #434141
}

.vs-wrap .logo {
    display: block
}

.vs-wrap img {
    width: 30px
}

.vs-wrap>section:last-child {
    margin-bottom: 0
}

.vs-wrap .elimination-game,.vs-wrap .eight-game,.vs-wrap .semi-game,.vs-wrap .final-game {
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
    height: 50px;
    margin-bottom: 24px
}

.vs-wrap .elimination-game {
    padding: 0 1%
}

.vs-wrap .eight-game {
    padding: 0 6.5%
}

.vs-wrap .semi-game {
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    -webkit-justify-content: center;
    -moz-justify-content: center;
    justify-content: center
}

.vs-wrap .soccer {
    position: absolute;
    left: 10%;
    width: 80%;
    text-align: center
}

.vs-wrap .point {
    position: relative;
    top: 1.5px;
    display: inline-block;
    width: 10px;
    height: 10px;
    font-size: 10px;
    color: #fff;
    background-image: url(/static/match/widget/vs_soccer_data/point_7f0c329.png);
    -webkit-background-size: 100%;
    background-size: 100%
}

.vs-wrap .elimination-group {
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
    position: relative;
    width: 24%;
    text-align: center;
    background-color: #fff;
    border-radius: 4px
}

.vs-wrap .elimination-group>div {
    -webkit-box-flex: 1;
    -ms-flex: 1;
    -webkit-flex: 1;
    -moz-flex: 1;
    flex: 1;
    white-space: nowrap;
    overflow: hidden
}

.vs-wrap .elimination-group:after {
    position: absolute;
    left: 10%;
    content: "";
    width: 80%;
    height: 12px;
    border: 1px solid #d7d7d7
}

.vs-wrap .group {
    position: relative;
    height: 100%;
    text-align: center
}

.vs-wrap .group .inner {
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
    height: 100%
}

.vs-wrap .group .left,.vs-wrap .group .right {
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
    -webkit-box-orient: vertical;
    -ms-flex-direction: column;
    -webkit-flex-direction: column;
    -moz-flex-direction: column;
    flex-direction: column;
    height: 100%;
    white-space: nowrap;
    background-color: #fff;
    border-radius: 4px;
    overflow: hidden
}

.vs-wrap .group:before {
    position: absolute;
    content: "";
    height: 12px;
    border-left: 1px solid #d7d7d7;
    border-right: 1px solid #d7d7d7
}

.vs-wrap .group:after {
    position: absolute;
    content: "";
    height: 12px;
    border: 1px solid #d7d7d7
}

.vs-wrap .eight-group {
    width: 42%
}

.vs-wrap .eight-group .left,.vs-wrap .eight-group .right {
    width: 33.33%
}

.vs-wrap .eight-group:before,.vs-wrap .eight-group:after {
    left: 16%;
    width: 66%
}

.vs-wrap .semi-group {
    width: 61.33%
}

.vs-wrap .semi-group .left,.vs-wrap .semi-group .right {
    width: 19.57%
}

.vs-wrap .semi-group:before,.vs-wrap .semi-group:after {
    left: 9.13%;
    width: 81.74%
}

.vs-wrap .final-game {
    position: relative;
    height: 90px;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    -webkit-justify-content: center;
    -moz-justify-content: center;
    justify-content: center
}

.vs-wrap .final-game .title {
    position: absolute;
    left: 50%;
    top: 0;
    width: 30px;
    margin-left: -15px;
    height: 12px;
    line-height: 12px;
    text-align: center;
    font-size: 12px;
    background-color: #ff4252;
    border-radius: 2px;
    color: #fff;
    z-index: 15
}

.vs-wrap .final-game .soccer {
    top: 35%;
    line-height: 12px;
    z-index: 15
}

.vs-wrap .final-game .normal-soccer {
    font-size: 14px
}

.vs-wrap .final-game .point {
    position: relative;
    left: 50%;
    margin-left: -5px;
    display: block
}

.vs-wrap .final-game .left,.vs-wrap .final-game .right {
    position: relative;
    left: 0;
    top: 0;
    z-index: 10
}

.vs-wrap .final-group {
    width: 35.33%;
    padding-left: 1%;
    padding-right: 1%;
    background-color: #fff;
    border-radius: 4px
}

.vs-wrap .final-group img {
    width: 36px
}

.vs-wrap .final-group .soccer {
    left: 11%
}

.vs-wrap .final-group .left,.vs-wrap .final-group .right {
    width: 34%
}

.vs-wrap .final-group:before,.vs-wrap .final-group:after {
    width: 0;
    border: 0;
    border-left: 1px solid #d7d7d7
}

.vs-wrap .final-group:before {
    top: -12px
}

.vs-wrap .final-group:after {
    bottom: -12px
}

.vs-wrap .third-place-group {
    position: absolute;
    top: 15px;
    right: 1%;
    width: 28%;
    height: auto;
    padding: 12px 0 6px;
    background-color: #fff;
    border-radius: 4px
}

.vs-wrap .third-place-group .left,.vs-wrap .third-place-group .right {
    width: 40%
}

.vs-wrap .third-place-group .soccer {
    left: 10%;
    top: 30%
}

.vs-wrap .third-place-group .normal-soccer {
    font-size: 10px
}

.vs-wrap .third-place-group .title {
    width: 56px;
    background-color: #ff7f7c;
    margin-left: -28px
}

.vs-wrap .third-place-group:before,.vs-wrap .third-place-group:after {
    border: 0
}

.vs-wrap .above-game .elimination-group:after,.vs-wrap .above-game .group:after {
    bottom: -13px;
    border-top: 0
}

.vs-wrap .above-game .soccer {
    bottom: -14px
}

.vs-wrap .above-game .group:before {
    top: -12px
}

.vs-wrap .below-game .elimination-group:after,.vs-wrap .below-game .group:after {
    top: -13px;
    border-bottom: 0
}

.vs-wrap .below-game .soccer {
    top: -13px
}

.vs-wrap .below-game .group:before {
    bottom: -12px
}

.night .vs-wrap {
    background-color: #1f1f1f;
    color: #959595
}

.night .vs-wrap .point {
    background-image: url(/static/match/widget/vs_soccer_data/point_night_b319797.png)
}

.night .vs-wrap .elimination-group {
    background-color: #2c2c2c
}

.night .vs-wrap .elimination-group:after {
    border-color: #252525
}

.night .vs-wrap .group .left,.night .vs-wrap .group .right {
    background-color: #2c2c2c
}

.night .vs-wrap .group:before {
    border-left-color: #252525;
    border-right-color: #252525
}

.night .vs-wrap .group:after {
    border-color: #252525
}

.night .vs-wrap .final-game .title {
    background-color: #992932;
    color: #959595
}

.night .vs-wrap .final-group {
    background-color: #2c2c2c
}

.night .vs-wrap .final-group:before,.night .vs-wrap .final-group:after {
    border-left-color: #252525
}

.night .vs-wrap .third-place-group {
    background-color: #2c2c2c
}

.night .vs-wrap .third-place-group .title {
    background-color: #994816
}
</style>
