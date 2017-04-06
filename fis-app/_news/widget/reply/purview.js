/**
 * @author FHY(yuhongfei@hupu.com)
 * @date 2016-06-12
 * @desc 权限管理模块
 */

var apiUrl = (function() {
  var requestBase = '/' + GM.projectId + '/' + GM.version;
  var client = '?client=' + GM.client;
  return {
    // 删除评论
    delComment: requestBase + '/news/delNewsComment' + client,
    // 封禁
    cagUserComment: requestBase + '/news/cagUserByNewsComment' + client,
    // 举报 删除 封禁理由接口
    getReasons: requestBase + '/report/getMsg' + client
  }
})();

var Toast = require("common:widget/ui-toast/ui-toast.js");

var purview = {
  init: function(popupInstance) {
    //评论删除理由
    var self = this;
    this.getReason(2, function(res) {
      var selectHTML = self.createSelect("J-delete-select", res.result);
      popupInstance.container.find(".delete-ico").append(selectHTML);

      var $target = popupInstance.container.find(".J-delete-select");
      $target.on("change", function(e){
                if($target.val() != 0) {
                  var ncid = popupInstance.getTarget().attr("data-ncid");
                  //删除成功，移除当前评论
                  self.adminOperating('delete', ncid, $target.val(), function(){
                      popupInstance.getTarget().remove();
                  });
                }
             })
             .on("click", function(e){
                e.stopPropagation();
             });
    });

    //评论封禁理由
    this.getReason(3, function(res) {
      var selectHTML = self.createSelect("J-banned-select", res.result);
      popupInstance.container.find(".banned-ico").append(selectHTML);

      var $target = popupInstance.container.find(".J-banned-select");
      $target.on("change", function() {
                if ($target.val() != 0) {
                  var ncid = popupInstance.getTarget().attr("data-ncid");
                  //封禁成功，移除当前评论
                  self.adminOperating('banned', ncid, $target.val(), function(){
                      popupInstance.getTarget().remove();
                  });
                }
              })
              .on("click", function(e){
                e.stopPropagation();
              });
    });
  },
  createSelect: function(selectId, list) {
    var opts = [],
      i = 0,
      len = list.length,
      texts = {
        "J-delete-select": "删除",
        "J-banned-select": "封禁"
      },
      html = [];

    for (; i < len; i++) {
      opts.push("<option value='", list[i].id, "'>", list[i].content, "</option>");
    }

    html = [
      "<select class=", selectId,
      " style='position:absolute;left:0;top:0;width:60px;height:24px;overflow:hidden;opacity:0;display:block;'>",
      "<option value='0' class='firstOption' selected='selected'>请选择",
      texts[selectId], "理由</option>",
      opts.join(""),
      "</select>"
    ];
    return html.join("")
  },
  /**
   * 7.0.8 新增 新闻评论 举报、删除、封禁理由
   * 获取删除和封禁理由
   */
  getReason: function(type, callback) {
    $.ajax({
      url: apiUrl.getReasons,
      type: "GET",
      data: {
        type: type
      },
      success: function(data) {
        callback && callback(data);
      }
    });
  },
  /**
   * 管理操作
   * @param type
   */
  adminOperating: function(type, ncid, report_id, callback) {
    var that = this;
    var data = {
        ncid: ncid,
        token: GM.token,
        report_id: report_id
      },
      url = apiUrl.cagUserComment;

    if (type && type == 'delete') {
      url = apiUrl.delComment;
    }

    $.ajax({
      url: url,
      type: "POST",
      dataType: "json",
      data: data,
      success: function(res) {
        if (typeof res.error !== "undefined") {
          Toast.toast(res.error.text);
          return;
        }

        if (type && type == 'delete') {
          Toast.toast('删除成功');
        } else {
          Toast.toast('封禁成功');
        }

        callback && callback();
      }
    });
  }
}

module.exports = purview;
