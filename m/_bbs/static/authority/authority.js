!function(){
    var authForm = {
        init: function(){
            this.form = $('form');
            this.submitBtn = $('.submit-btn');
            this.pwdIpt = $('#password');
            this.pwdWrap = $('.pwd-ipt');
            this.pwdControl = $('.pwd-control');
            this.cancelBtn = $('.cancel-btn');
            this.bind();
        },
        bind: function(){
            var that = this;
            this.pwdControl.click(function(e) {
                if(!$(this).hasClass('cur')){
                    $(this).addClass('cur');
                    that.pwdWrap.html("<input type='text' id='password' name='password' value='"+$('#password').val()+"' />");
                }else{
                    $(this).removeClass('cur');
                    that.pwdWrap.html("<input type='password' id='password' name='password' value='"+$('#password').val()+"' />");
                }
            });

            this.cancelBtn.click(function(event) {
                var _url = $(this).data('link');
                location.href = _url ;
            });

        }
    }
    authForm.init();
}();