/**
 * @author FHY(yuhongfei@hupu.com)
 * @date 2016-06-12
 * @desc 权限管理模块
 */
import {
    delNewsComment,
    cagUserByNewsComment,
    getReportReason
} from './models'

let parentScope = null

let purview = {
  init: function(popupInstance, scope) {
     parentScope = scope
    //评论删除理由
    let self = this;
    this.getReason(2, function(res) {
      let selectHTML = self.createSelect("J-delete-select", res.result);
      popupInstance.container.find(".delete-ico").append(selectHTML);

      let $target = popupInstance.container.find(".J-delete-select");
      $target.on("change", function(e){
                if($target.val() != 0) {
                  let ncid = popupInstance.getTarget().attr("data-ncid");
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
      let selectHTML = self.createSelect("J-banned-select", res.result);
      popupInstance.container.find(".banned-ico").append(selectHTML);

      let $target = popupInstance.container.find(".J-banned-select");
      $target.on("change", function() {
                if ($target.val() != 0) {
                  let ncid = popupInstance.getTarget().attr("data-ncid");
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
    let opts = [],
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
    getReportReason.bind({type}).execute(({data}) => {
        callback && callback(data);
    })
  },
  /**
   * 管理操作
   * @param type
   */
  adminOperating: function(type, ncid, report_id, callback) {
    let params = {
        ncid: ncid,
        report_id: report_id
    };
    let model = cagUserByNewsComment
    if (type && type == 'delete') {
      model = delNewsComment
    }
    model.bind(params).execute(({data})=>{
        if (typeof data.error !== "undefined") {
          parentScope.$emit("toast", data.error.text);
          return;
        }

        if (type && type == 'delete') {
          parentScope.$emit("toast", '删除成功');
        } else {
          parentScope.$emit("toast", '封禁成功');
        }

        callback && callback();
    })
  }
}

module.exports = purview
