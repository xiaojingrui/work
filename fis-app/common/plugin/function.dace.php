<?php

function smarty_function_dace($params, &$smarty)
{
	$dacebbsfid = $params["fid"];
	$daceChannel = $params["channel"];
	$daceId = $params["daceid"];
	if(class_exists('DACE')){
		$url = DACE::daceAnalyticsGetImageUrl($dacebbsfid, $daceChannel, $daceId);
		echo '<noscript><link rel="stylesheet" type="text/css" href="'. $url .'"></noscript>';
    }
}