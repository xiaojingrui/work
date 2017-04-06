<template>
    <section class="data-tab">
    	<ul>
    		<li class="tab-standings-rank" :class="{active: tab == 'standings'}" @click="tab = 'standings'" dace-node="{{leaguename}}_standings">
    			<span>
                    {{title0}}
    		        <i v-if="title0 == '球员榜' || title0 == '球队榜'" :class="{'player-tag':title0 == '球员榜','team-tag':title0 == '球队榜'}" class="new-tag">NEW</i>
    			</span>
    		</li>
    		<li class="tab-player-rank" :class="{active: tab == 'player'}" @click="tab = 'player'" dace-node="{{leaguename}}_playerrank">
    			<span>
                    {{title1}}
    		        <i v-if="title1 == '球员榜' || title1 == '球队榜'" :class="{'player-tag':title1 == '球员榜','team-tag':title1 == '球队榜'}" class="new-tag">NEW</i>
    			</span>
    		</li>
    		<li v-if="leaguename !='cl' && leaguename != 'csl_zj'" :class="{active: tab == 'team'}" @click="tab = 'team'" class="tab-team-rank" dace-node="{{leaguename}}_teamrank">
    			<span>
                    {{title2}}
    		        <i v-if="title2 == '球员榜' || title2 == '球队榜'" :class="{'player-tag':title2 == '球员榜','team-tag':title2 == '球队榜'}" class="new-tag">NEW</i>
    			</span>
    		</li>
			<li :class="{active: tab == 'transfer'}" @click="tab = 'transfer'" v-if='pagelasttab == 1 && (leaguename == "csl" || leaguename == "epl" || leaguename == "bund" || leaguename == "liga" || leaguename == "seri" || leaguename == "fran" || leaguename == "fifa")' class="tab-transfer-player" dace-node="{{leaguename}}_transfermarket">
                <span>
                    {{title3}}
    		        <i v-if="title3 == '球员榜' || title3 == '球队榜'" :class="{'player-tag':title3 == '球员榜','team-tag':title3 == '球队榜'}" class="new-tag">NEW</i>
    			</span>
			</li>
    	</ul>
    </section>
</template>

<script>
export default {
    props : {
        tab : String,
        rank: Array,
        leaguename: String,
        pagelasttab: Number
    },
    computed:{
        title0(){
            return this.rank && this.rank.length ? this.rank[0].title : ''
        },
        title1(){
            return this.rank && this.rank.length ? this.rank[1].title : ''
        },
        title2(){
            return this.rank && this.rank.length ? this.rank[2].title : ''
        },
        title3(){
            return this.rank && this.rank.length ? this.rank[3].title : ''
        },
    },
    watch: {
        tab (newTab){
            this.$emit("tab-change", newTab)
        }
    }
}
</script>
