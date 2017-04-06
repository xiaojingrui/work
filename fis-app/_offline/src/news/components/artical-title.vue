<template>
<header class="artical-title">
    <h1 class="headline">{{news.title}}</h1>
    <div class="artical-info">
        <span class="times">{{news.addtime}}</span>

        <span v-if="news.origin">
            <a class="new-source" :href="news.app_url || news.origin_url" v-if="news.origin_url">{{news.origin}}</a>
            <span class="news-source" v-else>{{news.origin}}</span>
        </span>
    </div>
</header>
</template>

<script>
export default {
    props:{
        news: Object
    }
}
</script>

<style lang="less">
.artical-title {
    padding: 10px;
    .headline {
        padding-bottom: 5px;
        font-size: 20px;
        line-height: 1.2;
        font-weight: 700;
        color: #434141;
    }
    .artical-info {
        color: #a9a9b2;
        span {
            margin-right: 5px;
        }
    }
    .new-source {
        color: #025fad;
        -webkit-tap-highlight-color: rgba(30,136,226,.2);
    }
}

.night {
    .artical-title {
        .headline {
            color: #959595;
        }
        .artical-info {
            color: #5a5a5f;
        }
        .new-source {
            color:#3c678c;
        }
    }
}
</style>
