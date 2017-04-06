<template>
    <dl v-for="item in list"
        class="reply-list"
        :class="{'reply-list-hide': !isUndefined(item.is_hide)}"
        data-hide="{{item.is_hide}}"
        data-ncid="{{item.ncid}}"
        data-uid="{{item.uid}}"
        data-username="{{item.user_name}}"
        data-lighted="{{item.lighted}}">

        <dd class="reply-hide" v-if="!isUndefined(item.is_hide)">
            **该评论被灭过多，已被折叠**
        </dd>
        <dd class="operations-user" v-if="isUndefined(item.is_hide)">
            <div class="user-avatar">
                <a :href="getUserLink(item.puid)">
                    <img :src="item.header" alt="" >
                    <span class="mod-mask mask"></span>
                </a>
            </div>
            <div class="user-info">
                <div class="user-name">
                    <a :href="getUserLink(item.uid)">
                        {{item.user_name}}
                    </a>
                </div>
                <div class="user-other">
                    <span class="times">
                        {{item.format_time}}
                    </span>
                </div>
            </div>
            <div class="operations">
                <a href="javascript:" class="button-light">
                    亮了(<span class="J_ligthCount">{{item.light_count - item.unlight_count}}</span>)
                </a>
            </div>
        </dd>
        <dt class="reply-content" :style="{'font-size': (ft - 2) + 'px'}">
            <div v-if="!isUndefined(item.quote_data)">
                <div class="reply-quote-delete" v-if="!isUndefined(item.quote_data.is_delete)">
                    **该评论涉及违规，已被删除**
                </div>
                <div class="reply-quote-hide" v-if="!isUndefined(item.quote_data.is_hide)">
                    **该评论被灭过多，已被折叠**
                </div>
                <div class="reply-quote-content J_contentParent" :style="{display: item.quote_data.is_hide ? 'block' : 'none'}">
                    <div class="reply-quote-hd">
                        {{item.quote_data.user_name}}
                    </div>

                    <div v-if="!isUndefined(item.quote_data.short_content)">
                        <div class="short-quote-content J_quoteShortContent">
                            {{item.quote_data.short_content}}
                        </div>
                        <div class="reply-quote-bd J_quoteAllContent">
                            {{item.quote_data.content}}
                        </div>
                        <div class="button-open-inner">
                            <a href="javascript:" class="button-open J_buttonOpenAll" title="展开" data-type="replyQuoteButtonOpen" dace-node="comment_expand">显示全部 <s class="arrow"></s></a>
                        </div>
                    </div>
                    <div class="short-quote-content" v-if="isUndefined(item.quote_data.short_content)">
                        {{{item.quote_data.content}}}
                    </div>
               </div>
           </div>

            <div class="current-content J_contentParent J_currentContent">
                <span class="short-content">
                    {{{item.content}}}
                </span>
            </div>
        </dt>
    </dl>
</template>

<script>
import _ from 'underscore'

export default {
    props:{
        list: Array,
        ft: Number
    },
    methods:{
        isUndefined: _.isUndefined,
        getUserLink (puid){
            if(parseInt(puid, 10) > 0){
                return `kanqiu://people/${puid}`
            }else{
                return 'javascript:void(0)'
            }
        }
    },

}
</script>
