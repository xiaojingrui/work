<template>
 <div class="page404">
     <p @click="retry()">页面加载失败，请重试</p>
 </div>
</template>

<script>
export default {
    methods:{
        retry(){
            history.go(-1)
        }
    }
}
</script>

<style scoped>
.page404{
    text-align: center;
    line-height: 2em;
    padding: 8em 0;
}
</style>
