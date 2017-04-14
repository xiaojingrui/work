!function(){

    $('.search-form')
        .delegate(".has-icon", "focus keyup", function(event) {
            if( $(this).val() != '' ){
                $(this).next("em").deleteInfo().css('display','block');
            }else{
                $(this).next("em").css('display','none');
            }
        })
        .delegate(".has-icon", "blur", function(e) {
            var $this = $(this);
            timer = setTimeout(function() {
                if ($this.next("em").css("display") === "block") {
                    $this.next("em").hide()
                }
            }, 150)
        })

    $.fn.deleteInfo = function(){
        return this.each(function(){
            $(this).off('click').on('click',function(event) {
                clearTimeout(timer);
                $(this).prev().val('');
                $(this).hide();
            });
        })
    }

    


}()