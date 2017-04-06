<template>
    <section class="data-tab">
      <ul>
          <li class="tab-team-rank" :class="{active: tab == 'team'}" @click="tab = 'team'" v-text="type === 'nba'?'球队排行':'积分榜'"></li>
          <li class="tab-player-data" :class="{active: tab == 'regular'}" @click="tab = 'regular'" v-if="type === 'nba'">球员数据</li>
          <li class="tab-daily-data"  :class="{active: tab == 'daily'}" @click="tab = 'daily'" v-if="type === 'nba' && lasttab === 'daily'">今日数据</li>
          <li class="tab-hurt-info"  :class="{active: tab == 'injury'}" @click="tab = 'injury'" v-if="type === 'nba' && lasttab === 'daily'">伤停情况</li>
          <li class="tab-trade-info" :class="{active: tab == 'trade'}" @click="tab = 'trade'" v-if="type === 'nba' && lasttab !== 'daily'">签约交易</li>
          <li class="tab-draft-result"  :class="{active: tab == 'draft'}" @click="tab = 'draft'" v-if="type === 'nba' && lasttab !== 'daily'">选秀结果</li>
          <li class="tab-player-data"  :class="{active: tab == 'pre'}" @click="tab = 'pre'" v-if="type !== 'nba'">球员数据</li>
          <li class="tab-daily-data" :class="{active: tab == 'today'}" @click="tab = 'today'" v-if="type !== 'nba'">本轮数据</li>
      </ul>
    </section>
</template>

<script>

export default {
  props: {
    type: String,
    lasttab: String,
    tab: String
  },
  watch: {
      tab (newTab){
          this.$emit("tab-change", newTab)
      }
  }
}
</script>

<style lang="less">
.data-tab {
	padding: 5px 10px;
	font-size: 12px;
	background-color: #fff;
	border-top: 1px solid #f6f5f4;
	border-bottom: 1px solid #f6f5f4;

	ul {
    display: -webkit-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: -moz-flex;
    display: flex;
		line-height: 26px;
		border-radius: 26px;
		background-color: #f6f5f4;
	}

	li {
    -webkit-box-flex: 1;
    -ms-flex: 1;
    -webkit-flex: 1;
    -moz-flex: 1;
    flex: 1;
		display: block;
		text-align: center;
		color: #a9a9b2;
	}
	li.active {
		color: #c01e2f;
		background-color: #fff;
		border: 1px solid #eeebeb;
		border-radius: 26px;
	}
    li>span {
		position: relative;
	}

	.new-tag {
        display: none;
		position: absolute;
		top: -3px;
		right: -16px;
		width: 20px;
		line-height: 9px;
		font-size: 7px;
		font-style: normal;
		color: #fff;
		background-color: #ff4252;
		border-radius: 9px;
	}
}

body.night {
	.data-tab {
		background-color: #2c2c2c;
		border-top-color: #1f1f1f;
		border-bottom-color: #1f1f1f;

		ul {
			background-color: #242424;
		}

		li {
			color: #5a595f;
		}
		li.active {
			color: #99222c;
			background-color: #2c2c2c;
			border-color: #1f1f1f;
		}
        .new-tag {
			background-color: #99222c;
		}
	}
}
</style>
