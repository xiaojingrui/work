<?php

function smarty_function_dace($params, &$smarty)
{
	$dacebbsfid = $params["fid"];
	$daceChannel = $params["channel"];
	$ptp = $params["daceid"];
	if(class_exists('DACE')){
		$daceAnalytics = DACE::daceAnalyticsGetImageUrl(isset($dacebbsfid)?$dacebbsfid:'', isset($daceChannel)?$daceChannel:'', $ptp);
		$ImageUrl = $daceAnalytics['utmUrl'];
		$inu = $daceAnalytics['inu'];
		echo '<noscript><link rel="stylesheet" type="text/css" href="'. $ImageUrl .'"></noscript>';
		echo "<script>window.inu = '" . $inu . "'</script>";
  }
}
