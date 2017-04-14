{%if $_islogin%}
    <div class="upload-image">
        <div class="title">
            <p>
               <img class="J_bind_addImage" src="./upload_pic_btn.png" alt="">
                最多可上传 6 张图片 
            </p>
            {%if $bbstype == bbsDetail%}
                <span class="J_buttonSubmit">回复</span>
            {%/if%}
        </div>
        <div class="list" id="J_uploadImageWrap">
            <a href="javascript:" class="add-image" dace-node="{%$id4dace%}_image">
                <span class="border-add"></span>
                <span class="border-white">
                    <span class="border-white-bd"></span>
                </span>
                <input type="file" name="files[]" class="button-upload-image J_buttonUploadImage" accept="image/*">
            </a>
        </div>
    </div>
{%/if%}
{%script%}
var uploadImage = require("common:widget/ui/upload-image/upload-image.js");
    uploadImage.init();
{%/script%}