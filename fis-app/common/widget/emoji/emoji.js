var regEm = /<em\sdata-emoji=[\"\'](.*?)[\"\']><\/em>/g;
var reEmojiCode = /^\w+(\_\w+)?$/;
var baseEmojiPath = "//w1.hoopchina.com.cn/hybrid/resource/emojifull/";

var Emoji = {
	//表情图片的最大尺寸
	maxSize: 20,

	trans: function(text){
		var self = this;
		var fontSize = 14;

		//<em data-emoji="1f600"></em>
		text = text.replace(regEm, function(all, emojiCode) {
			if(reEmojiCode.match(emojiCode)){
				return '<img width=' + fontSize + ' class="emoji" style="vertical-align:middle;display:inline;" src="' + baseEmojiPath + emojiCode + '.png">';
			}
			return "";
		});

		return text;
	}
};

module.exports = Emoji;
