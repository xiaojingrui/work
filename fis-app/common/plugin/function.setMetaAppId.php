<?php

function smarty_function_setMetaAppId($params, &$smarty)
{
	$appid = $params["appid"];
	if(class_exists('Context')){
		$app_cookie = Context::C('app_cookie');
		if(!$app_cookie){
			setcookie('app_cookie', NOW_TIME, NOW_TIME + (strtotime(date('Y-m-d',NOW_TIME).' 23:59:59') - NOW_TIME), '/');
			echo '<meta name="apple-itunes-app" content="app-id='. $appid .'" />';
		}
    } else{
    	echo '<meta name="apple-itunes-app" content="app-id='. $appid .'" />';
    }
}