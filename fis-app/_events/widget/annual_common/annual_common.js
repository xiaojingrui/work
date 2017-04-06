var io = require('events:widget/socket-1.4.5/socket.js');
var _ = require("underscore");
var isOnline = true;//~location.href.indexOf("games")
var ip = isOnline ? 'ws://tcp.lb.hoopchina.com:3081' : 'ws://192.168.11.108:3080'
var chatroom = io.connect(ip, {transports:['websocket', 'polling']});

var events = {
    '2000':'hotline',
    '3001':'zhuboline',
    '2001':'gift',
    '2002':'preding',
    '3015':'predadd',
    '3016':'predchange',
    '3017':'predclose',
    '3018':'predopen',
    '3019':'predremove'
}
var common = {
    listener: {},
    init: function(){
        if(this._initStatus) return
        this._initStatus = true

        var self = this
        chatroom.on('connect', function() {
            self.push({
                et: 2004,
                cnt: '房间连接中...'
            });

            chatroom.emit('join', {
                et: 1000,
                token: '',
                via: 5,
                room_id: GM.roomid,
                match_id: 0
            });
        });

        chatroom.on('wall', function(data){
           self.push(data)
        });
    },
    on: function(type, handler){
        if(_.isArray(this.listener[type])){
            this.listener[type].push(handler)
        } else{
            this.listener[type] = [handler]
        }
    },
    fire: function(type, data){
        var handlers = this.listener[type];
    		if(handlers && handlers.length){
    			for(var i=0,len=handlers.length;i<len;i++){
    				handlers[i](data);
    			}
    		}
    },
    push: function(data){
        if(_.isUndefined(data.et)) return;
        var type = events[data.et];
        if(type){
            console.log(type + ":\n\r" + JSON.stringify(data, null, 4))
            this.fire(type, data);
        }
    }
}

module.exports = common
