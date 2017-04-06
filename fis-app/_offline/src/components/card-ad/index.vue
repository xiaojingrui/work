<template>
<div class="card-container" v-if="!!url">
  <div class="card-tips"><em>由赞助商提供</em></div>
  <div class="card-spread">
      <a :href="url" dace-node="{{dace}}">
          <div class="pic">
              <img :src="pic" alt=""/>
              <span class="mod-mask mask"></span>
          </div>
          <div class="card-title">
              <span class="tags">广告</span>{{title}}
              <i class="arrow-right"></i>
          </div>
      </a>
  </div>
</div>
</template>

<script>
export default {
    props:{
        url: String,
        dace: String,
        pic: String,
        title: String
    }
}
</script>

<style lang="less">
.card-container{
    padding: 0 10px 10px;
}
.card-tips{
    position: relative;
    text-align: center;
    line-height: 18px;
    height: 18px;
    em{
        background-color: #fff;
        padding:0 10px;
        color: #a9a9b1;
        position: absolute;
        display: inline-block;
        left: 50%;
        width: 80px;
        margin-left: -50px;
        font-style: normal;
        font-size: 12px;
    }
    &:before{
        display: block;
        position: absolute;
        height: 1px;
        content: "";
        background-color: #a9a9b1;
        width: 100%;
        top: 50%;
        left: 0;
        z-index: 0;
    }
}

.card-spread {
    .pic {
        position: relative;
        max-height: 100px;
        overflow: hidden;
        img {
            width: 100%;
        }

        .mask {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
        }
    }
    .card-title {
        position: relative;
        height: 34px;
        line-height: 34px;
        font-size: 16px;
        padding: 0 10px 0 45px;
        border: 1px solid #eeebeb;
        overflow: hidden;
        .tags {
            display: inline-block;
            position: absolute;
            left: 8px;
            top: 9px;
            padding:0 2px;
            font-size: 12px;
            line-height: 1.2;
            border:1px solid #4386d1;
            color: #4386d1;
            border-radius: 3px;
            vertical-align: baseline;
        }
        .arrow-right {
            position: absolute;
            top: 12px;
            right: 10px;
            width: 8px;
            height: 8px;
            overflow: hidden;
            border-right: 1px solid #434141;
            border-bottom: 1px solid #434141;
            -webkit-transform:rotate(-45deg);
            transform:rotate(-45deg)
        }
    }
}

.night{
    .card-tips{
        em{
            background-color: #2c2c2c;
            color: #5a5a5f;
        }
        &:before{
            background-color: #5a5a5f;
        }
    }
    .card-spread {
        .card-title {
            border-color: #1f1f1f;
            color: #959595;
        }
        .tags {
            border-color: #0f5882;
            color: #0f5882;
        }
    }
}
</style>
