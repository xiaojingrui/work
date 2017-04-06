<template>
    <section class="soccer mod-rank-wrap">
        <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
		<football-tab :rank.sync="rank" :pagelasttab.sync="pagelasttab" :tab.sync="tab" :leaguename.sync="leaguename" v-if="!isLoading"></football-tab>
		<section class="swiper-container" v-if="!isLoading">
            <football-tab-standings-rank v-if="tab == 'standings'" :rank.sync="rank" :leaguename.sync="leaguename" :against.sync="against"></football-tab-standings-rank>
            <football-tab-player-rank v-if="tab == 'player'" :rank.sync="rank" :leaguename.sync="leaguename" :night.sync="night"></football-tab-player-rank>
            <football-tab-team-rank v-if="leaguename != 'cl' && tab == 'team' " :rank.sync="rank" :leaguename.sync="leaguename"></football-tab-team-rank>
            <football-tab-transfer-player v-if="tab == 'transfer'" :rank.sync="rank" :leaguename.sync="leaguename" :night.sync="night"></football-tab-team-rank>
		</section>
    </section>
</template>

<script>
import * as SoccerModel from '../common/models'
import _ from 'underscore'
import { Loading } from 'components'
import { getInfo, sendHideLoading } from 'common/app'
import {
    footballTab,
    footballTabStandingsRank,
    footballTabPlayerRank,
    footballTabTeamRank,
    footballTabTransferPlayer
} from '../components'

export default {
    components: {
        Loading,
        footballTab,
        footballTabStandingsRank,
        footballTabPlayerRank,
        footballTabTeamRank,
        footballTabTransferPlayer
    },
    ready(){

    },
    data () {
      return {
        tab : "standings",
        leaguename: "",
        pagelasttab: 0,
        rank: [],
        night: !!getInfo().night,
        against: {},
        isLoading: true
      }
    },
    methods: {

    },
    route: {
      data ({to, next}) {
        this.leaguename = this.$route.path.slice(1)
        const model = SoccerModel[`getSoccer${this.leaguename}`]

        model.execute(({data}) => {
            this.rank = data.rank
            this.pagelasttab = data.pageLastTab
            this.against = _.isArray(data.against_figure) ? {} : data.against_figure;

            //兼容某些奇葩的leaguename
            if(this.leaguename != data.league_name){
                this.leaguename = data.league_name
            }

            this.isLoading = false
            sendHideLoading()
        })
      }
    }
}
</script>

<style lang="less">
@import "../styles/football.less";
</style>
