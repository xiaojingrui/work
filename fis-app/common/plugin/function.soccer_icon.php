<?php
/**
 * @desc 通过球队ID拼球队的ICON
 * @params teamId {int} 
 * @returns soccer team icon url {string}
 */
$sizeMap = array(
	  "1" => "24x24",
	  "2" => "87x87",
	  "3" => "110x88"
);
function smarty_function_soccer_icon($params, &$smarty)
{
	$teamId = $params["teamId"];
	$size = $params["size"]?:1;
	$iconUrl = "";
	if(!empty($teamId)){
		$iconUrl = "http://b3.hoopchina.com.cn/material/games/gdc/football/team/$sizeMap[$size]/$teamId.png";
	} 
	return $iconUrl;
}
