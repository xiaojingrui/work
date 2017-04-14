var bbsNav = {
    init: function(){
        // localStorage.clear();

        //判断是否为首页，是的话显示浏览过的板块以及热门板块
        //             不是的话只作为记录作用
        if( HPM.isIndex ){
            if(!HPM.isLogin){
                this.showBoard();
            }else{
                this.showBoardLogin();
            }
        }else{
            this.boardArr = "";
            this.setBoardName();
        }
    },
    setBoardName: function(){

        var _boardName = HPM.boardName;//列表页和详情页所在的版块名称
        if(!_boardName) return;
        var boardJson = HPM.fid +"|"+ HPM.boardName;
        // var boardJson = {
        //     "name": HPM.boardName
        //     "fid": HPM.fid,
        //     "url": HPM.boardLink
        // }
        this.boardArr = this.getBoardName("boardName");
        

        if( !this.boardArr ){

            this.boardArr = boardJson ;

        }else if( this.boardArr.indexOf(_boardName) === -1 ){

            this.boardArr = this.boardArr +','+ boardJson ;
        }
        try{
            localStorage.setItem("boardName", this.boardArr);
        }catch(e){

        }

    },
    getBoardName: function(boardName){
        var result = "";
        try{
            result = localStorage.getItem(boardName);
        } catch(e){
            result = "";
        }
        return result;
    },
    showHotBoard: function(){
        var _hotForum = '';
        var len = HPM.hotForums.length;
        for( var i = 0; i < len; i++){
            _hotForum += '<li><a href="/bbs/'+HPM.hotForums[i].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_1">'+HPM.hotForums[i].name+'</a></li>'
        }
        $('.bbs-recommend-board ul').append(_hotForum);

    },
    showBoard: function(){

        var forumStr = this.getBoardName("boardName") ;//获取localstorage中存储的板块名
        
        var _forumHtml = '';
        var _hotForum = '';

        if(!forumStr){
            this.showHotBoard();
            return;
        }
        // 如果localstorage 有值
        if( forumStr.indexOf(',') ){//为一个值时
            var forumCookieArr = forumStr.split(",");
        }else{
            var forumCookieArr = forumStr;
        }
        var max = forumCookieArr.length >= 12 ? 12 : forumCookieArr.length;
        if(max < 12){
            for( var i = (max-1); i >= 0; i--){
                var _innerArr = forumCookieArr[i].split('|');
                for(var j = 0; j < HPM.hotForums.length;j++){

                    if( HPM.hotForums[j].fid == _innerArr[0] ){
                         HPM.hotForums.splice(j,1);
                    } 
                      
                }
                     
                _forumHtml += '<li><a href="/bbs/'+_innerArr[0]+'" dace-node="'+__daceDataNameOfPage+'_tag_2">'+_innerArr[1]+'</a></li>'
            }
            $('.bbs-recommend-board ul').prepend(_forumHtml);

            if(HPM.hotForums.length){
                for(var k = 0; k < (12-max); k++ ){
                    _hotForum += '<li><a href="/bbs/'+HPM.hotForums[k].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_1">'+HPM.hotForums[k].name+'</a></li>';
                }
            }

            $('.bbs-recommend-board ul').append(_hotForum);

            
        }else{
            for( var i = (max-1); i >= 0; i--){
                var _innerArr = forumCookieArr[i].split('|');

                _forumHtml += '<li><a href="/bbs/'+_innerArr[0]+'" dace-node="'+__daceDataNameOfPage+'_tag_2">'+_innerArr[1]+'</a></li>'
            }
        }
    },
    showBoardLogin: function(){
        var forumStr = this.getBoardName("boardName") ;//获取localstorage中存储的板块名
        var collectLength = HPM.collectedForums.length;//获取收藏板块的长度
        var _forumHtml = '';
        var _hotForum = '';
        var _collectForum = '';
        var that = this;

        if(!forumStr){
            this.showCollectAndHot();
            return;
        }else if(!collectLength){
            this.showVisitedAndHot();
        }else{
            this.showAllBoard();
        }


    },
    showCollectAndHot: function(){
        var collectLength = HPM.collectedForums.length;//获取收藏板块的长度
        var _hotForum = '';
        var _collectForum = '';
        if( collectLength < 12 ){
            for( var i = 0; i < collectLength; i++){
                for(var j = 0; j < HPM.hotForums.length;j++){
                    if( HPM.hotForums[j].fid == HPM.collectedForums[i].fid  ){
                         HPM.hotForums.splice(j,1);
                    } 
                }
                _collectForum += '<li class="collect"><a href="/bbs/'+ HPM.collectedForums[i].fid +'" dace-node="'+__daceDataNameOfPage+'_tag_3">'+HPM.collectedForums[i].name+'</a></li>'
            }
            $('.bbs-recommend-board ul').prepend(_collectForum);

            if(HPM.hotForums.length){
                for(var k = 0; k < (12-collectLength); k++ ){
                    _hotForum += '<li><a href="/bbs/'+HPM.hotForums[k].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_1">'+HPM.hotForums[k].name+'</a></li>';
                }
            }

            $('.bbs-recommend-board ul').append(_hotForum);
        }else{
            for( var i = 0; i < collectLength; i++){
                _collectForum += '<li class="collect"><a href="/bbs/'+ HPM.collectedForums[i].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_3">'+HPM.collectedForums[i].name+'</a></li>'
            }
            $('.bbs-recommend-board ul').append(_collectForum);

        }
    },
    showVisitedAndHot: function(){
        var forumStr = this.getBoardName("boardName") ;//获取localstorage中存储的板块名
        var hotLength = HPM.hotForums.length;//获取热门板块的长度
        var _forumHtml = '';
        var _hotForum = '';

        if( forumStr.indexOf(',') ){//为一个值时
            var forumCookieArr = forumStr.split(",");
            var max = 1;
        }else{
            var forumCookieArr = forumStr;
            var max = forumCookieArr.length >= 3 ? 3 : forumCookieArr.length;
        }

        for( var i = (max-1); i >= 0; i--){
            var _innerArr = forumCookieArr[i].split('|');
            for(var j = 0; j < HPM.hotForums.length;j++){
                if( HPM.hotForums[j].fid == _innerArr[0] ){
                     HPM.hotForums.splice(j,1);
                } 
            }
            
            _forumHtml += '<li><a href="/bbs/'+_innerArr[0]+'" dace-node="'+__daceDataNameOfPage+'_tag_2">'+_innerArr[1]+'</a></li>'
        }
        $('.bbs-recommend-board ul').prepend(_forumHtml);

        if(HPM.hotForums.length){
            for(var k = 0; k < (12-max); k++ ){
                _hotForum += '<li><a href="/bbs/'+HPM.hotForums[k].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_1">'+HPM.hotForums[k].name+'</a></li>';
            }
        }

        $('.bbs-recommend-board ul').append(_hotForum);

    },
    showAllBoard: function(){
        var forumStr = this.getBoardName("boardName") ;//获取localstorage中存储的板块名
        var hotLength = HPM.hotForums.length;//获取热门板块的长度
        var collectLength = HPM.collectedForums.length;//获取收藏板块的长度

        var _forumHtml = '';
        var _hotForum = '';
        var _collectForum = '';

        
        if( forumStr.indexOf(',') ){//为一个值时
            var forumCookieArr = forumStr.split(",");
            var max = 1;
        }else{
            var forumCookieArr = forumStr;
            var max = forumCookieArr.length >= 3 ? 3 : forumCookieArr.length;
        }
        

        for( var i = (max-1); i >= 0; i--){
            var _innerArr = forumCookieArr[i].split('|');
            for(var j = 0; j < HPM.hotForums.length;j++){
                if( HPM.hotForums[j].fid == _innerArr[0] ){
                     HPM.hotForums.splice(j,1);
                } 
            }
            for(var k = 0; k < HPM.collectedForums.length;k++){
                if( HPM.collectedForums[k].fid == _innerArr[0] ){
                     HPM.collectedForums.splice(k,1);
                } 
            }
            
            _forumHtml += '<li><a href="/bbs/'+_innerArr[0]+'" dace-node="'+__daceDataNameOfPage+'_tag_2">'+_innerArr[1]+'</a></li>'
        }
        $('.bbs-recommend-board ul').prepend(_forumHtml);

        if( collectLength + max >= 12 ){
            for(var m = 0; m < (12-max); m++ ){
                _collectForum += '<li class="collect"><a href="/bbs/'+HPM.collectedForums[m].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_3">'+HPM.collectedForums[m].name+'</a></li>';
            }

            $('.bbs-recommend-board ul').append(_collectForum);
        }else{
            for(var m = 0; m < HPM.collectedForums.length; m++ ){
                for(var n = 0; n < HPM.hotForums.length; n++){
                    if( HPM.collectedForums[m].fid == HPM.hotForums[n].fid ){
                        HPM.hotForums.splice(n,1);
                    } 
                }
                _collectForum += '<li class="collect"><a href="/bbs/'+HPM.collectedForums[m].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_3">'+HPM.collectedForums[m].name+'</a></li>';
            }

            $('.bbs-recommend-board ul').append(_collectForum);

            if(HPM.hotForums.length){
                for( var i = 0; i < ( 12 - collectLength - max ); i++){
                    _hotForum += '<li><a href="/bbs/'+ HPM.hotForums[i].fid+'" dace-node="'+__daceDataNameOfPage+'_tag_1">'+HPM.hotForums[i].name+'</a></li>'
                }
            }
            $('.bbs-recommend-board ul').append(_hotForum);

        }

    }

}

module.exports = bbsNav;