<template>
    <section class="olympic">
        <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
        <section class="data-tab" v-if="!isLoading">
        	<ul>
        		<li class="tab-gold-rank" :class="{active: tab == 'gold'}" @click="tab = 'gold'" dace-node="omedal">奖牌榜</li>
        		<li class="tab-men-basketball" :class="{active: tab == 'men-basketball'}" @click="tab = 'men-basketball'" dace-node="omenbasketball">男篮</li>
            <li class="tab-women-basketball" :class="{active: tab == 'women-basketball'}" @click="tab = 'women-basketball'" dace-node="owomenbasketball">女篮</li>
            <li class="tab-men-football" :class="{active: tab == 'men-football'}" @click="tab = 'men-football'" dace-node="omenfootball">男足</li>
            <li class="tab-women-football" :class="{active: tab == 'women-football'}" @click="tab = 'women-football'" dace-node="owomenfootball">女足</li>
        	</ul>
        </section>
        <section class="swiper-container" v-if="!isLoading">
              <olympic-gold-rank :rank.sync="rank" v-if="tab == 'gold'"></olympic-gold-rank>
              <olympic-basketball-rank type="men" index="1" :rank.sync="rank" :against.sync="against" :leaguename.sync="leaguename" v-if="tab == 'men-basketball'"></olympic-basketball-rank>
              <olympic-basketball-rank type="women" index="2" :rank.sync="rank" :against.sync="against" :leaguename.sync="leaguename" v-if="tab == 'women-basketball'"></olympic-basketball-rank>
              <olympic-football-rank type="men" index="3" :rank.sync="rank" :against.sync="against" :leaguename.sync="leaguename" v-if="tab == 'men-football'"></olympic-football-rank>
              <olympic-football-rank type="women" index="4" :rank.sync="rank" :against.sync="against" :leaguename.sync="leaguename" v-if="tab == 'women-football'"></olympic-football-rank>
        </section>
    </section>
</template>

<script>
import { getSoccerolympic } from '../common/models'
import { Loading } from 'components'
import _ from 'underscore'
import { getInfo, sendHideLoading } from 'common/app'
import {
    olympicGoldRank,
    olympicFootballRank,
    olympicBasketballRank
} from '../components'

export default {
    components: {
        Loading,
        olympicGoldRank,
        olympicFootballRank,
        olympicBasketballRank
    },
    data(){
        return {
            tab: '',
            leaguename:'',
            rank: [],
            against: [],
            isLoading: true
        }
    },
    ready(){
        getSoccerolympic.execute(({data}) => {
            this.rank = data.rank;
            this.leaguename = data.league_name;
            this.against = data.against_figure;
            this.tab = 'gold';
            this.isLoading = false;
            sendHideLoading()
        })
    },
    route: {
      data ({to, next}) {

      }
    }
}
</script>

<style lang="less">
@import "../styles/olympic.less";
</style>
